-- ==============================================================================
-- NatureSphere Auth & Profile Schema Migration
-- ==============================================================================

-- 1. Create Public User Profiles Table
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    full_name TEXT NOT NULL,
    avatar_url TEXT DEFAULT 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80',
    preferred_biome TEXT DEFAULT 'Rainforests & Cloud Forests',
    bio TEXT DEFAULT 'Passionate naturalist and biodiversity explorer.',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Create Saved Nature Destinations & Articles Table (Bookmarks)
CREATE TABLE IF NOT EXISTS public.user_bookmarks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    item_id TEXT NOT NULL,
    item_title TEXT NOT NULL,
    item_category TEXT NOT NULL, -- 'wildlife', 'marine', 'travel', 'wonders'
    item_image TEXT NOT NULL,
    item_location TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    CONSTRAINT unique_user_item UNIQUE (user_id, item_id)
);

-- 3. Enable Row Level Security (RLS) on both tables
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_bookmarks ENABLE ROW LEVEL SECURITY;

-- 4. RLS Policies for Profiles:
-- Anyone can view basic profiles, but only the owner can modify their profile.
CREATE POLICY "Public profiles are viewable by everyone" 
    ON public.profiles FOR SELECT 
    USING (true);

CREATE POLICY "Users can insert their own profile" 
    ON public.profiles FOR INSERT 
    WITH CHECK (auth.uid() = id);

CREATE POLICY "Users can update their own profile" 
    ON public.profiles FOR UPDATE 
    USING (auth.uid() = id)
    WITH CHECK (auth.uid() = id);

-- 5. RLS Policies for Bookmarks:
-- Users can only SELECT, INSERT, and DELETE their own bookmarks.
CREATE POLICY "Users can view only their own bookmarks" 
    ON public.user_bookmarks FOR SELECT 
    USING (auth.uid() = user_id);

CREATE POLICY "Users can add their own bookmarks" 
    ON public.user_bookmarks FOR INSERT 
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can remove their own bookmarks" 
    ON public.user_bookmarks FOR DELETE 
    USING (auth.uid() = user_id);

-- 6. Trigger: Automatically insert a profile row when a new user signs up in auth.users
CREATE OR REPLACE FUNCTION public.handle_new_user() 
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.profiles (id, full_name, avatar_url)
    VALUES (
        NEW.id,
        COALESCE(NEW.raw_user_meta_data->>'full_name', 'Naturalist Explorer'),
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80'
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Drop trigger if previously created, then attach
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
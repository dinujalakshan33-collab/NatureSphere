-- Enable UUID and full-text search extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

-- 1. Supported Languages Registry
CREATE TABLE languages (
    code VARCHAR(10) PRIMARY KEY, -- e.g., 'en', 'si', 'ta', 'ar', 'zh-CN'
    name_native VARCHAR(100) NOT NULL, -- e.g., 'සිංහල', 'தமிழ்', 'العربية'
    name_english VARCHAR(100) NOT NULL,
    direction VARCHAR(3) DEFAULT 'ltr' CHECK (direction IN ('ltr', 'rtl')),
    is_active BOOLEAN DEFAULT true,
    tier INT DEFAULT 2 CHECK (tier IN (1, 2))
);

-- Seed Core Languages
INSERT INTO languages (code, name_native, name_english, direction, tier) VALUES
('en', 'English', 'English', 'ltr', 1),
('si', 'සිංහල', 'Sinhala', 'ltr', 1),
('ta', 'தமிழ்', 'Tamil', 'ltr', 1),
('hi', 'हिन्दी', 'Hindi', 'ltr', 1),
('ar', 'العربية', 'Arabic', 'rtl', 1),
('zh-CN', '简体中文', 'Chinese (Simplified)', 'ltr', 1),
('ja', '日本語', 'Japanese', 'ltr', 1),
('fr', 'Français', 'French', 'ltr', 1),
('es', 'Español', 'Spanish', 'ltr', 1),
('de', 'Deutsch', 'German', 'ltr', 1),
('ur', 'اردو', 'Urdu', 'rtl', 2),
('bn', 'বাংলা', 'Bengali', 'ltr', 2),
('pt', 'Português', 'Portuguese', 'ltr', 2),
('ru', 'Русский', 'Russian', 'ltr', 2),
('sw', 'Kiswahili', 'Swahili', 'ltr', 2);

-- 2. Master Taxonomic Entities (Language Agnostic)
CREATE TABLE nature_entities (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    slug VARCHAR(120) UNIQUE NOT NULL,
    scientific_name VARCHAR(150) NOT NULL, -- Never translated (e.g. Panthera leo)
    category VARCHAR(50) NOT NULL, -- 'wildlife', 'marine', 'flora', 'wonders'
    iucn_status VARCHAR(5) NOT NULL, -- 'CR', 'EN', 'VU', 'NT', 'LC'
    image_url TEXT NOT NULL,
    image_attribution TEXT NOT NULL,
    primary_biome VARCHAR(100) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. Translated Entity Content (Localized Records)
CREATE TYPE translation_status_enum AS ENUM ('verified', 'unreviewed_machine', 'fallback_original');

CREATE TABLE entity_translations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    entity_id UUID REFERENCES nature_entities(id) ON DELETE CASCADE,
    language_code VARCHAR(10) REFERENCES languages(code),
    common_name VARCHAR(150) NOT NULL,
    summary TEXT NOT NULL,
    habitat_description TEXT,
    diet_or_climate TEXT,
    conservation_notes TEXT,
    key_metrics JSONB DEFAULT '{}'::jsonb, -- e.g. {"lifespan": "70+ Years", "weight": "6,000 kg"}
    translation_status translation_status_enum DEFAULT 'unreviewed_machine',
    reviewed_by VARCHAR(120),
    content_hash VARCHAR(64) NOT NULL, -- SHA256 of source content to detect out-of-date translations
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    CONSTRAINT unique_entity_language UNIQUE (entity_id, language_code)
);

-- 4. Full-Text Search Multilingual Index
CREATE INDEX idx_entity_translations_trgm ON entity_translations USING gin (common_name gin_trgm_ops);
CREATE INDEX idx_nature_entities_scientific ON nature_entities USING gin (scientific_name gin_trgm_ops);
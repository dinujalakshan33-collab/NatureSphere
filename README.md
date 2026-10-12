<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0" />
  <title>NatureWorld — Explore Our Living Planet</title>
  
  <!-- Tailwind CSS & Inter Font -->
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@500;700&family=Inter:ital,wght@0,300;0,400;0,500;0,600;0,700;1,400&family=Playfair+Display:ital,wght@0,600;1,400&display=swap" rel="stylesheet">

  <script>
    tailwind.config = {
      darkMode: 'class',
      theme: {
        extend: {
          colors: {
            nwDark: '#0b1d16',
            nwForest: '#123024',
            nwSurface: '#193f31',
            nwAccent: '#2ec4b6',
            nwGold: '#e9c46a',
            nwDanger: '#e76f51',
            nwBlue: '#0f2b38',
            nwDeepOcean: '#091823'
          },
          fontFamily: {
            sans: ['Inter', 'system-ui', 'sans-serif'],
            serif: ['Playfair Display', 'Georgia', 'serif'],
            display: ['Cinzel', 'serif']
          }
        }
      }
    };
  </script>

  <style>
    /* Custom Scrollbar and RTL Tweaks */
    ::-webkit-scrollbar { width: 8px; height: 8px; }
    ::-webkit-scrollbar-track { background: #0b1d16; }
    ::-webkit-scrollbar-thumb { background: #1f4e3c; border-radius: 4px; }
    ::-webkit-scrollbar-thumb:hover { background: #2ec4b6; }
    
    [dir="rtl"] { text-align: right; }
    [dir="rtl"] .space-x-reverse > :not([hidden]) ~ :not([hidden]) {
      --tw-space-x-reverse: 1;
    }
    
    .wave-animation {
      stroke-dasharray: 1000;
      stroke-dashoffset: 1000;
      animation: dash 5s linear infinite alternate;
    }
    @keyframes dash {
      to { stroke-dashoffset: 0; }
    }
  </style>
</head>

<body class="bg-[#f4f7f5] text-slate-800 antialiased font-sans transition-colors duration-300">

  <!-- ================= TOP NOTIFICATION / SYSTEM BAR ================= -->
  <header class="sticky top-0 z-50 bg-white/95 backdrop-blur-md border-b border-emerald-950/10 shadow-sm transition-all">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <div class="flex items-center justify-between h-20 gap-4">
        
        <!-- Brand Logo -->
        <a href="#" class="flex items-center gap-3 shrink-0 group">
          <div class="w-11 h-11 rounded-full bg-emerald-900 flex items-center justify-center text-emerald-300 shadow-md group-hover:bg-emerald-800 transition">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M3.055 11H5a2 2 0 012 2v1a2 2 0 002 2 2 2 0 012 2v2.945M8 3.935V5.5A2.5 2.5 0 0010.5 8h.5a2 2 0 012 2 2 2 0 104 0 2 2 0 012-2h1.064M15 20.488V18a2 2 0 012-2h3.064M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
            </svg>
          </div>
          <div>
            <div class="flex items-center gap-1.5">
              <span class="font-display font-bold text-xl tracking-wide text-emerald-950">NatureWorld</span>
            </div>
            <p class="text-[10px] tracking-widest uppercase font-semibold text-emerald-700" id="i18n-subbrand">Explore Our Living Planet</p>
          </div>
        </a>

        <!-- Desktop Navigation Links -->
        <nav class="hidden xl:flex items-center gap-1 text-[13px] font-medium text-slate-700">
          <button onclick="setTab('all')" class="nav-tab px-3 py-2 rounded-lg hover:text-emerald-900 hover:bg-emerald-50 transition active-tab text-emerald-900 font-semibold" data-tab="all" id="nav-all">Explore</button>
          <button onclick="setTab('wildlife')" class="nav-tab px-3 py-2 rounded-lg hover:text-emerald-900 hover:bg-emerald-50 transition" data-tab="wildlife" id="nav-wildlife">Wild Animals</button>
          <button onclick="setTab('marine')" class="nav-tab px-3 py-2 rounded-lg hover:text-emerald-900 hover:bg-emerald-50 transition" data-tab="marine" id="nav-marine">Marine Life</button>
          <button onclick="setTab('flora')" class="nav-tab px-3 py-2 rounded-lg hover:text-emerald-900 hover:bg-emerald-50 transition" data-tab="flora" id="nav-flora">Flora & Rainforests</button>
          <button onclick="setTab('wonders')" class="nav-tab px-3 py-2 rounded-lg hover:text-emerald-900 hover:bg-emerald-50 transition" data-tab="wonders" id="nav-wonders">Natural Wonders</button>
          <button onclick="setTab('conservation')" class="nav-tab px-3 py-2 rounded-lg hover:text-emerald-900 hover:bg-emerald-50 transition" data-tab="conservation" id="nav-conservation">Conservation</button>
        </nav>

        <!-- Right Quick Controls: Search, Lang, Mobile Menu -->
        <div class="flex items-center gap-2 sm:gap-3">
          
          <!-- Global Search Input in Header -->
          <div class="relative hidden md:block w-48 lg:w-60">
            <input 
              type="text" 
              id="top-search" 
              oninput="handleSearch(this.value)"
              placeholder="Search taxa, habitats..." 
              class="w-full pl-9 pr-3 py-1.5 text-xs bg-slate-100 border border-slate-200 rounded-full focus:outline-none focus:ring-2 focus:ring-emerald-700 text-slate-800 placeholder-slate-400"
            />
            <svg class="w-4 h-4 absolute left-3 top-2 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
            </svg>
          </div>

          <!-- Language Selector -->
          <div class="relative">
            <select 
              id="language-selector" 
              onchange="changeLanguage(this.value)"
              class="text-xs font-medium bg-emerald-50 text-emerald-950 border border-emerald-200 rounded-lg px-2.5 py-1.8 h-9 focus:ring-2 focus:ring-emerald-700 cursor-pointer shadow-sm outline-none"
            >
              <option value="en">English (EN)</option>
              <option value="si">සිංහල (Sinhala)</option>
              <option value="ta">தமிழ் (Tamil)</option>
              <option value="hi">हिन्दी (Hindi)</option>
              <option value="ar">العربية (Arabic - RTL)</option>
              <option value="zh">中文 (Chinese)</option>
              <option value="ja">日本語 (Japanese)</option>
              <option value="fr">Français (French)</option>
              <option value="es">Español (Spanish)</option>
              <option value="de">Deutsch (German)</option>
            </select>
          </div>

          <!-- Join Conservation CTA -->
          <button onclick="openModal('pledgeModal')" class="hidden sm:inline-flex items-center gap-1.5 px-4 py-2 text-xs font-semibold tracking-wide text-white bg-emerald-900 hover:bg-emerald-950 rounded-lg shadow transition active:scale-95" id="btn-join">
            <svg class="w-3.5 h-3.5 text-emerald-300" fill="currentColor" viewBox="0 0 20 20">
              <path fill-rule="evenodd" d="M3.172 5.172a4 4 0 015.656 0L10 6.343l1.172-1.171a4 4 0 115.656 5.656L10 17.657l-6.828-6.829a4 4 0 010-5.656z" clip-rule="evenodd" />
            </svg>
            <span id="txt-join">Join Conservation</span>
          </button>

          <!-- Mobile Hamburger -->
          <button onclick="toggleMobileNav()" class="xl:hidden p-2 rounded-lg text-slate-700 hover:bg-slate-100">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"/>
            </svg>
          </button>
        </div>

      </div>
    </div>

    <!-- Mobile Navigation Drawer -->
    <div id="mobile-nav" class="hidden xl:hidden border-t border-slate-200 bg-white px-4 pt-3 pb-6 space-y-2">
      <input 
        type="text" 
        oninput="handleSearch(this.value)"
        placeholder="Search taxa, parks, flowers..." 
        class="w-full px-4 py-2 text-sm bg-slate-100 rounded-lg mb-3 outline-none"
      />
      <div class="grid grid-cols-2 gap-2 text-sm">
        <button onclick="setTab('all'); toggleMobileNav()" class="text-left px-3 py-2 rounded-md hover:bg-emerald-50 text-emerald-900 font-medium">Explore All</button>
        <button onclick="setTab('wildlife'); toggleMobileNav()" class="text-left px-3 py-2 rounded-md hover:bg-emerald-50 text-slate-700 font-medium">Wild Animals</button>
        <button onclick="setTab('marine'); toggleMobileNav()" class="text-left px-3 py-2 rounded-md hover:bg-emerald-50 text-slate-700 font-medium">Marine Life</button>
        <button onclick="setTab('flora'); toggleMobileNav()" class="text-left px-3 py-2 rounded-md hover:bg-emerald-50 text-slate-700 font-medium">Flora & Forests</button>
        <button onclick="setTab('wonders'); toggleMobileNav()" class="text-left px-3 py-2 rounded-md hover:bg-emerald-50 text-slate-700 font-medium">Natural Wonders</button>
        <button onclick="setTab('conservation'); toggleMobileNav()" class="text-left px-3 py-2 rounded-md hover:bg-emerald-50 text-slate-700 font-medium">Conservation</button>
      </div>
    </div>
  </header>

  <!-- ================= HERO SECTION (MATCHING SCREENSHOT 1 & 2) ================= -->
  <section class="relative bg-gradient-to-b from-[#0b2019] via-[#0f2d23] to-[#143a2d] text-white pt-16 pb-20 overflow-hidden">
    <!-- Atmospheric background grid & glow -->
    <div class="absolute inset-0 opacity-15 pointer-events-none" style="background-image: radial-gradient(#2ec4b6 1px, transparent 1px); background-size: 28px 28px;"></div>
    
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
      
      <!-- Codex Header Pill -->
      <div class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-emerald-950/80 border border-emerald-500/30 text-emerald-300 text-xs tracking-wider uppercase font-medium mb-5">
        <span class="w-2 h-2 rounded-full bg-emerald-400 animate-pulse"></span>
        <span id="hero-tag">Terrestrial Fauna & Hydro-Biosphere Codex</span>
        <span class="text-emerald-500/50">•</span>
        <span class="text-emerald-200/70" id="hero-subtag">Vol. IV : Global Ecosystems</span>
      </div>

      <!-- Main Headline -->
      <h1 class="font-serif text-3xl sm:text-5xl lg:text-6xl font-bold tracking-tight text-white mb-4 max-w-4xl leading-tight" id="hero-title">
        Wild Animals & Living Wonders of the Earth
      </h1>
      
      <p class="text-emerald-100/80 text-sm sm:text-base lg:text-lg max-w-3xl leading-relaxed mb-10 font-light" id="hero-desc">
        From apex predators reigning over open grasslands to secretive montane ghosts, coral bastions, and ancient trees—explore the terrestrial and oceanic keystone species orchestrating our living biosphere.
      </p>

      <!-- Key Global Metrics Pill (As seen in Screenshot 1) -->
      <div class="grid grid-cols-2 md:grid-cols-4 gap-3 max-w-4xl bg-black/30 backdrop-blur-md p-4 sm:p-5 rounded-2xl border border-white/10">
        <div class="border-l-2 border-emerald-400 pl-3">
          <p class="text-[10px] uppercase font-semibold text-emerald-300/80 tracking-wider" id="m-taxa-label">Monitored Taxa</p>
          <div class="flex items-baseline gap-1 mt-0.5">
            <span class="text-2xl font-bold tracking-tight text-white">14,280</span>
            <span class="text-emerald-400 font-bold">+</span>
          </div>
          <p class="text-[11px] text-emerald-200/60" id="m-taxa-sub">Terrestrial & Aquatic</p>
        </div>

        <div class="border-l-2 border-teal-400 pl-3">
          <p class="text-[10px] uppercase font-semibold text-teal-300/80 tracking-wider" id="m-biomes-label">Primary Biomes</p>
          <div class="flex items-baseline gap-1 mt-0.5">
            <span class="text-2xl font-bold tracking-tight text-white">8 Global</span>
          </div>
          <p class="text-[11px] text-emerald-200/60" id="m-biomes-sub">Equatorial to Pelagic</p>
        </div>

        <div class="border-l-2 border-amber-400 pl-3">
          <p class="text-[10px] uppercase font-semibold text-amber-300/80 tracking-wider" id="m-iucn-label">IUCN Red List Focus</p>
          <div class="flex items-baseline gap-1 mt-0.5">
            <span class="text-2xl font-bold tracking-tight text-white">41%</span>
          </div>
          <p class="text-[11px] text-emerald-200/60" id="m-iucn-sub">Under active surveillance</p>
        </div>

        <div class="border-l-2 border-cyan-400 pl-3">
          <p class="text-[10px] uppercase font-semibold text-cyan-300/80 tracking-wider" id="m-ranger-label">Protected Patrol</p>
          <div class="flex items-baseline gap-1 mt-0.5">
            <span class="text-2xl font-bold tracking-tight text-white">3.2M</span>
            <span class="text-xs text-cyan-300 font-bold">km²</span>
          </div>
          <p class="text-[11px] text-emerald-200/60" id="m-ranger-sub">Protected wilderness</p>
        </div>
      </div>

    </div>
  </section>

  <!-- ================= DYNAMIC EXPLORATION CATALOG SECTION ================= -->
  <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
    
    <!-- Filter Control Bar (Recreated from Screenshot) -->
    <div class="bg-white rounded-2xl shadow-sm border border-slate-200/80 p-4 mb-8">
      <div class="flex flex-col lg:flex-row items-stretch lg:items-center justify-between gap-4">
        
        <!-- Search Field -->
        <div class="relative flex-1">
          <input 
            type="text" 
            id="filter-search" 
            oninput="handleSearch(this.value)"
            placeholder="Search by common name, genus, country or park..." 
            class="w-full pl-10 pr-4 py-2.5 text-sm bg-slate-50 border border-slate-200 rounded-xl focus:ring-2 focus:ring-emerald-700 focus:bg-white outline-none transition"
          />
          <svg class="w-4 h-4 absolute left-3.5 top-3.5 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
          </svg>
        </div>

        <!-- Filter Selects -->
        <div class="grid grid-cols-2 sm:grid-cols-3 gap-2">
          
          <!-- Category / Biome Filter -->
          <select id="biome-filter" onchange="applyFilters()" class="text-xs bg-slate-50 border border-slate-200 rounded-xl px-3 py-2.5 font-medium text-slate-700 outline-none">
            <option value="all">All Biomes</option>
            <option value="wildlife">Wild Fauna</option>
            <option value="marine">Pelagic & Reefs</option>
            <option value="flora">Flora & Trees</option>
            <option value="birds">Birds & Insects</option>
            <option value="wonders">Wonders & Parks</option>
          </select>

          <!-- Threat Status Filter -->
          <select id="status-filter" onchange="applyFilters()" class="text-xs bg-slate-50 border border-slate-200 rounded-xl px-3 py-2.5 font-medium text-slate-700 outline-none">
            <option value="all">All Threat Statuses</option>
            <option value="CR">Critically Endangered</option>
            <option value="EN">Endangered</option>
            <option value="VU">Vulnerable</option>
            <option value="NT">Near Threatened</option>
            <option value="LC">Least Concern</option>
          </select>

          <!-- Continent / Region Filter -->
          <select id="region-filter" onchange="applyFilters()" class="col-span-2 sm:col-span-1 text-xs bg-slate-50 border border-slate-200 rounded-xl px-3 py-2.5 font-medium text-slate-700 outline-none">
            <option value="all">Global Continents</option>
            <option value="Africa">Africa</option>
            <option value="Asia">Asia</option>
            <option value="Americas">Americas</option>
            <option value="Oceania">Oceania</option>
            <option value="Europe">Europe</option>
            <option value="Oceans">Global Oceans</option>
          </select>
        </div>

        <!-- Layout View Toggle -->
        <div class="flex items-center gap-1 bg-slate-100 p-1 rounded-xl self-end lg:self-center shrink-0">
          <button id="view-mosaic" onclick="setView('mosaic')" class="flex items-center gap-1.5 px-3 py-1.5 text-xs font-semibold rounded-lg bg-white shadow-sm text-emerald-950 transition">
            <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"/></svg>
            <span>Mosaic</span>
          </button>
          <button id="view-encyclo" onclick="setView('encyclo')" class="flex items-center gap-1.5 px-3 py-1.5 text-xs font-semibold rounded-lg text-slate-600 hover:text-emerald-950 transition">
            <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 10h16M4 14h16M4 18h16"/></svg>
            <span>Encyclopedia</span>
          </button>
        </div>

      </div>

      <!-- Live Results Metadata Bar -->
      <div class="flex flex-wrap items-center justify-between text-xs text-slate-500 pt-3 mt-3 border-t border-slate-100">
        <div class="flex items-center gap-2">
          <span>Viewing: <strong id="specimen-count" class="text-emerald-950 font-bold">12</strong> cataloged entities</span>
          <span>•</span>
          <span class="text-emerald-700 font-medium">Verified Taxonomy: IUCN Red List 2025.2</span>
        </div>
        <div class="flex items-center gap-2">
          <span>Sort by:</span>
          <span class="font-semibold text-slate-800">Trophic Impact & Rarity</span>
        </div>
      </div>
    </div>

    <!-- SPECIMENS GRID CONTAINER -->
    <div id="specimens-container" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
      <!-- Injected via JavaScript from rich live taxonomy database -->
    </div>

  </main>

  <!-- ================= LIVE BIO-TELEMETRY & SENSOR SECTION (AS IN SCREENSHOT 1) ================= -->
  <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
    <div class="bg-gradient-to-r from-[#eef6f2] via-[#e6f0eb] to-[#e1eee6] rounded-3xl p-6 sm:p-10 border border-emerald-900/10 shadow-sm">
      <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-center">
        
        <div class="lg:col-span-5 space-y-4">
          <div class="inline-flex items-center gap-2 text-[11px] font-bold tracking-widest uppercase text-emerald-800">
            <span class="w-2 h-2 rounded-full bg-emerald-600"></span>
            Bio-Telemetry & Habitat Telemetry
          </div>
          <h2 class="font-serif text-2xl sm:text-3xl font-bold text-slate-900 leading-tight">
            How Field Naturalists Track Terrestrial & Oceanic Biomes
          </h2>
          <p class="text-sm text-slate-600 leading-relaxed">
            Through solar GPS collars, non-invasive scat DNA sequencing, edge-AI bioacoustic sensor arrays, and ocean hydrophones, international wildlife coalitions preserve migration corridors and halt poaching in real time.
          </p>
          <div class="flex flex-wrap gap-4 pt-2 text-xs font-semibold text-emerald-900">
            <span class="inline-flex items-center gap-1.5 bg-white/80 px-3 py-1.5 rounded-lg border border-emerald-900/10 shadow-xs">
              <svg class="w-4 h-4 text-emerald-600" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" strok# NatureSphere

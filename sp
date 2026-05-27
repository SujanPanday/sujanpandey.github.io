<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>AusPropertyIQ — Smart Suburb Finder</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;500;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
<style>
:root {
  --bg: #0b0f14;
  --surface: #131820;
  --surface2: #1a2230;
  --border: rgba(255,255,255,0.07);
  --accent: #00d4a0;
  --accent2: #ff6b35;
  --accent3: #4da6ff;
  --text: #e8edf2;
  --muted: #6b7a8d;
  --strong: #27b389;
  --cond: #3d8ef0;
  --watch: #e08c2a;
  --avoid: #e04a4a;
  --font-head: 'Syne', sans-serif;
  --font-body: 'DM Sans', sans-serif;
}
*{box-sizing:border-box;margin:0;padding:0}
html{scroll-behavior:smooth}
body{background:var(--bg);color:var(--text);font-family:var(--font-body);font-size:14px;min-height:100vh;overflow-x:hidden}

/* ── NOISE TEXTURE ── */
body::before{content:"";position:fixed;inset:0;background-image:url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)' opacity='0.04'/%3E%3C/svg%3E");pointer-events:none;z-index:0;opacity:.4}

/* ── HERO ── */
.hero{position:relative;padding:5rem 2rem 3.5rem;text-align:center;overflow:hidden;z-index:1}
.hero-glow{position:absolute;top:-80px;left:50%;transform:translateX(-50%);width:700px;height:400px;background:radial-gradient(ellipse at center,rgba(0,212,160,0.12) 0%,transparent 70%);pointer-events:none}
.hero-tag{display:inline-block;font-family:var(--font-head);font-size:10px;font-weight:600;letter-spacing:.15em;text-transform:uppercase;color:var(--accent);border:1px solid rgba(0,212,160,.3);border-radius:20px;padding:4px 14px;margin-bottom:1.5rem}
h1{font-family:var(--font-head);font-size:clamp(2.2rem,6vw,4.2rem);font-weight:800;line-height:1.05;letter-spacing:-.02em;margin-bottom:1rem}
h1 span{color:var(--accent)}
.hero-sub{font-size:15px;color:var(--muted);max-width:540px;margin:0 auto 2rem;line-height:1.7}
.criteria-pills{display:flex;flex-wrap:wrap;gap:8px;justify-content:center;margin-bottom:2.5rem}
.pill{font-size:11px;font-weight:500;padding:5px 13px;border-radius:20px;background:var(--surface2);border:1px solid var(--border);color:var(--muted)}
.pill strong{color:var(--text)}

/* ── STATS BAR ── */
.stats-bar{display:flex;flex-wrap:wrap;justify-content:center;gap:1px;background:var(--border);border:1px solid var(--border);border-radius:14px;overflow:hidden;max-width:700px;margin:0 auto 3rem;position:relative;z-index:1}
.stat{flex:1;min-width:120px;background:var(--surface);padding:1.2rem 1rem;text-align:center}
.stat-n{font-family:var(--font-head);font-size:2rem;font-weight:700}
.stat-l{font-size:11px;color:var(--muted);margin-top:3px}
.stat-n.green{color:var(--accent)}
.stat-n.blue{color:var(--accent3)}
.stat-n.amber{color:var(--watch)}
.stat-n.red{color:var(--avoid)}

/* ── MAIN LAYOUT ── */
main{max-width:1200px;margin:0 auto;padding:0 1.5rem 4rem;position:relative;z-index:1}

/* ── CONTROLS ── */
.controls{background:var(--surface);border:1px solid var(--border);border-radius:14px;padding:1.25rem 1.5rem;margin-bottom:1.5rem;display:flex;flex-wrap:wrap;gap:10px;align-items:center}
.controls input,.controls select{background:var(--bg);border:1px solid var(--border);border-radius:8px;color:var(--text);font-family:var(--font-body);font-size:13px;padding:8px 12px;outline:none;transition:border-color .2s}
.controls input:focus,.controls select:focus{border-color:var(--accent)}
.controls select option{background:var(--bg)}
.controls input{width:200px}
.ctrl-label{font-size:11px;color:var(--muted);font-weight:500;text-transform:uppercase;letter-spacing:.07em}
.result-count{font-size:12px;color:var(--muted);margin-left:auto}
.reset-btn{background:transparent;border:1px solid var(--border);color:var(--muted);border-radius:8px;padding:8px 14px;font-family:var(--font-body);font-size:12px;cursor:pointer;transition:all .2s}
.reset-btn:hover{border-color:var(--accent);color:var(--accent)}

/* filter toggle chips */
.filter-chips{display:flex;flex-wrap:wrap;gap:6px}
.fchip{font-size:11px;font-weight:600;padding:5px 12px;border-radius:20px;border:1px solid var(--border);background:transparent;color:var(--muted);cursor:pointer;transition:all .18s;font-family:var(--font-body)}
.fchip:hover{border-color:var(--accent);color:var(--accent)}
.fchip.active-all{border-color:var(--accent);background:rgba(0,212,160,.1);color:var(--accent)}
.fchip.active-strong{border-color:var(--strong);background:rgba(39,179,137,.1);color:var(--strong)}
.fchip.active-cond{border-color:var(--cond);background:rgba(61,142,240,.1);color:var(--cond)}
.fchip.active-watch{border-color:var(--watch);background:rgba(224,140,42,.1);color:var(--watch)}
.fchip.active-avoid{border-color:var(--avoid);background:rgba(224,74,74,.1);color:var(--avoid)}

/* ── SORT BAR ── */
.sort-bar{display:flex;gap:6px;flex-wrap:wrap;margin-bottom:1rem;align-items:center}
.sort-label{font-size:11px;color:var(--muted);text-transform:uppercase;letter-spacing:.07em}
.sort-btn{font-size:11px;padding:5px 11px;border-radius:6px;border:1px solid var(--border);background:transparent;color:var(--muted);cursor:pointer;font-family:var(--font-body);transition:all .18s}
.sort-btn:hover,.sort-btn.active{background:var(--surface2);color:var(--text);border-color:rgba(255,255,255,.15)}

/* ── GRID ── */
.grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(340px,1fr));gap:14px}

/* ── CARD ── */
.card{background:var(--surface);border:1px solid var(--border);border-radius:14px;overflow:hidden;transition:transform .2s,border-color .2s;cursor:pointer;position:relative}
.card:hover{transform:translateY(-3px);border-color:rgba(255,255,255,.14)}
.card.strong-buy{border-top:2px solid var(--strong)}
.card.conditional{border-top:2px solid var(--cond)}
.card.watch{border-top:2px solid var(--watch)}
.card.avoid{border-top:2px solid var(--avoid)}

.card-head{padding:1rem 1.2rem .8rem;display:flex;justify-content:space-between;align-items:flex-start;gap:8px}
.card-name{font-family:var(--font-head);font-size:16px;font-weight:700;line-height:1.1;margin-bottom:3px}
.card-loc{font-size:11px;color:var(--muted)}
.state-badge{font-size:10px;font-weight:700;padding:2px 8px;border-radius:4px;letter-spacing:.05em;flex-shrink:0;margin-top:2px}
.badge-nsw{background:rgba(77,166,255,.15);color:#4da6ff}
.badge-qld{background:rgba(255,107,53,.15);color:#ff6b35}
.badge-vic{background:rgba(0,212,160,.15);color:#00d4a0}
.badge-wa{background:rgba(180,100,255,.15);color:#b464ff}
.badge-sa{background:rgba(255,210,50,.15);color:#ffd232}
.badge-tas{background:rgba(100,180,255,.15);color:#64b4ff}

.card-metrics{display:grid;grid-template-columns:repeat(3,1fr);gap:1px;background:var(--border);border-top:1px solid var(--border);border-bottom:1px solid var(--border)}
.metric{background:var(--surface);padding:.65rem .8rem;text-align:center}
.metric-val{font-family:var(--font-head);font-size:15px;font-weight:700}
.metric-val.g{color:var(--strong)}
.metric-val.a{color:var(--watch)}
.metric-val.r{color:var(--avoid)}
.metric-lbl{font-size:9px;color:var(--muted);margin-top:2px;text-transform:uppercase;letter-spacing:.06em}

.card-criteria{padding:.8rem 1.2rem;display:grid;grid-template-columns:repeat(3,1fr);gap:5px}
.crit-item{display:flex;align-items:center;gap:5px;font-size:11px}
.crit-dot{width:7px;height:7px;border-radius:50%;flex-shrink:0}
.crit-dot.pass{background:var(--strong)}
.crit-dot.fail{background:var(--avoid)}
.crit-dot.warn{background:var(--watch)}
.crit-text{color:var(--muted);line-height:1.3}
.crit-text strong{color:var(--text)}

.card-footer{padding:.7rem 1.2rem;display:flex;justify-content:space-between;align-items:center;border-top:1px solid var(--border)}
.verdict{font-size:11px;font-weight:600;padding:3px 10px;border-radius:12px}
.verdict.strong-buy{background:rgba(39,179,137,.15);color:var(--strong)}
.verdict.conditional{background:rgba(61,142,240,.15);color:var(--cond)}
.verdict.watch{background:rgba(224,140,42,.15);color:var(--watch)}
.verdict.avoid{background:rgba(224,74,74,.15);color:var(--avoid)}
.score-dots{display:flex;gap:3px}
.sdot{width:9px;height:9px;border-radius:50%}
.sdot.filled{background:var(--accent)}
.sdot.empty{background:var(--surface2);border:1px solid var(--border)}

.card-note{padding:0 1.2rem .9rem;font-size:11px;color:var(--muted);line-height:1.6;border-top:1px solid var(--border);padding-top:.7rem;display:none}
.card.expanded .card-note{display:block}
.expand-hint{font-size:10px;color:var(--muted);position:absolute;bottom:8px;right:12px;opacity:.5}

/* price tag */
.price-tag{font-size:11px;font-weight:600;color:var(--muted);background:var(--surface2);padding:2px 8px;border-radius:4px}

/* ── SECTION HEADER ── */
.section-head{font-family:var(--font-head);font-size:13px;font-weight:600;color:var(--muted);text-transform:uppercase;letter-spacing:.1em;margin:2rem 0 .8rem;display:flex;align-items:center;gap:10px}
.section-head::after{content:"";flex:1;height:1px;background:var(--border)}

/* ── FOOTER ── */
footer{text-align:center;padding:2rem;font-size:11px;color:var(--muted);border-top:1px solid var(--border);position:relative;z-index:1}
footer a{color:var(--accent);text-decoration:none}

/* ── NO RESULTS ── */
.no-res{text-align:center;padding:4rem 2rem;color:var(--muted);font-size:14px}
.no-res span{display:block;font-size:2.5rem;margin-bottom:1rem}

/* ── MOBILE ── */
@media(max-width:600px){
  .grid{grid-template-columns:1fr}
  .controls input{width:100%}
  h1{font-size:2rem}
  .stat-n{font-size:1.5rem}
}

/* ── ANIMATIONS ── */
@keyframes fadeUp{from{opacity:0;transform:translateY(18px)}to{opacity:1;transform:translateY(0)}}
.hero>*{animation:fadeUp .6s ease both}
.hero-tag{animation-delay:.05s}
h1{animation-delay:.1s}
.hero-sub{animation-delay:.17s}
.criteria-pills{animation-delay:.22s}
.stats-bar{animation-delay:.28s}
.card{animation:fadeUp .4s ease both}
</style>
</head>
<body>

<!-- HERO -->
<div class="hero">
  <div class="hero-glow"></div>
  <div class="hero-tag">Australian Property Intelligence</div>
  <h1>Find Your<br><span>Next Investment</span></h1>
  <p class="hero-sub">Every suburb scored across 6 hard criteria — yield, growth, vacancy, supply, migration & economic diversification. No fluff, just data.</p>
  <div class="criteria-pills">
    <div class="pill"><strong>①</strong> Yield &gt;4.5%</div>
    <div class="pill"><strong>②</strong> Growth ≥7% p.a.</div>
    <div class="pill"><strong>③</strong> Vacancy &lt;2%</div>
    <div class="pill"><strong>④</strong> Low supply (DSR/SoM)</div>
    <div class="pill"><strong>⑤</strong> Positive net migration</div>
    <div class="pill"><strong>⑥</strong> Diversified economy</div>
  </div>
  <div class="stats-bar" id="statsBar">
    <div class="stat"><div class="stat-n green" id="sStrong">—</div><div class="stat-l">Strong Buy</div></div>
    <div class="stat"><div class="stat-n blue" id="sCond">—</div><div class="stat-l">Conditional</div></div>
    <div class="stat"><div class="stat-n amber" id="sWatch">—</div><div class="stat-l">Watch</div></div>
    <div class="stat"><div class="stat-n red" id="sAvoid">—</div><div class="stat-l">Avoid</div></div>
    <div class="stat"><div class="stat-n" id="sTotal">—</div><div class="stat-l">Total Suburbs</div></div>
  </div>
</div>

<main>
  <!-- CONTROLS -->
  <div class="controls">
    <div>
      <div class="ctrl-label" style="margin-bottom:5px">Search</div>
      <input type="text" id="searchInput" placeholder="Suburb or city…">
    </div>
    <div>
      <div class="ctrl-label" style="margin-bottom:5px">State</div>
      <select id="stateFilter">
        <option value="">All states</option>
        <option value="NSW">NSW</option>
        <option value="QLD">QLD</option>
        <option value="VIC">VIC</option>
        <option value="WA">WA</option>
        <option value="SA">SA</option>
        <option value="TAS">TAS</option>
      </select>
    </div>
    <div>
      <div class="ctrl-label" style="margin-bottom:5px">Verdict</div>
      <div class="filter-chips">
        <button class="fchip active-all" data-v="all" onclick="setVerdict('all',this)">All</button>
        <button class="fchip" data-v="strong-buy" onclick="setVerdict('strong-buy',this)">Strong Buy</button>
        <button class="fchip" data-v="conditional" onclick="setVerdict('conditional',this)">Conditional</button>
        <button class="fchip" data-v="watch" onclick="setVerdict('watch',this)">Watch</button>
        <button class="fchip" data-v="avoid" onclick="setVerdict('avoid',this)">Avoid</button>
      </div>
    </div>
    <div>
      <div class="ctrl-label" style="margin-bottom:5px">Max price</div>
      <select id="priceFilter">
        <option value="">Any budget</option>
        <option value="500000">Under $500k</option>
        <option value="600000">Under $600k</option>
        <option value="650000">Under $650k</option>
      </select>
    </div>
    <button class="reset-btn" onclick="resetAll()">Reset filters</button>
    <div class="result-count" id="resultCount"></div>
  </div>

  <!-- SORT -->
  <div class="sort-bar">
    <span class="sort-label">Sort by</span>
    <button class="sort-btn" onclick="setSort('score')">Score</button>
    <button class="sort-btn" onclick="setSort('growth')">Growth</button>
    <button class="sort-btn" onclick="setSort('yield_')">Yield</button>
    <button class="sort-btn" onclick="setSort('vac')">Vacancy</button>
    <button class="sort-btn" onclick="setSort('price')">Price</button>
    <button class="sort-btn" onclick="setSort('suburb')">Name</button>
  </div>

  <!-- GRID -->
  <div class="grid" id="grid"></div>
  <div class="no-res" id="noRes" style="display:none"><span>🔍</span>No suburbs match your filters — try broadening your search.</div>
</main>

<footer>
  Built with data from PropTrack, CoreLogic, SQM Research, Hotspotting &amp; DSR Market Matcher &nbsp;·&nbsp; <a href="#">AusPropertyIQ</a> &nbsp;·&nbsp; For research purposes only — not financial advice
</footer>

<script>
const SUBURBS = [
  // ── ROCKHAMPTON ──
  {suburb:"Allenstown",city:"Rockhampton",state:"QLD",price:564400,yield_:5.11,growth:22,vac:0.51,dsr:54,migPos:true,ecoDiv:true,eco:"Defence / Health / Ag / Services",note:"Top pick. All 6 criteria met. Very tight vacancy, excellent yield, strong growth. Flood check required on some streets before buying."},
  {suburb:"Berserker",city:"Rockhampton",state:"QLD",price:580500,yield_:4.96,growth:22,vac:0.79,dsr:55,migPos:true,ecoDiv:true,eco:"Defence / Health / Ag / Services",note:"Best value entry point in Rockhampton. All criteria met. Older Queenslander stock — factor maintenance costs. Flood check required."},
  {suburb:"Park Avenue",city:"Rockhampton",state:"QLD",price:590600,yield_:5.17,growth:24,vac:0.61,dsr:58,migPos:true,ecoDiv:true,eco:"Defence / Health / Ag / Services",note:"SPI FAST 50 listed. Highest growth in Rocky. Approaching $600k — move before budget ceiling hit. Flood check required."},
  {suburb:"Koongal",city:"Rockhampton",state:"QLD",price:546500,yield_:5.03,growth:13,vac:0.77,dsr:54,migPos:true,ecoDiv:true,eco:"Defence / Health / Ag / Services",note:"Solid but slower growth than peers. Good defensive play within Rocky. Flood check required."},
  {suburb:"Frenchville",city:"Rockhampton",state:"QLD",price:635000,yield_:4.79,growth:16,vac:1.0,dsr:56,migPos:true,ecoDiv:true,eco:"Defence / Health / Ag / Services",note:"Premium Rocky suburb. Median approaching $640k — harder to find sub-$650k stock. Yield borderline. Better suited to $700k+ budget."},
  {suburb:"Rockhampton City",city:"Rockhampton",state:"QLD",price:456100,yield_:6.02,growth:20,vac:0.95,dsr:50,migPos:true,ecoDiv:true,eco:"Defence / Health / Ag / Services",note:"Cheapest entry in Rocky with highest yield at 6%. DSR 50 is borderline — supply slightly looser but fundamentals strong."},
  // ── GERALDTON ──
  {suburb:"Rangeway",city:"Geraldton",state:"WA",price:377000,yield_:7.4,growth:45,vac:0.6,dsr:57,migPos:true,ecoDiv:false,eco:"Mining / Port / Services",note:"Best raw numbers on entire list — 7.4% yield, 45% growth, $377k. Economy is mining-concentrated which adds risk. Outstanding value if comfortable with WA resource cycle."},
  {suburb:"Spalding",city:"Geraldton",state:"WA",price:565600,yield_:5.16,growth:23,vac:0.59,dsr:57,migPos:true,ecoDiv:false,eco:"Mining / Port / Services",note:"Strong across all metrics. DSR data confirms tight supply. Mining concentration is the only flag. 23% growth and 5.16% yield is a compelling combination."},
  {suburb:"Wonthella",city:"Geraldton",state:"WA",price:587500,yield_:5.22,growth:18,vac:0.34,dsr:58,migPos:true,ecoDiv:false,eco:"Mining / Port / Services",note:"Very tight vacancy at 0.34%. Solid yield and growth. Same mining-economy caveat as other Geraldton suburbs."},
  {suburb:"Beachlands",city:"Geraldton",state:"WA",price:555000,yield_:5.1,growth:24,vac:0.6,dsr:56,migPos:true,ecoDiv:false,eco:"Mining / Port / Services",note:"24% growth, 5.1% yield, and coastal lifestyle appeal. All metrics strong. Mining economy risk applies."},
  {suburb:"Waggrakine",city:"Geraldton",state:"WA",price:590000,yield_:5.4,growth:19,vac:0.6,dsr:57,migPos:true,ecoDiv:false,eco:"Mining / Port / Services",note:"Growing coastal suburb. Strong yield and low vacancy. Newer housing stock than older Geraldton suburbs."},
  {suburb:"Sunset Beach",city:"Geraldton",state:"WA",price:650000,yield_:5.3,growth:27,vac:1.2,dsr:56,migPos:true,ecoDiv:false,eco:"Mining / Port / Services",note:"Premium coastal suburb. 27% growth is outstanding. Vacancy slightly higher at 1.2%. At your $650k budget ceiling."},
  // ── WAGGA WAGGA ──
  {suburb:"Glenfield Park",city:"Wagga Wagga",state:"NSW",price:645000,yield_:4.7,growth:18,vac:0.9,dsr:56,migPos:true,ecoDiv:true,eco:"Defence / Uni / Health / Ag / Services",note:"Best suburb in Wagga for your criteria. 18% growth, 4.7% yield, vacancy under 1%. Most diversified economy on entire list — very safe long-term hold."},
  {suburb:"Ashmont",city:"Wagga Wagga",state:"NSW",price:485000,yield_:5.1,growth:18,vac:2.8,dsr:55,migPos:true,ecoDiv:true,eco:"Defence / Uni / Health / Ag / Services",note:"Cheapest entry in Wagga with best yield. 18% growth. Note vacancy at 2.8% is above your 2% threshold — only fail. Strong long-term fundamentals due to diversified economy."},
  {suburb:"Forest Hill",city:"Wagga Wagga",state:"NSW",price:575500,yield_:5.0,growth:8,vac:3.1,dsr:56,migPos:true,ecoDiv:true,eco:"Defence / RAAF base / Services",note:"RAAF base suburb. Defence employment anchor is strong. Vacancy at 3.1% fails your criterion. Growth modest at 8%. Watch but don't rush."},
  {suburb:"Kooringal",city:"Wagga Wagga",state:"NSW",price:610500,yield_:4.9,growth:8,vac:3.2,dsr:55,migPos:true,ecoDiv:true,eco:"Defence / Uni / Health / Ag / Services",note:"Most popular suburb by sales volume (183 sales). Solid fundamentals but vacancy at 3.2% fails criterion. Growth below 7% threshold."},
  {suburb:"Gobbagombalin",city:"Wagga Wagga",state:"NSW",price:815000,yield_:4.3,growth:11,vac:0.5,dsr:54,migPos:true,ecoDiv:true,eco:"Defence / Uni / Health / Ag / Services",note:"Over $650k budget. Excellent vacancy at 0.5% but price and yield don't fit your criteria. Premium suburb for higher budget investors."},
  // ── TOWNSVILLE ──
  {suburb:"Kirwan",city:"Townsville",state:"QLD",price:490000,yield_:5.2,growth:25,vac:0.9,dsr:59,migPos:true,ecoDiv:true,eco:"Defence / Health / Uni / Port / Tourism",note:"TOP RECOMMENDATION. All 6 criteria met. Propertyology ranked Townsville Australia's #1 capital growth prospect. Selling in 13 days. Defence, JCU, and hospital create reliable diversified demand."},
  {suburb:"Hyde Park",city:"Townsville",state:"QLD",price:470000,yield_:5.5,growth:24,vac:0.9,dsr:58,migPos:true,ecoDiv:true,eco:"Defence / Health / Uni / Port / Tourism",note:"Strong all-round. Close to hospital and CBD. Good tenant demand from healthcare workers. 5.5% yield is excellent for the price point."},
  {suburb:"Heatley",city:"Townsville",state:"QLD",price:604100,yield_:4.71,growth:20,vac:0.56,dsr:59,migPos:true,ecoDiv:true,eco:"Defence / Health / Uni / Port / Tourism",note:"DSR confirmed at 59. 0.56% vacancy is excellent. Yield borderline but passes at 4.71%. Solid suburb with strong owner-occupier demand."},
  {suburb:"Garbutt",city:"Townsville",state:"QLD",price:674600,yield_:4.73,growth:20,vac:0.19,dsr:57,migPos:true,ecoDiv:true,eco:"Defence / Health / Uni / Port / Tourism",note:"Exceptional 0.19% vacancy — near zero. Over $650k but worth noting for higher budget. Defence base proximity drives rental demand."},
  {suburb:"Rasmussen",city:"Townsville",state:"QLD",price:618600,yield_:4.74,growth:20,vac:0.28,dsr:58,migPos:true,ecoDiv:true,eco:"Defence / Health / Uni / Port / Tourism",note:"0.28% vacancy is crisis-tight. Near Lavarack Barracks. Consistent defence rental demand. 20% growth confirmed across Townsville."},
  // ── TOOWOOMBA ──
  {suburb:"Harristown",city:"Toowoomba",state:"QLD",price:480000,yield_:5.1,growth:17,vac:0.65,dsr:58,migPos:true,ecoDiv:true,eco:"Ag / Logistics / Inland Rail / Services",note:"Toowoomba has crisis-level vacancy at 0.65%. Inland Rail project is a structural long-term economic driver. Harristown is affordable and high-yielding."},
  {suburb:"Glenvale",city:"Toowoomba",state:"QLD",price:520000,yield_:4.9,growth:15,vac:0.65,dsr:57,migPos:true,ecoDiv:true,eco:"Ag / Logistics / Inland Rail / Services",note:"Growing outer suburb. New estates attracting families. Inland Rail construction workers driving rental demand. Strong fundamentals."},
  {suburb:"Newtown (units)",city:"Toowoomba",state:"QLD",price:435000,yield_:5.1,growth:15,vac:0.65,dsr:58,migPos:true,ecoDiv:true,eco:"Ag / Logistics / Inland Rail / Services",note:"Best Toowoomba entry point for units. 5.1% yield, affordable price. Often overlooked vs coastal QLD — that is the opportunity. Rents up 9.1% in 12 months."},
  // ── MACKAY ──
  {suburb:"North Mackay",city:"Mackay",state:"QLD",price:480000,yield_:6.2,growth:17,vac:0.6,dsr:57,migPos:true,ecoDiv:false,eco:"Mining / Agriculture / Port",note:"Outstanding 6.2% yield. 0.6% vacancy and 17% growth make this a strong performer. Mining-influenced economy is the only flag — larger population base (128k) than Geraldton reduces concentration risk."},
  {suburb:"West Mackay",city:"Mackay",state:"QLD",price:450000,yield_:5.8,growth:17,vac:0.6,dsr:56,migPos:true,ecoDiv:false,eco:"Mining / Agriculture / Port",note:"Affordable entry into Mackay market. High yield, tight vacancy. Similar economy diversification caveat to North Mackay but strong cashflow play."},
  {suburb:"Slade Point",city:"Mackay",state:"QLD",price:642300,yield_:5.44,growth:17,vac:0.83,dsr:57,migPos:true,ecoDiv:false,eco:"Mining / Agriculture / Port",note:"DSR confirmed at 57. Coastal suburb with 5.44% yield. Vacancy 0.83% is excellent. Growth 17%. At upper end of budget."},
  // ── DUBBO ──
  {suburb:"Mitchell (Dubbo)",city:"Dubbo",state:"NSW",price:460000,yield_:5.8,growth:20,vac:1.5,dsr:56,migPos:true,ecoDiv:true,eco:"Health / Ag / Aviation / Logistics / Education",note:"NSW's #1 growth city (20%). Yields up to 7% in inner suburbs. Vacancy at 1.5% is borderline but passes. Well-diversified economy — health, ag, aviation, logistics, education."},
  {suburb:"Whylandra (Dubbo)",city:"Dubbo",state:"NSW",price:480000,yield_:6.2,growth:20,vac:1.5,dsr:55,migPos:true,ecoDiv:true,eco:"Health / Ag / Aviation / Logistics / Education",note:"Highest yield suburb within Dubbo at 6.2%. 20% growth makes this one of the best NSW opportunities. Inland Rail will boost further."},
  // ── BUNDABERG ──
  {suburb:"Bundaberg North",city:"Bundaberg",state:"QLD",price:660000,yield_:5.40,growth:13,vac:0.43,dsr:57,migPos:true,ecoDiv:true,eco:"Ag / Services / Healthcare",note:"DSR confirmed. 0.43% vacancy is extremely tight. Yield 5.4% solid. Growth 13% passes threshold. City population growing at 1.9% pa."},
  {suburb:"Norville",city:"Bundaberg",state:"QLD",price:616100,yield_:5.08,growth:13,vac:0.57,dsr:59,migPos:true,ecoDiv:true,eco:"Ag / Services / Healthcare",note:"Better Bundaberg suburb than Kepnok. DSR 59 is strong. 0.57% vacancy, 5.08% yield. All criteria pass. Kepnok should be swapped for this."},
  {suburb:"Millbank",city:"Bundaberg",state:"QLD",price:647100,yield_:4.99,growth:13,vac:0.12,dsr:60,migPos:true,ecoDiv:true,eco:"Ag / Services / Healthcare",note:"Highest DSR in Bundaberg at 60. Incredible 0.12% vacancy — essentially zero. Yield just under 5%. Exceptionally tight supply makes this compelling."},
  // ── MILDURA ──
  {suburb:"Mildura",city:"Mildura",state:"VIC",price:531000,yield_:4.8,growth:18,vac:1.1,dsr:55,migPos:false,ecoDiv:false,eco:"Agriculture / Wine / Citrus",note:"Strong growth (18%) and tight vacancy (1.1%). Two weak points: very low net migration (0.13% pa) and ag-heavy economy. Worth pursuing with eyes open on the migration flag."},
  // ── SHEPPARTON ──
  {suburb:"Shepparton",city:"Shepparton",state:"VIC",price:495000,yield_:5.1,growth:6,vac:1.4,dsr:53,migPos:true,ecoDiv:false,eco:"Agriculture / Food Processing",note:"Good yield and tight supply but growth at 6.4% falls just below 7% threshold. Watchlist — leading indicators are tightening. Check again in 6 months."},
  // ── WA STANDOUTS FROM DSR ──
  {suburb:"Narrogin",city:"Narrogin",state:"WA",price:485600,yield_:6.20,growth:27,vac:0.66,dsr:56,migPos:true,ecoDiv:true,eco:"Agriculture / Services",note:"Exceptional performer from DSR data. 27% growth, 6.2% yield, 0.66% vacancy, selling in 11 days. All 6 criteria met. Small town (10k pop) — liquidity risk if selling. High reward."},
  {suburb:"Collie",city:"Collie",state:"WA",price:578700,yield_:6.16,growth:32,vac:0.82,dsr:60,migPos:true,ecoDiv:false,eco:"Coal / Energy Transition",note:"32% growth and 6.16% yield are extraordinary. DSR 60 is very strong. Coal town in energy transition — high short-term reward but structural risk as coal sector winds down. High risk, high reward."},
  {suburb:"Manjimup",city:"Manjimup",state:"WA",price:621600,yield_:5.58,growth:24,vac:0.29,dsr:61,migPos:true,ecoDiv:true,eco:"Agriculture / Forestry / Tourism / Truffles",note:"Hidden gem from DSR data. Highest DSR on the WA list at 61. 24% growth, 5.58% yield, 0.29% vacancy. Genuinely diversified — ag, forestry, tourism, truffles. All 6 criteria met."},
  {suburb:"Northam",city:"Northam",state:"WA",price:496400,yield_:5.44,growth:22,vac:0.28,dsr:59,migPos:true,ecoDiv:true,eco:"Agriculture / Services / Rail",note:"Underrated WA inland town. 22% growth, 5.44% yield, only 0.28% vacancy. DSR 59. Diversified ag/services/rail economy. Under $500k. Strong all-round performer."},
  {suburb:"Mount Barker",city:"Mount Barker",state:"WA",price:615000,yield_:4.92,growth:20,vac:0.03,dsr:59,migPos:true,ecoDiv:true,eco:"Agriculture / Wine / Tourism",note:"0.03% vacancy is the lowest on this entire list — essentially no rental vacancy whatsoever. Great Southern wine region. 20% growth. Diversified economy. All criteria met."},
  // ── KALGOORLIE (high yield, sector risk) ──
  {suburb:"Kalgoorlie",city:"Kalgoorlie",state:"WA",price:489000,yield_:8.48,growth:16,vac:0.62,dsr:54,migPos:true,ecoDiv:false,eco:"Mining-heavy (gold)",note:"Extraordinary 8.48% yield — highest cashflow play on the list. 16% growth and 0.62% vacancy. Pure mining town = high sector concentration risk. Best for cash flow investors who understand the gold market cycle."},
  {suburb:"South Kalgoorlie",city:"Kalgoorlie",state:"WA",price:464900,yield_:8.40,growth:16,vac:0.36,dsr:59,migPos:true,ecoDiv:false,eco:"Mining-heavy (gold)",note:"Cheapest Kalgoorlie suburb with 8.4% yield. DSR 59 is strong. Only 0.36% vacancy. Same mining-sector concentration caveat. Best entry point for the Kalgoorlie play."},
  {suburb:"Piccadilly",city:"Kalgoorlie",state:"WA",price:494400,yield_:8.32,growth:16,vac:0.20,dsr:58,migPos:true,ecoDiv:false,eco:"Mining-heavy (gold)",note:"0.20% vacancy is exceptionally tight. 8.32% yield. All metrics impressive but single-industry risk remains. Strong cashflow but volatile long-term."},
  {suburb:"Somerville",city:"Kalgoorlie",state:"WA",price:606000,yield_:8.64,growth:16,vac:0.53,dsr:57,migPos:true,ecoDiv:false,eco:"Mining-heavy (gold)",note:"Highest yield on entire list at 8.64%. Most expensive Kalgoorlie suburb. Strong cashflow for resource-sector investors."},
  {suburb:"Hannans",city:"Kalgoorlie",state:"WA",price:630000,yield_:8.28,growth:16,vac:0.56,dsr:56,migPos:true,ecoDiv:false,eco:"Mining-heavy (gold)",note:"Named after famed gold prospector Paddy Hannan. 8.28% yield. Upper end of budget. Mining-sector concentration risk."},
  // ── NSW DSR STANDOUTS ──
  {suburb:"Narrabri",city:"Narrabri",state:"NSW",price:576000,yield_:6.09,growth:13,vac:0.86,dsr:55,migPos:true,ecoDiv:false,eco:"Agriculture / Cotton / Gas",note:"Highest NSW yield in the DSR data at 6.09%. Strong growth 13%, low vacancy 0.86%. Gas and cotton concentration adds sector risk. Worth researching."},
  {suburb:"Inverell",city:"Inverell",state:"NSW",price:507000,yield_:5.22,growth:12,vac:0.37,dsr:58,migPos:true,ecoDiv:true,eco:"Agriculture / Sapphires / Services",note:"DSR 58, 0.37% vacancy, 5.22% yield. New England region. Genuine gem of the DSR list — affordable, tight supply, decent growth. Diversified enough with ag, mining (sapphires), and services."},
  {suburb:"Grafton",city:"Grafton",state:"NSW",price:550200,yield_:5.29,growth:12,vac:0.36,dsr:60,migPos:true,ecoDiv:true,eco:"Agriculture / Timber / Services",note:"DSR 60 — equal highest NSW DSR. 0.36% vacancy, 5.29% yield, 12% growth. Flood-affected city (2022 floods) — check flood map but fundamentals are strong."},
  {suburb:"South Grafton",city:"Grafton",state:"NSW",price:534400,yield_:5.30,growth:12,vac:0.39,dsr:60,migPos:true,ecoDiv:true,eco:"Agriculture / Timber / Services",note:"DSR 60. Cheaper entry than Grafton proper. Same strong metrics. Flood check essential."},
  {suburb:"Narromine",city:"Narromine",state:"NSW",price:525300,yield_:6.33,growth:11,vac:1.44,dsr:54,migPos:true,ecoDiv:true,eco:"Agriculture / Aviation / Soaring",note:"Highest NSW yield in DSR data at 6.33%. Unique town known for glider aviation. Vacancy 1.44% passes. Growth 11% passes. DSR borderline at 54."},
  {suburb:"Cootamundra",city:"Cootamundra",state:"NSW",price:463700,yield_:5.52,growth:10,vac:0.21,dsr:57,migPos:true,ecoDiv:true,eco:"Agriculture / Rail / Services",note:"Very affordable at $463k. 0.21% vacancy is extremely tight. 5.52% yield. Don Bradman's birthplace. Growth 10% meets threshold."},
  // ── QLD DSR STANDOUTS ──
  {suburb:"Goondiwindi",city:"Goondiwindi",state:"QLD",price:633000,yield_:5.04,growth:14,vac:0.14,dsr:60,migPos:true,ecoDiv:false,eco:"Agriculture / Cotton",note:"0.14% vacancy — second lowest on entire list. DSR 60. 5.04% yield, 14% growth. Agriculture-dominant economy is the main risk. Exceptionally tight rental market."},
  {suburb:"Roma",city:"Roma",state:"QLD",price:510000,yield_:5.78,growth:15,vac:0.11,dsr:55,migPos:true,ecoDiv:false,eco:"Gas / Agriculture",note:"0.11% vacancy — lowest on the entire list. 5.78% yield, 15% growth. Gas town with ag base. High cashflow potential but energy sector concentration. Remarkable supply tightness."},
  {suburb:"Wondai",city:"Wondai",state:"QLD",price:537600,yield_:5.03,growth:13,vac:0.04,dsr:59,migPos:true,ecoDiv:false,eco:"Agriculture / Forestry",note:"0.04% vacancy is extraordinary — near-zero. DSR 59. South Burnett region. Ag/forestry economy is relatively concentrated but vacancy tightness is unmatched."},
  {suburb:"East Innisfail",city:"Innisfail",state:"QLD",price:545900,yield_:5.51,growth:16,vac:0.07,dsr:54,migPos:true,ecoDiv:true,eco:"Agriculture / Tourism / Tropical",note:"0.07% vacancy essentially zero. 5.51% yield, 16% growth. Tropical North Queensland town. Sugar cane and tourism. Cyclone risk is a factor to assess."},
  {suburb:"Emerald",city:"Emerald",state:"QLD",price:598700,yield_:5.54,growth:15,vac:0.58,dsr:54,migPos:true,ecoDiv:false,eco:"Mining / Agriculture",note:"Central Highlands mining and ag hub. 5.54% yield, 15% growth, 0.58% vacancy. Mining-concentrated but larger service base than pure mining towns."},
  // ── SA ──
  {suburb:"Loxton",city:"Loxton",state:"SA",price:451000,yield_:4.69,growth:11,vac:0.10,dsr:63,migPos:true,ecoDiv:false,eco:"Agriculture / Irrigation / Wine",note:"Highest DSR on the ENTIRE list at 63. 0.10% vacancy is remarkable. Very affordable at $451k. Yield just under threshold at 4.69% — borderline. Riverland SA — ag-heavy economy."},
  {suburb:"Port Lincoln",city:"Port Lincoln",state:"SA",price:644200,yield_:4.72,growth:14,vac:0.22,dsr:59,migPos:true,ecoDiv:true,eco:"Fishing / Tourism / Agriculture",note:"Tuna capital of Australia. 0.22% vacancy, 14% growth. Diversified fishing/tourism/ag economy. At your budget ceiling. Strong lifestyle appeal driving demand."},
  // ── TAS (noted as avoid) ──
  {suburb:"Glenorchy",city:"Hobart",state:"TAS",price:676400,yield_:4.93,growth:5,vac:0.19,dsr:58,migPos:false,ecoDiv:true,eco:"Services / Government",note:"Tight vacancy (0.19%) and good DSR but fails on net migration (TAS net –2,217) and growth (5% statewide). Over $650k budget. Remove from list."},
  {suburb:"Risdon Vale",city:"Hobart",state:"TAS",price:594200,yield_:5.13,growth:5,vac:0.22,dsr:57,migPos:false,ecoDiv:true,eco:"Services",note:"Affordable but TAS net migration is negative and growth is only 5%. Fails two core criteria. Remove."},
  {suburb:"Mayfield (TAS)",city:"Launceston",state:"TAS",price:502320,yield_:5.56,growth:5,vac:0.74,dsr:50,migPos:false,ecoDiv:true,eco:"Services",note:"DSR 50 is very low. Growth 5% fails threshold. Negative net migration statewide. Remove from list."},
  {suburb:"Mowbray",city:"Launceston",state:"TAS",price:597000,yield_:5.12,growth:5,vac:0.37,dsr:51,migPos:false,ecoDiv:true,eco:"Services / Uni",note:"Low DSR. Growth fails threshold. Negative net migration. Despite tight vacancy, structural population decline disqualifies."},
  {suburb:"Devonport",city:"Devonport",state:"TAS",price:571300,yield_:4.94,growth:5,vac:0.35,dsr:50,migPos:false,ecoDiv:true,eco:"Services / Port",note:"Fails growth, migration, and DSR criteria. Remove from list entirely."},
];

// Score each suburb
function scoreSuburb(s) {
  let score = 0, criteria = [];
  const y = s.yield_ >= 4.5; if(y) score++; criteria.push({label:"Yield >4.5%", val:`${s.yield_.toFixed(2)}%`, pass:y, warn:!y&&s.yield_>=4.0});
  const g = s.growth >= 7; if(g) score++; criteria.push({label:"Growth ≥7%", val:`~${s.growth}%`, pass:g, warn:!g&&s.growth>=5});
  const v = s.vac < 2; if(v) score++; criteria.push({label:"Vacancy <2%", val:`${s.vac}%`, pass:v, warn:!v&&s.vac<3});
  const d = s.dsr >= 55; if(d) score++; criteria.push({label:"DSR/Supply ≥55", val:s.dsr||'n/a', pass:d, warn:!d&&(s.dsr||0)>=50});
  const m = s.migPos; if(m) score++; criteria.push({label:"Net migration +ve", val:m?"Yes":"No", pass:m});
  const e = s.ecoDiv; if(e) score++; criteria.push({label:"Economy diversified", val:s.eco.split('/')[0].trim(), pass:e});
  return {score, criteria};
}

SUBURBS.forEach(s => { const r = scoreSuburb(s); s.score = r.score; s.criteria = r.criteria; });

function getVerdict(score) {
  if(score >= 5) return {label:"Strong Buy", cls:"strong-buy"};
  if(score === 4) return {label:"Conditional", cls:"conditional"};
  if(score === 3) return {label:"Watch", cls:"watch"};
  return {label:"Avoid", cls:"avoid"};
}

let currentSort = "score";
let currentSortDir = -1;
let currentVerdict = "all";

function setVerdict(v, el) {
  currentVerdict = v;
  document.querySelectorAll('.fchip').forEach(c => {
    c.className = 'fchip';
    if(c.dataset.v === v) c.classList.add(`active-${v}`);
  });
  renderGrid();
}

function setSort(col) {
  if(currentSort === col) currentSortDir *= -1;
  else { currentSort = col; currentSortDir = col === 'suburb' ? 1 : -1; }
  document.querySelectorAll('.sort-btn').forEach(b => b.classList.remove('active'));
  event.target.classList.add('active');
  renderGrid();
}

function resetAll() {
  document.getElementById('searchInput').value = '';
  document.getElementById('stateFilter').value = '';
  document.getElementById('priceFilter').value = '';
  currentVerdict = 'all';
  document.querySelectorAll('.fchip').forEach(c => { c.className = 'fchip'; });
  document.querySelector('[data-v="all"]').classList.add('active-all');
  renderGrid();
}

function renderGrid() {
  const search = document.getElementById('searchInput').value.toLowerCase();
  const state = document.getElementById('stateFilter').value;
  const maxPrice = parseInt(document.getElementById('priceFilter').value) || 0;

  let data = SUBURBS.filter(s => {
    if(search && !s.suburb.toLowerCase().includes(search) && !s.city.toLowerCase().includes(search)) return false;
    if(state && s.state !== state) return false;
    if(maxPrice && s.price > maxPrice) return false;
    if(currentVerdict !== 'all') {
      const v = getVerdict(s.score);
      if(v.cls !== currentVerdict) return false;
    }
    return true;
  });

  data.sort((a,b) => {
    const av = a[currentSort], bv = b[currentSort];
    if(typeof av === 'string') return currentSortDir * av.localeCompare(bv);
    return currentSortDir * (bv - av);
  });

  // Update stats
  const all = SUBURBS;
  document.getElementById('sStrong').textContent = all.filter(s=>s.score>=5).length;
  document.getElementById('sCond').textContent = all.filter(s=>s.score===4).length;
  document.getElementById('sWatch').textContent = all.filter(s=>s.score===3).length;
  document.getElementById('sAvoid').textContent = all.filter(s=>s.score<=2).length;
  document.getElementById('sTotal').textContent = all.length;
  document.getElementById('resultCount').textContent = `${data.length} suburb${data.length!==1?'s':''} shown`;

  const grid = document.getElementById('grid');
  const noRes = document.getElementById('noRes');

  if(data.length === 0) {
    grid.innerHTML = '';
    noRes.style.display = 'block';
    return;
  }
  noRes.style.display = 'none';

  grid.innerHTML = data.map((s, i) => {
    const v = getVerdict(s.score);
    const stateCls = `badge-${s.state.toLowerCase()}`;
    const yc = s.yield_>=4.5?'g':s.yield_>=4.0?'a':'r';
    const gc = s.growth>=7?'g':s.growth>=5?'a':'r';
    const vc = s.vac<2?'g':s.vac<3?'a':'r';

    const dots = Array.from({length:6},(_,i) =>
      `<div class="sdot ${i<s.score?'filled':'empty'}"></div>`
    ).join('');

    const criteriaHTML = s.criteria.map(c =>
      `<div class="crit-item">
        <div class="crit-dot ${c.pass?'pass':c.warn?'warn':'fail'}"></div>
        <div class="crit-text"><strong>${c.val}</strong> ${c.label}</div>
      </div>`
    ).join('');

    return `<div class="card ${v.cls}" style="animation-delay:${Math.min(i*0.04,0.5)}s" onclick="this.classList.toggle('expanded')">
      <div class="card-head">
        <div>
          <div class="card-name">${s.suburb}</div>
          <div class="card-loc">${s.city} · ${s.state}</div>
        </div>
        <div style="display:flex;flex-direction:column;align-items:flex-end;gap:5px">
          <span class="state-badge ${stateCls}">${s.state}</span>
          <span class="price-tag">$${(s.price/1000).toFixed(0)}k</span>
        </div>
      </div>
      <div class="card-metrics">
        <div class="metric"><div class="metric-val ${gc}">~${s.growth}%</div><div class="metric-lbl">Growth p.a.</div></div>
        <div class="metric"><div class="metric-val ${yc}">${s.yield_.toFixed(2)}%</div><div class="metric-lbl">Gross yield</div></div>
        <div class="metric"><div class="metric-val ${vc}">${s.vac}%</div><div class="metric-lbl">Vacancy</div></div>
      </div>
      <div class="card-criteria">${criteriaHTML}</div>
      <div class="card-footer">
        <span class="verdict ${v.cls}">${s.score}/6 · ${v.label}</span>
        <div class="score-dots">${dots}</div>
      </div>
      <div class="card-note">${s.note}</div>
      <div class="expand-hint">tap for notes ↓</div>
    </div>`;
  }).join('');
}

// Init
document.getElementById('searchInput').addEventListener('input', renderGrid);
document.getElementById('stateFilter').addEventListener('change', renderGrid);
document.getElementById('priceFilter').addEventListener('change', renderGrid);
document.querySelector('.sort-btn').classList.add('active');
renderGrid();
</script>
</body>
</html>

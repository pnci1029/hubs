'use strict';

const CARD_ART = {
  SCV: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_scv" cx="50%" cy="40%" r="65%"><stop offset="0%" stop-color="#031e38"/><stop offset="100%" stop-color="#010510"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_scv)"/>
  <ellipse cx="55" cy="46" rx="42" ry="28" fill="rgba(41,182,246,.07)"/>
  <ellipse cx="55" cy="68" rx="28" ry="3" fill="rgba(0,0,0,.6)"/>
  <rect x="12" y="52" width="20" height="13" rx="5" fill="#1c3450" stroke="rgba(41,182,246,.15)" stroke-width=".5"/>
  <rect x="78" y="52" width="20" height="13" rx="5" fill="#1a3050"/>
  <circle cx="16" cy="61" r="3" fill="#253c58"/><circle cx="28" cy="61" r="3" fill="#253c58"/>
  <circle cx="82" cy="61" r="3" fill="#253c58"/><circle cx="94" cy="61" r="3" fill="#253c58"/>
  <rect x="26" y="30" width="58" height="26" rx="5" fill="#1a3050" stroke="rgba(41,182,246,.2)" stroke-width=".5"/>
  <rect x="30" y="34" width="22" height="18" rx="3" fill="#223858"/>
  <rect x="56" y="34" width="22" height="18" rx="3" fill="#1e3454"/>
  <circle cx="55" cy="43" r="4.5" fill="#29b6f6"/>
  <circle cx="55" cy="43" r="8" fill="rgba(41,182,246,.4)"/>
  <circle cx="55" cy="43" r="12" fill="rgba(41,182,246,.12)"/>
  <rect x="84" y="32" width="10" height="18" rx="3" fill="#1e3450"/>
  <polygon points="94,36 108,32 108,46 94,48" fill="#1e3860"/>
  <line x1="94" y1="39" x2="108" y2="35" stroke="#29b6f6" stroke-width="1.5" opacity=".7"/>
  <line x1="94" y1="44" x2="108" y2="42" stroke="#29b6f6" stroke-width="1" opacity=".4"/>
  <rect x="34" y="12" width="40" height="22" rx="5" fill="#1e3454" stroke="rgba(41,182,246,.2)" stroke-width=".5"/>
  <rect x="40" y="14" width="30" height="14" rx="4" fill="#0e2848"/>
  <rect x="41" y="15" width="28" height="12" rx="3" fill="rgba(41,182,246,.22)"/>
  <rect x="43" y="16" width="9" height="4" rx="1" fill="rgba(255,255,255,.35)"/>
  <circle cx="55" cy="10" r="3.5" fill="#ffd740"/>
  <circle cx="55" cy="10" r="6" fill="rgba(255,215,64,.45)"/>
  <circle cx="55" cy="10" r="10" fill="rgba(255,215,64,.15)"/>
</svg>`,
  DRONE: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_drone" cx="50%" cy="38%" r="60%"><stop offset="0%" stop-color="#120e28"/><stop offset="100%" stop-color="#040308"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_drone)"/>
  <ellipse cx="55" cy="38" rx="36" ry="26" fill="rgba(171,71,188,.06)"/>
  <ellipse cx="55" cy="68" rx="24" ry="3" fill="rgba(0,0,0,.6)"/>
  <line x1="36" y1="52" x2="20" y2="66" stroke="#241634" stroke-width="5" stroke-linecap="round"/>
  <line x1="55" y1="56" x2="55" y2="68" stroke="#241634" stroke-width="5" stroke-linecap="round"/>
  <line x1="74" y1="52" x2="90" y2="66" stroke="#241634" stroke-width="5" stroke-linecap="round"/>
  <ellipse cx="55" cy="36" rx="26" ry="22" fill="#201630" stroke="rgba(171,71,188,.2)" stroke-width=".5"/>
  <ellipse cx="55" cy="34" rx="22" ry="18" fill="#281c3c"/>
  <ellipse cx="34" cy="24" rx="9" ry="7" fill="#1e1430"/>
  <ellipse cx="76" cy="24" rx="9" ry="7" fill="#1c122c"/>
  <path d="M 40 50 Q 55 62 70 50" stroke="#1c1230" stroke-width="7" fill="none" stroke-linecap="round"/>
  <path d="M 42 50 Q 55 60 68 50" stroke="#281838" stroke-width="4" fill="none" stroke-linecap="round"/>
  <circle cx="44" cy="32" r="6" fill="#ab47bc"/><circle cx="44" cy="32" r="10" fill="rgba(171,71,188,.35)"/><circle cx="44" cy="32" r="14" fill="rgba(171,71,188,.1)"/><circle cx="44" cy="30" r="2" fill="rgba(255,255,255,.7)"/>
  <circle cx="66" cy="32" r="6" fill="#ab47bc"/><circle cx="66" cy="32" r="10" fill="rgba(171,71,188,.35)"/><circle cx="66" cy="32" r="14" fill="rgba(171,71,188,.1)"/><circle cx="66" cy="30" r="2" fill="rgba(255,255,255,.7)"/>
</svg>`,

  PROBE: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_probe" cx="50%" cy="42%" r="62%"><stop offset="0%" stop-color="#0e2030"/><stop offset="100%" stop-color="#030810"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_probe)"/>
  <ellipse cx="55" cy="40" rx="38" ry="26" fill="rgba(128,203,196,.06)"/>
  <ellipse cx="55" cy="68" rx="20" ry="2.5" fill="rgba(0,0,0,.6)"/>
  <ellipse cx="55" cy="56" rx="20" ry="5" fill="rgba(38,198,218,.18)"/>
  <polygon points="55,14 78,38 70,54 40,54 32,38" fill="#182e40" stroke="rgba(128,203,196,.25)" stroke-width=".5"/>
  <polygon points="55,20 74,40 66,52 44,52 36,40" fill="#203848"/>
  <polygon points="55,28 66,38 58,46 52,46 44,38" fill="#00897b" opacity=".6"/>
  <polygon points="55,30 63,38 57,44 53,44 47,38" fill="#4db6ac" opacity=".85"/>
  <circle cx="55" cy="37" r="6" fill="#80cbc4"/><circle cx="55" cy="37" r="10" fill="rgba(128,203,196,.4)"/><circle cx="55" cy="37" r="15" fill="rgba(128,203,196,.12)"/>
  <ellipse cx="44" cy="54" rx="5" ry="3" fill="#182e40"/>
  <ellipse cx="44" cy="54" rx="3.5" ry="2.5" fill="#26c6da"/><ellipse cx="44" cy="54" rx="6" ry="4" fill="rgba(38,198,218,.3)"/>
  <ellipse cx="66" cy="54" rx="5" ry="3" fill="#182e40"/>
  <ellipse cx="66" cy="54" rx="3.5" ry="2.5" fill="#26c6da"/><ellipse cx="66" cy="54" rx="6" ry="4" fill="rgba(38,198,218,.3)"/>
  <line x1="55" y1="14" x2="55" y2="4" stroke="#182e40" stroke-width="2"/>
  <circle cx="55" cy="4" r="3.5" fill="#80cbc4"/><circle cx="55" cy="4" r="6" fill="rgba(128,203,196,.4)"/>
</svg>`,

  MARINE: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_marine" cx="50%" cy="32%" r="62%"><stop offset="0%" stop-color="#2e0808"/><stop offset="100%" stop-color="#070208"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_marine)"/>
  <ellipse cx="50" cy="36" rx="38" ry="28" fill="rgba(239,83,80,.06)"/>
  <ellipse cx="50" cy="68" rx="26" ry="3" fill="rgba(0,0,0,.6)"/>
  <rect x="36" y="54" width="12" height="16" rx="3" fill="#2c1010"/>
  <rect x="52" y="54" width="12" height="16" rx="3" fill="#260e0e"/>
  <rect x="34" y="64" width="14" height="7" rx="2" fill="#381414"/>
  <rect x="50" y="64" width="14" height="7" rx="2" fill="#301010"/>
  <rect x="28" y="34" width="40" height="24" rx="6" fill="#2e1010" stroke="rgba(239,83,80,.2)" stroke-width=".5"/>
  <rect x="36" y="38" width="24" height="14" rx="2" fill="#261010"/>
  <rect x="44" y="41" width="3" height="3" rx="1" fill="#ef5350"/><circle cx="45.5" cy="42.5" r="4" fill="rgba(239,83,80,.25)"/>
  <rect x="50" y="41" width="3" height="3" rx="1" fill="#ef5350" opacity=".6"/>
  <ellipse cx="24" cy="38" rx="11" ry="8" fill="#321212"/>
  <ellipse cx="24" cy="36" rx="9" ry="6" fill="#3a1616"/>
  <ellipse cx="80" cy="38" rx="11" ry="8" fill="#321212"/>
  <rect x="12" y="36" width="13" height="16" rx="4" fill="#2c1010"/>
  <rect x="80" y="38" width="11" height="10" rx="3" fill="#2c1010"/>
  <rect x="68" y="32" width="38" height="10" rx="3" fill="#200808"/>
  <rect x="96" y="34" width="14" height="5" rx="1" fill="#180606"/>
  <ellipse cx="110" cy="37" rx="5" ry="4" fill="#ff5252"/><ellipse cx="110" cy="37" rx="9" ry="6" fill="rgba(255,82,82,.4)"/><ellipse cx="110" cy="37" rx="13" ry="9" fill="rgba(255,82,82,.12)"/>
  <ellipse cx="51" cy="24" rx="17" ry="16" fill="#2c1010" stroke="rgba(239,83,80,.2)" stroke-width=".5"/>
  <ellipse cx="51" cy="22" rx="15" ry="12" fill="#261010"/>
  <rect x="37" y="17" width="28" height="10" rx="5" fill="#0277bd"/>
  <rect x="38" y="18" width="26" height="8" rx="4" fill="#29b6f6"/>
  <rect x="38" y="17" width="28" height="10" rx="5" fill="rgba(41,182,246,.3)"/>
  <rect x="40" y="19" width="9" height="3" rx="1" fill="rgba(255,255,255,.55)"/>
  <rect x="40" y="30" width="22" height="7" rx="3" fill="#281010"/>
  <line x1="60" y1="8" x2="62" y2="2" stroke="#3a1010" stroke-width="1.5" stroke-linecap="round"/>
  <circle cx="62" cy="1.5" r="2" fill="#ef5350"/><circle cx="62" cy="1.5" r="4" fill="rgba(239,83,80,.4)"/>
</svg>`,

  HYDRA: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_hydra" cx="56%" cy="38%" r="65%"><stop offset="0%" stop-color="#0e2208"/><stop offset="100%" stop-color="#030608"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_hydra)"/>
  <ellipse cx="60" cy="38" rx="40" ry="28" fill="rgba(165,214,167,.05)"/>
  <ellipse cx="62" cy="68" rx="30" ry="3.5" fill="rgba(0,0,0,.6)"/>
  <path d="M 18 68 Q 38 62 52 52 Q 62 46 67 56 Q 72 66 88 68" stroke="#1c3014" stroke-width="14" fill="none" stroke-linecap="round"/>
  <path d="M 20 68 Q 40 62 54 52 Q 64 46 68 56 Q 73 66 88 68" stroke="#223818" stroke-width="9" fill="none" stroke-linecap="round"/>
  <line x1="46" y1="28" x2="42" y2="12" stroke="#1e2e14" stroke-width="3" stroke-linecap="round"/>
  <line x1="52" y1="24" x2="50" y2="8" stroke="#1c2c12" stroke-width="2.5" stroke-linecap="round"/>
  <line x1="58" y1="21" x2="58" y2="6" stroke="#1a2a10" stroke-width="2.5" stroke-linecap="round"/>
  <line x1="64" y1="22" x2="65" y2="7" stroke="#1a2a10" stroke-width="2.5" stroke-linecap="round"/>
  <line x1="70" y1="25" x2="73" y2="11" stroke="#1c2e12" stroke-width="2" stroke-linecap="round"/>
  <ellipse cx="58" cy="34" rx="22" ry="18" fill="#1e3018" stroke="rgba(165,214,167,.18)" stroke-width=".5"/>
  <rect x="50" y="16" width="16" height="20" rx="6" fill="#1c2e16"/>
  <ellipse cx="58" cy="18" rx="14" ry="12" fill="#223618"/>
  <path d="M 46 22 Q 58 32 70 22" stroke="#182a10" stroke-width="8" fill="none" stroke-linecap="round"/>
  <line x1="40" y1="42" x2="28" y2="52" stroke="#1c2e14" stroke-width="5" stroke-linecap="round"/>
  <line x1="38" y1="44" x2="24" y2="48" stroke="#1c2e14" stroke-width="4" stroke-linecap="round"/>
  <line x1="76" y1="42" x2="90" y2="48" stroke="#1c2e14" stroke-width="5" stroke-linecap="round"/>
  <circle cx="50" cy="16" r="5" fill="#ffd740"/><circle cx="50" cy="16" r="8" fill="rgba(255,215,64,.4)"/><circle cx="50" cy="16" r="12" fill="rgba(255,215,64,.12)"/><circle cx="50" cy="14" r="2" fill="rgba(0,0,0,.9)"/>
  <circle cx="66" cy="16" r="5" fill="#ffd740"/><circle cx="66" cy="16" r="8" fill="rgba(255,215,64,.4)"/><circle cx="66" cy="16" r="12" fill="rgba(255,215,64,.12)"/><circle cx="66" cy="14" r="2" fill="rgba(0,0,0,.9)"/>
</svg>`,

  DRAGOON: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_dragoon" cx="50%" cy="38%" r="62%"><stop offset="0%" stop-color="#241408"/><stop offset="100%" stop-color="#060308"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_dragoon)"/>
  <ellipse cx="55" cy="38" rx="40" ry="28" fill="rgba(255,215,64,.05)"/>
  <ellipse cx="55" cy="68" rx="32" ry="3.5" fill="rgba(0,0,0,.6)"/>
  <line x1="36" y1="48" x2="22" y2="66" stroke="#2e1c10" stroke-width="9" stroke-linecap="round"/>
  <line x1="74" y1="48" x2="88" y2="66" stroke="#2e1c10" stroke-width="9" stroke-linecap="round"/>
  <line x1="40" y1="52" x2="28" y2="68" stroke="#281810" stroke-width="7" stroke-linecap="round"/>
  <line x1="70" y1="52" x2="82" y2="68" stroke="#281810" stroke-width="7" stroke-linecap="round"/>
  <ellipse cx="55" cy="36" rx="28" ry="20" fill="#301a08" stroke="rgba(255,215,64,.2)" stroke-width=".5"/>
  <ellipse cx="55" cy="34" rx="24" ry="17" fill="#381e0c"/>
  <rect x="20" y="26" width="15" height="8" rx="3" fill="#2a1608"/>
  <rect x="75" y="26" width="15" height="8" rx="3" fill="#2a1608"/>
  <rect x="48" y="12" width="14" height="28" rx="4" fill="#2c1808"/>
  <rect x="50" y="8" width="10" height="8" rx="3" fill="#301c0a"/>
  <circle cx="55" cy="36" r="10" fill="rgba(255,215,64,.2)"/>
  <circle cx="55" cy="36" r="7" fill="#ffd740" opacity=".55"/>
  <circle cx="55" cy="36" r="5" fill="#ffd740" opacity=".8"/>
  <circle cx="55" cy="36" r="3" fill="#fff9c4"/>
  <ellipse cx="55" cy="8" rx="6" ry="4" fill="#ffd740" opacity=".8"/>
  <ellipse cx="55" cy="8" rx="10" ry="6" fill="rgba(255,215,64,.4)"/>
  <ellipse cx="55" cy="8" rx="14" ry="8" fill="rgba(255,215,64,.12)"/>
</svg>`,

  BATTLECRUISER: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <radialGradient id="g_bc" cx="50%" cy="46%" r="68%"><stop offset="0%" stop-color="#220618"/><stop offset="100%" stop-color="#040108"/></radialGradient>
    <radialGradient id="g_bc2" cx="50%" cy="100%" r="65%"><stop offset="0%" stop-color="rgba(239,83,80,.4)"/><stop offset="100%" stop-color="rgba(239,83,80,0)"/></radialGradient>
  </defs>
  <rect width="110" height="72" fill="url(#g_bc)"/>
  <rect width="110" height="72" fill="url(#g_bc2)"/>
  <circle cx="8" cy="6" r="1.2" fill="white" opacity=".6"/><circle cx="22" cy="14" r="1" fill="white" opacity=".5"/>
  <circle cx="46" cy="4" r="1.3" fill="white" opacity=".65"/><circle cx="74" cy="10" r="1" fill="white" opacity=".4"/>
  <circle cx="96" cy="5" r="1.2" fill="white" opacity=".6"/><circle cx="6" cy="40" r="1" fill="white" opacity=".4"/>
  <circle cx="104" cy="48" r=".9" fill="white" opacity=".35"/>
  <polygon points="55,4 102,54 55,66 8,54" fill="#221020" stroke="rgba(239,83,80,.2)" stroke-width=".5"/>
  <polygon points="55,10 96,52 55,60 14,52" fill="none" stroke="rgba(239,83,80,.3)" stroke-width="1"/>
  <polygon points="55,18 88,48 55,56 22,48" fill="none" stroke="rgba(239,83,80,.18)" stroke-width="1"/>
  <polygon points="55,16 76,40 55,46 34,40" fill="#301428"/>
  <polygon points="55,22 70,38 55,42 40,38" fill="#381830"/>
  <rect x="50" y="26" width="10" height="6" rx="2" fill="#ff8a65" opacity=".6"/>
  <rect x="51" y="4" width="8" height="20" rx="3" fill="#2c0e1c"/>
  <ellipse cx="55" cy="6" rx="5" ry="3.5" fill="#ff5252"/><ellipse cx="55" cy="6" rx="8" ry="5" fill="rgba(255,82,82,.4)"/><ellipse cx="55" cy="6" rx="12" ry="8" fill="rgba(255,82,82,.15)"/>
  <ellipse cx="36" cy="62" rx="8" ry="4" fill="#341220"/>
  <ellipse cx="36" cy="62" rx="5.5" ry="3.5" fill="#ef5350"/><ellipse cx="36" cy="62" rx="10" ry="7" fill="rgba(239,83,80,.45)"/><ellipse cx="36" cy="62" rx="16" ry="10" fill="rgba(239,83,80,.12)"/>
  <ellipse cx="74" cy="62" rx="8" ry="4" fill="#341220"/>
  <ellipse cx="74" cy="62" rx="5.5" ry="3.5" fill="#ef5350"/><ellipse cx="74" cy="62" rx="10" ry="7" fill="rgba(239,83,80,.45)"/><ellipse cx="74" cy="62" rx="16" ry="10" fill="rgba(239,83,80,.12)"/>
  <ellipse cx="55" cy="65" rx="7" ry="4" fill="#ef5350"/><ellipse cx="55" cy="65" rx="12" ry="7" fill="rgba(239,83,80,.4)"/>
</svg>`,

  BALLOON: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_bal" cx="50%" cy="42%" r="62%"><stop offset="0%" stop-color="#1a0a2e"/><stop offset="100%" stop-color="#040208"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_bal)"/>
  <circle cx="14" cy="9" r="1.1" fill="white" opacity=".5"/><circle cx="88" cy="6" r="1" fill="white" opacity=".45"/>
  <circle cx="42" cy="4" r=".9" fill="white" opacity=".5"/><circle cx="98" cy="20" r="1.2" fill="white" opacity=".4"/>
  <ellipse cx="55" cy="34" rx="44" ry="32" fill="rgba(103,58,183,.06)"/>
  <ellipse cx="38" cy="50" rx="9" ry="13" fill="rgba(103,58,183,.25)" stroke="rgba(171,71,188,.3)" stroke-width=".5"/>
  <ellipse cx="38" cy="48" rx="7" ry="10" fill="#9c27b0" opacity=".5"/>
  <ellipse cx="55" cy="46" rx="10" ry="15" fill="rgba(233,30,99,.3)" stroke="rgba(233,30,99,.35)" stroke-width=".5"/>
  <ellipse cx="55" cy="44" rx="8" ry="12" fill="#e91e63" opacity=".5"/>
  <ellipse cx="72" cy="52" rx="8" ry="11" fill="rgba(33,150,243,.3)" stroke="rgba(33,150,243,.35)" stroke-width=".5"/>
  <ellipse cx="72" cy="50" rx="6" ry="9" fill="#2196f3" opacity=".5"/>
  <line x1="38" y1="63" x2="38" y2="72" stroke="rgba(200,200,200,.6)" stroke-width="1"/>
  <line x1="55" y1="61" x2="55" y2="72" stroke="rgba(200,200,200,.6)" stroke-width="1"/>
  <line x1="72" y1="63" x2="72" y2="72" stroke="rgba(200,200,200,.6)" stroke-width="1"/>
  <circle cx="38" cy="38" r="4" fill="#ce93d8" opacity=".8"/>
  <circle cx="55" cy="32" r="5" fill="#f48fb1" opacity=".8"/>
  <circle cx="72" cy="41" r="3.5" fill="#90caf9" opacity=".8"/>
  <circle cx="55" cy="8" r="6" fill="#ab47bc"/><circle cx="55" cy="8" r="11" fill="rgba(171,71,188,.5)"/><circle cx="55" cy="8" r="17" fill="rgba(171,71,188,.15)"/>
</svg>`,

  VULTURE: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_vul" cx="50%" cy="46%" r="65%"><stop offset="0%" stop-color="#1a1208"/><stop offset="100%" stop-color="#040308"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_vul)"/>
  <ellipse cx="55" cy="50" rx="44" ry="22" fill="rgba(255,193,7,.05)"/>
  <ellipse cx="55" cy="68" rx="34" ry="3" fill="rgba(0,0,0,.6)"/>
  <rect x="18" y="50" width="74" height="14" rx="5" fill="#1c1808" stroke="rgba(255,193,7,.12)" stroke-width=".5"/>
  <ellipse cx="30" cy="57" rx="8" ry="4" fill="#1a1606"/>
  <ellipse cx="55" cy="57" rx="8" ry="4" fill="#181606"/>
  <ellipse cx="80" cy="57" rx="8" ry="4" fill="#1a1606"/>
  <rect x="30" y="28" width="50" height="24" rx="6" fill="#1e1c08" stroke="rgba(255,193,7,.15)" stroke-width=".5"/>
  <rect x="18" y="36" width="14" height="8" rx="3" fill="#1a1608"/>
  <rect x="78" y="36" width="14" height="8" rx="3" fill="#1a1608"/>
  <rect x="20" y="38" width="58" height="4" rx="2" fill="#ffc107" opacity=".15"/>
  <text x="55" y="46" text-anchor="middle" font-size="18" fill="#ffc107" opacity=".8" font-family="monospace">🎴</text>
  <circle cx="55" cy="14" r="8" fill="#ffc107"/><circle cx="55" cy="14" r="13" fill="rgba(255,193,7,.45)"/><circle cx="55" cy="14" r="19" fill="rgba(255,193,7,.12)"/>
  <rect x="51" y="8" width="8" height="12" rx="2" fill="rgba(0,0,0,.4)"/>
  <rect x="53" y="10" width="4" height="8" rx="1" fill="#fff9c4" opacity=".7"/>
</svg>`,

  JAR: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_jar" cx="50%" cy="44%" r="62%"><stop offset="0%" stop-color="#1e0a06"/><stop offset="100%" stop-color="#060208"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_jar)"/>
  <ellipse cx="55" cy="44" rx="42" ry="30" fill="rgba(255,87,34,.06)"/>
  <ellipse cx="55" cy="68" rx="32" ry="3" fill="rgba(0,0,0,.6)"/>
  <rect x="26" y="22" width="58" height="8" rx="4" fill="#2a1208"/>
  <ellipse cx="55" cy="54" rx="30" ry="18" fill="#221008" stroke="rgba(255,87,34,.2)" stroke-width=".5"/>
  <ellipse cx="55" cy="52" rx="27" ry="15" fill="#281408"/>
  <ellipse cx="55" cy="48" rx="24" ry="12" fill="#2e1a0c"/>
  <ellipse cx="55" cy="30" rx="26" ry="10" fill="#2a1208"/>
  <ellipse cx="55" cy="29" rx="22" ry="8" fill="#301608"/>
  <ellipse cx="55" cy="54" rx="16" ry="10" fill="#ff5722" opacity=".18"/>
  <ellipse cx="55" cy="54" rx="10" ry="6" fill="#ff5722" opacity=".28"/>
  <circle cx="55" cy="54" r="5" fill="#ff5722" opacity=".4"/>
  <ellipse cx="42" cy="48" rx="5" ry="7" fill="rgba(255,255,255,.04)" transform="rotate(-15 42 48)"/>
  <rect x="30" y="19" width="50" height="6" rx="3" fill="#2e1408"/>
  <rect x="38" y="16" width="34" height="6" rx="3" fill="#321808"/>
  <circle cx="55" cy="8" r="5" fill="#ff5722"/><circle cx="55" cy="8" r="9" fill="rgba(255,87,34,.5)"/><circle cx="55" cy="8" r="14" fill="rgba(255,87,34,.15)"/>
</svg>`,

  THREE: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_three" cx="50%" cy="44%" r="62%"><stop offset="0%" stop-color="#080e20"/><stop offset="100%" stop-color="#020408"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_three)"/>
  <circle cx="12" cy="8" r="1" fill="white" opacity=".5"/><circle cx="92" cy="6" r="1.2" fill="white" opacity=".6"/>
  <circle cx="58" cy="4" r=".9" fill="white" opacity=".4"/>
  <ellipse cx="55" cy="40" rx="44" ry="28" fill="rgba(33,150,243,.05)"/>
  <ellipse cx="55" cy="68" rx="34" ry="3" fill="rgba(0,0,0,.6)"/>
  <polygon points="4,32 4,60 20,68 90,68 106,60 106,32 90,24 20,24" fill="#0e1c30" stroke="rgba(33,150,243,.2)" stroke-width=".5"/>
  <rect x="18" y="30" width="14" height="9" rx="1" fill="#0c1828"/>
  <rect x="19" y="31" width="12" height="7" rx="1" fill="#080e20"/>
  <line x1="25" y1="34" x2="4" y2="40" stroke="#0a1420" stroke-width="4" stroke-linecap="round"/>
  <rect x="48" y="30" width="14" height="9" rx="1" fill="#0c1828"/>
  <rect x="49" y="31" width="12" height="7" rx="1" fill="#080e20"/>
  <line x1="55" y1="34" x2="55" y2="24" stroke="#0a1420" stroke-width="4" stroke-linecap="round"/>
  <rect x="78" y="30" width="14" height="9" rx="1" fill="#0c1828"/>
  <rect x="79" y="31" width="12" height="7" rx="1" fill="#080e20"/>
  <line x1="85" y1="34" x2="106" y2="40" stroke="#0a1420" stroke-width="4" stroke-linecap="round"/>
  <text x="55" y="60" text-anchor="middle" font-size="22" font-weight="bold" fill="#2196f3" opacity=".9" font-family="monospace">"3"</text>
  <circle cx="55" cy="11" r="5" fill="#2196f3"/><circle cx="55" cy="11" r="9" fill="rgba(33,150,243,.5)"/><circle cx="55" cy="11" r="14" fill="rgba(33,150,243,.18)"/>
</svg>`,

  SNIPER: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_sniper" cx="45%" cy="36%" r="62%"><stop offset="0%" stop-color="#081408"/><stop offset="100%" stop-color="#020408"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_sniper)"/>
  <ellipse cx="46" cy="36" rx="34" ry="26" fill="rgba(105,240,174,.05)"/>
  <ellipse cx="48" cy="68" rx="20" ry="2.5" fill="rgba(0,0,0,.6)"/>
  <rect x="38" y="52" width="8" height="18" rx="2" fill="#162010"/>
  <rect x="50" y="52" width="8" height="18" rx="2" fill="#121c0e"/>
  <rect x="30" y="28" width="36" height="28" rx="6" fill="#182212" stroke="rgba(105,240,174,.15)" stroke-width=".5"/>
  <rect x="34" y="34" width="14" height="14" rx="2" fill="#1e2c16"/>
  <ellipse cx="48" cy="20" rx="12" ry="10" fill="#182012"/>
  <ellipse cx="48" cy="20" rx="10" ry="8" fill="#1e2816"/>
  <rect x="40" y="17" width="16" height="5" rx="2" fill="#1b5e20" opacity=".7"/>
  <rect x="41" y="18" width="14" height="3" rx="1.5" fill="#69f0ae"/>
  <rect x="10" y="30" width="10" height="20" rx="4" fill="#182212"/>
  <rect x="4" y="28" width="62" height="7" rx="2" fill="#141e10"/>
  <rect x="6" y="32" width="12" height="5" rx="2" fill="#1e2c16"/>
  <line x1="64" y1="31" x2="110" y2="14" stroke="#69f0ae" stroke-width="2" stroke-linecap="round" opacity=".85"/>
  <circle cx="98" cy="18" r="6" fill="none" stroke="#69f0ae" stroke-width="1.5" opacity=".7"/>
  <line x1="95" y1="18" x2="101" y2="18" stroke="#69f0ae" stroke-width="1" opacity=".8"/>
  <line x1="98" y1="15" x2="98" y2="21" stroke="#69f0ae" stroke-width="1" opacity=".8"/>
  <circle cx="98" cy="18" r="1.5" fill="#69f0ae"/>
  <circle cx="98" cy="18" r="10" fill="rgba(105,240,174,.1)"/>
</svg>`,

  NEOROBOT: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_neo" cx="50%" cy="40%" r="65%"><stop offset="0%" stop-color="#0a1826"/><stop offset="100%" stop-color="#030508"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_neo)"/>
  <ellipse cx="55" cy="38" rx="44" ry="30" fill="rgba(41,182,246,.06)"/>
  <ellipse cx="55" cy="68" rx="32" ry="3" fill="rgba(0,0,0,.6)"/>
  <rect x="28" y="52" width="54" height="14" rx="3" fill="#0e1e2e" stroke="rgba(41,182,246,.15)" stroke-width=".5"/>
  <circle cx="38" cy="59" r="5" fill="#0a1a28"/><circle cx="38" cy="59" r="3.5" fill="#0e2030"/>
  <circle cx="55" cy="59" r="5" fill="#0a1a28"/><circle cx="55" cy="59" r="3.5" fill="#0e2030"/>
  <circle cx="72" cy="59" r="5" fill="#0a1a28"/><circle cx="72" cy="59" r="3.5" fill="#0e2030"/>
  <rect x="22" y="24" width="66" height="30" rx="5" fill="#0e1e2e" stroke="rgba(41,182,246,.2)" stroke-width=".5"/>
  <rect x="30" y="14" width="50" height="14" rx="4" fill="#101e2c"/>
  <rect x="38" y="10" width="34" height="7" rx="3" fill="#0e1c2a"/>
  <circle cx="42" cy="34" r="6" fill="#0a1626"/>
  <circle cx="42" cy="34" r="4" fill="#102030"/>
  <circle cx="42" cy="34" r="2" fill="#29b6f6" opacity=".9"/>
  <circle cx="42" cy="34" r="5" fill="rgba(41,182,246,.2)"/>
  <circle cx="68" cy="34" r="6" fill="#0a1626"/>
  <circle cx="68" cy="34" r="4" fill="#102030"/>
  <circle cx="68" cy="34" r="2" fill="#29b6f6" opacity=".9"/>
  <circle cx="68" cy="34" r="5" fill="rgba(41,182,246,.2)"/>
  <rect x="46" y="38" width="18" height="8" rx="3" fill="#0a1626"/>
  <rect x="47" y="39" width="16" height="6" rx="2" fill="none" stroke="rgba(41,182,246,.6)" stroke-width="1"/>
  <rect x="49" y="41" width="4" height="2" rx="1" fill="#29b6f6" opacity=".8"/>
  <rect x="55" y="41" width="4" height="2" rx="1" fill="#29b6f6" opacity=".6"/>
  <rect x="18" y="32" width="8" height="14" rx="3" fill="#0e1c2c"/>
  <rect x="84" y="32" width="8" height="14" rx="3" fill="#0e1c2c"/>
  <circle cx="55" cy="6" r="5" fill="#29b6f6"/><circle cx="55" cy="6" r="9" fill="rgba(41,182,246,.5)"/><circle cx="55" cy="6" r="14" fill="rgba(41,182,246,.15)"/>
</svg>`,

  LUCKCAT: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_cat" cx="50%" cy="36%" r="62%"><stop offset="0%" stop-color="#201408"/><stop offset="100%" stop-color="#060306"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_cat)"/>
  <ellipse cx="55" cy="36" rx="42" ry="28" fill="rgba(255,215,64,.06)"/>
  <ellipse cx="55" cy="68" rx="28" ry="3" fill="rgba(0,0,0,.6)"/>
  <ellipse cx="55" cy="52" rx="26" ry="16" fill="#281a10"/>
  <polygon points="34,30 38,16 46,28" fill="#301c12" stroke="rgba(255,215,64,.2)" stroke-width=".5"/>
  <polygon points="76,30 72,16 64,28" fill="#2e1a10" stroke="rgba(255,215,64,.2)" stroke-width=".5"/>
  <ellipse cx="55" cy="32" rx="24" ry="20" fill="#2e1a12" stroke="rgba(255,215,64,.18)" stroke-width=".5"/>
  <ellipse cx="55" cy="30" rx="20" ry="17" fill="#341e14"/>
  <circle cx="44" cy="26" r="4" fill="#ffd740"/><circle cx="44" cy="26" r="2" fill="#fff9c4"/>
  <circle cx="44" cy="26" r="3" fill="#3a2016"/>
  <circle cx="66" cy="26" r="4" fill="#ffd740"/><circle cx="66" cy="26" r="2" fill="#fff9c4"/>
  <circle cx="66" cy="26" r="3" fill="#3a2016"/>
  <ellipse cx="55" cy="36" rx="8" ry="5" fill="#2e1c12"/>
  <ellipse cx="55" cy="37" rx="6" ry="3.5" fill="#3a2018"/>
  <ellipse cx="51" cy="38" rx="2.5" ry="2" fill="#4a2820"/>
  <ellipse cx="59" cy="38" rx="2.5" ry="2" fill="#4a2820"/>
  <line x1="34" y1="32" x2="14" y2="28" stroke="rgba(255,215,64,.5)" stroke-width="1"/>
  <line x1="34" y1="34" x2="14" y2="34" stroke="rgba(255,215,64,.4)" stroke-width="1"/>
  <line x1="76" y1="32" x2="96" y2="28" stroke="rgba(255,215,64,.5)" stroke-width="1"/>
  <line x1="76" y1="34" x2="96" y2="34" stroke="rgba(255,215,64,.4)" stroke-width="1"/>
  <path d="M 44 44 Q 55 52 66 44" stroke="#3a2018" stroke-width="3" fill="none" stroke-linecap="round"/>
  <path d="M 45 44 Q 55 52 65 44" stroke="#f48fb1" stroke-width="2" fill="none" stroke-linecap="round" opacity=".7"/>
  <circle cx="74" cy="52" r="6" fill="#ffd740"/><circle cx="74" cy="52" r="10" fill="rgba(255,215,64,.4)"/><circle cx="74" cy="52" r="15" fill="rgba(255,215,64,.12)"/>
  <circle cx="55" cy="8" r="5" fill="#ffd740"/><circle cx="55" cy="8" r="9" fill="rgba(255,215,64,.5)"/><circle cx="55" cy="8" r="14" fill="rgba(255,215,64,.14)"/>
</svg>`,

  IMPOSTOR: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_imp" cx="50%" cy="40%" r="62%"><stop offset="0%" stop-color="#200404"/><stop offset="100%" stop-color="#060208"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_imp)"/>
  <ellipse cx="55" cy="38" rx="42" ry="28" fill="rgba(255,82,82,.05)"/>
  <ellipse cx="55" cy="68" rx="30" ry="3" fill="rgba(0,0,0,.6)"/>
  <ellipse cx="55" cy="52" rx="24" ry="16" fill="#200808"/>
  <rect x="34" y="38" width="42" height="18" rx="3" fill="#1c0606"/>
  <rect x="44" y="16" width="22" height="26" rx="6" fill="#220a08" stroke="rgba(255,82,82,.2)" stroke-width=".5"/>
  <rect x="48" y="20" width="14" height="18" rx="4" fill="#280e0c"/>
  <ellipse cx="55" cy="26" rx="8" ry="6" fill="#2e1010"/>
  <rect x="46" y="22" width="18" height="8" rx="3" fill="#ff5252" opacity=".15"/>
  <ellipse cx="40" cy="30" rx="8" ry="5" fill="#1e0808"/>
  <ellipse cx="70" cy="30" rx="8" ry="5" fill="#1e0808"/>
  <rect x="38" y="56" width="10" height="12" rx="3" fill="#1c0606"/>
  <rect x="62" y="56" width="10" height="12" rx="3" fill="#1c0606"/>
  <circle cx="55" cy="16" r="8" fill="#200808"/>
  <rect x="48" y="6" width="14" height="14" rx="5" fill="#240a08"/>
  <text x="55" y="50" text-anchor="middle" font-size="16" fill="#ff5252" opacity=".85" font-family="monospace">☠</text>
  <circle cx="55" cy="8" r="5" fill="#ff5252"/><circle cx="55" cy="8" r="9" fill="rgba(255,82,82,.5)"/><circle cx="55" cy="8" r="14" fill="rgba(255,82,82,.15)"/>
</svg>`,

  VTUBER: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_vt" cx="50%" cy="38%" r="62%"><stop offset="0%" stop-color="#12081e"/><stop offset="100%" stop-color="#040208"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_vt)"/>
  <circle cx="14" cy="10" r="1" fill="white" opacity=".5"/><circle cx="90" cy="6" r="1.2" fill="white" opacity=".6"/>
  <ellipse cx="55" cy="38" rx="44" ry="28" fill="rgba(156,39,176,.06)"/>
  <ellipse cx="55" cy="68" rx="30" ry="3" fill="rgba(0,0,0,.6)"/>
  <rect x="12" y="24" width="86" height="40" rx="6" fill="#14102a" stroke="rgba(156,39,176,.2)" stroke-width=".5"/>
  <rect x="16" y="28" width="78" height="32" rx="4" fill="#1a1030"/>
  <ellipse cx="55" cy="44" rx="28" ry="12" fill="#200e38"/>
  <ellipse cx="40" cy="36" rx="9" ry="10" fill="#1c0c30"/>
  <ellipse cx="40" cy="34" rx="7" ry="8" fill="#240e3a"/>
  <ellipse cx="40" cy="32" rx="5" ry="6" fill="#9c27b0" opacity=".4"/>
  <ellipse cx="70" cy="36" rx="9" ry="10" fill="#1c0c30"/>
  <ellipse cx="70" cy="34" rx="7" ry="8" fill="#240e3a"/>
  <ellipse cx="70" cy="32" rx="5" ry="6" fill="#9c27b0" opacity=".4"/>
  <circle cx="40" cy="42" r="5" fill="#ce93d8" opacity=".6"/>
  <circle cx="40" cy="40" r="2" fill="white" opacity=".8"/>
  <circle cx="40" cy="42" r="3" fill="#4a0072"/>
  <circle cx="70" cy="42" r="5" fill="#ce93d8" opacity=".6"/>
  <circle cx="70" cy="40" r="2" fill="white" opacity=".8"/>
  <circle cx="70" cy="42" r="3" fill="#4a0072"/>
  <path d="M 44 52 Q 55 60 66 52" stroke="#6a1b9a" stroke-width="3" fill="none" stroke-linecap="round"/>
  <path d="M 45 52 Q 55 59 65 52" stroke="#ce93d8" stroke-width="2" fill="none" stroke-linecap="round" opacity=".7"/>
  <rect x="8" y="30" width="6" height="16" rx="3" fill="#1e1430"/>
  <rect x="96" y="30" width="6" height="16" rx="3" fill="#1e1430"/>
  <circle cx="55" cy="10" r="5" fill="#9c27b0"/><circle cx="55" cy="10" r="9" fill="rgba(156,39,176,.5)"/><circle cx="55" cy="10" r="14" fill="rgba(156,39,176,.15)"/>
</svg>`,

  KINGCRAB: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_kc" cx="50%" cy="44%" r="65%"><stop offset="0%" stop-color="#200808"/><stop offset="100%" stop-color="#060208"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_kc)"/>
  <ellipse cx="55" cy="42" rx="46" ry="28" fill="rgba(239,83,80,.06)"/>
  <ellipse cx="55" cy="68" rx="34" ry="3" fill="rgba(0,0,0,.6)"/>
  <line x1="8" y1="28" x2="28" y2="40" stroke="#2a1010" stroke-width="5" stroke-linecap="round"/>
  <line x1="8" y1="20" x2="28" y2="38" stroke="#2a1010" stroke-width="4" stroke-linecap="round"/>
  <line x1="102" y1="28" x2="82" y2="40" stroke="#2a1010" stroke-width="5" stroke-linecap="round"/>
  <line x1="102" y1="20" x2="82" y2="38" stroke="#2a1010" stroke-width="4" stroke-linecap="round"/>
  <line x1="4" y1="48" x2="26" y2="48" stroke="#2a1010" stroke-width="4" stroke-linecap="round"/>
  <line x1="106" y1="48" x2="84" y2="48" stroke="#2a1010" stroke-width="4" stroke-linecap="round"/>
  <line x1="8" y1="60" x2="28" y2="52" stroke="#2a1010" stroke-width="3" stroke-linecap="round"/>
  <line x1="102" y1="60" x2="82" y2="52" stroke="#2a1010" stroke-width="3" stroke-linecap="round"/>
  <ellipse cx="55" cy="46" rx="30" ry="22" fill="#2c1010" stroke="rgba(239,83,80,.25)" stroke-width=".5"/>
  <ellipse cx="55" cy="44" rx="26" ry="18" fill="#341414"/>
  <ellipse cx="55" cy="40" rx="22" ry="14" fill="#3a1818"/>
  <circle cx="42" cy="36" r="5" fill="#280e0e"/><circle cx="42" cy="36" r="3" fill="#300e0e"/>
  <circle cx="42" cy="36" r="1.5" fill="#ef5350" opacity=".9"/>
  <circle cx="42" cy="36" r="4" fill="rgba(239,83,80,.25)"/>
  <circle cx="68" cy="36" r="5" fill="#280e0e"/><circle cx="68" cy="36" r="3" fill="#300e0e"/>
  <circle cx="68" cy="36" r="1.5" fill="#ef5350" opacity=".9"/>
  <circle cx="68" cy="36" r="4" fill="rgba(239,83,80,.25)"/>
  <path d="M 42 52 Q 55 60 68 52" stroke="#2e1010" stroke-width="4" fill="none" stroke-linecap="round"/>
  <path d="M 43 52 Q 55 59 67 52" stroke="#ef5350" stroke-width="2" fill="none" stroke-linecap="round" opacity=".7"/>
  <circle cx="55" cy="8" r="5" fill="#ef5350"/><circle cx="55" cy="8" r="9" fill="rgba(239,83,80,.5)"/><circle cx="55" cy="8" r="14" fill="rgba(239,83,80,.15)"/>
</svg>`,

  SUPPLY_DEPOT: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_sd" cx="50%" cy="52%" r="65%"><stop offset="0%" stop-color="#18102e"/><stop offset="100%" stop-color="#060410"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_sd)"/>
  <ellipse cx="55" cy="50" rx="44" ry="26" fill="rgba(171,71,188,.06)"/>
  <ellipse cx="55" cy="70" rx="36" ry="3" fill="rgba(0,0,0,.6)"/>
  <rect x="12" y="36" width="86" height="32" rx="3" fill="#1e1434" stroke="rgba(171,71,188,.2)" stroke-width=".5"/>
  <rect x="16" y="40" width="36" height="24" rx="2" fill="#261a40"/>
  <rect x="56" y="40" width="38" height="24" rx="2" fill="#22183c"/>
  <rect x="8" y="26" width="94" height="14" rx="3" fill="#28183e"/>
  <polygon points="8,26 55,14 102,26" fill="#2e1a48"/>
  <polygon points="12,26 55,16 98,26" fill="#2c1844"/>
  <rect x="18" y="46" width="14" height="10" rx="2" fill="#ab47bc" opacity=".45"/>
  <rect x="19" y="47" width="12" height="8" rx="1" fill="#ab47bc" opacity=".7"/>
  <rect x="20" y="48" width="4" height="3" rx="1" fill="rgba(255,255,255,.5)"/>
  <rect x="38" y="46" width="12" height="10" rx="2" fill="#ab47bc" opacity=".4"/>
  <rect x="39" y="47" width="10" height="8" rx="1" fill="#ab47bc" opacity=".6"/>
  <rect x="60" y="46" width="12" height="10" rx="2" fill="#ab47bc" opacity=".4"/>
  <rect x="61" y="47" width="10" height="8" rx="1" fill="#ab47bc" opacity=".6"/>
  <rect x="78" y="46" width="14" height="10" rx="2" fill="#ab47bc" opacity=".35"/>
  <rect x="46" y="56" width="18" height="12" rx="2" fill="#1c1030"/>
  <line x1="55" y1="56" x2="55" y2="68" stroke="#ab47bc" stroke-width="1" opacity=".5"/>
  <circle cx="51" cy="63" r="2" fill="#ab47bc"/><circle cx="59" cy="63" r="2" fill="#ab47bc"/>
  <line x1="55" y1="14" x2="55" y2="4" stroke="#301e50" stroke-width="2"/>
  <rect x="50" y="2" width="10" height="5" rx="2" fill="#ab47bc"/>
  <circle cx="55" cy="2" r="2.5" fill="#ce93d8"/>
  <circle cx="55" cy="2" r="5" fill="rgba(171,71,188,.55)"/><circle cx="55" cy="2" r="9" fill="rgba(171,71,188,.18)"/>
  <rect x="2" y="52" width="10" height="10" rx="2" fill="#241640"/>
  <rect x="3" y="53" width="8" height="8" rx="1" fill="#2c1e4c"/>
  <rect x="98" y="52" width="10" height="10" rx="2" fill="#241640"/>
  <rect x="99" y="53" width="8" height="8" rx="1" fill="#2c1e4c"/>
</svg>`,

  SWEET_PIG: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_pig" cx="50%" cy="38%" r="62%"><stop offset="0%" stop-color="#280e22"/><stop offset="100%" stop-color="#060306"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_pig)"/>
  <ellipse cx="55" cy="36" rx="40" ry="28" fill="rgba(244,143,177,.07)"/>
  <ellipse cx="55" cy="68" rx="30" ry="3" fill="rgba(0,0,0,.6)"/>
  <ellipse cx="55" cy="52" rx="28" ry="18" fill="#2a1826"/>
  <ellipse cx="30" cy="20" rx="10" ry="14" fill="#2c1428"/>
  <ellipse cx="30" cy="18" rx="7" ry="10" fill="#341830"/>
  <ellipse cx="30" cy="17" rx="4" ry="7" fill="#f48fb1" opacity=".6"/>
  <ellipse cx="80" cy="20" rx="10" ry="14" fill="#2c1428"/>
  <ellipse cx="80" cy="18" rx="7" ry="10" fill="#341830"/>
  <ellipse cx="80" cy="17" rx="4" ry="7" fill="#f48fb1" opacity=".6"/>
  <ellipse cx="55" cy="30" rx="24" ry="22" fill="#301634" stroke="rgba(244,143,177,.18)" stroke-width=".5"/>
  <ellipse cx="55" cy="29" rx="21" ry="19" fill="#381a3c"/>
  <circle cx="43" cy="24" r="6" fill="#f8bbd0"/><circle cx="43" cy="24" r="9" fill="rgba(248,187,208,.3)"/><circle cx="43" cy="24" r="13" fill="rgba(248,187,208,.08)"/>
  <circle cx="43" cy="22" r="2" fill="white" opacity=".9"/><circle cx="43" cy="24" r="2.5" fill="#4a0030"/>
  <circle cx="67" cy="24" r="6" fill="#f8bbd0"/><circle cx="67" cy="24" r="9" fill="rgba(248,187,208,.3)"/><circle cx="67" cy="24" r="13" fill="rgba(248,187,208,.08)"/>
  <circle cx="67" cy="22" r="2" fill="white" opacity=".9"/><circle cx="67" cy="24" r="2.5" fill="#4a0030"/>
  <ellipse cx="55" cy="36" rx="12" ry="9" fill="#2e1430"/>
  <ellipse cx="55" cy="37" rx="10" ry="7" fill="#3a1c3e"/>
  <ellipse cx="50" cy="38" rx="3.5" ry="2.5" fill="#5a2050" opacity=".9"/>
  <ellipse cx="60" cy="38" rx="3.5" ry="2.5" fill="#5a2050" opacity=".9"/>
  <path d="M 44 46 Q 55 54 66 46" stroke="#3a1836" stroke-width="3" fill="none" stroke-linecap="round"/>
  <path d="M 45 47 Q 55 55 65 47" stroke="#f48fb1" stroke-width="2" fill="none" stroke-linecap="round" opacity=".7"/>
  <ellipse cx="55" cy="30" rx="28" ry="26" fill="none" stroke="rgba(244,143,177,.2)" stroke-width="4"/>
</svg>`,

  INDUSTRY: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_ind" cx="50%" cy="50%" r="65%"><stop offset="0%" stop-color="#261a04"/><stop offset="100%" stop-color="#060408"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_ind)"/>
  <ellipse cx="55" cy="50" rx="46" ry="24" fill="rgba(255,152,0,.05)"/>
  <ellipse cx="55" cy="70" rx="38" ry="3" fill="rgba(0,0,0,.6)"/>
  <rect x="8" y="38" width="94" height="30" rx="3" fill="#221c08" stroke="rgba(255,152,0,.12)" stroke-width=".5"/>
  <rect x="12" y="42" width="28" height="22" rx="2" fill="#2a2210"/>
  <rect x="44" y="42" width="22" height="22" rx="2" fill="#262010"/>
  <rect x="70" y="42" width="28" height="22" rx="2" fill="#2a2210"/>
  <rect x="22" y="18" width="12" height="24" rx="3" fill="#261e08"/>
  <rect x="50" y="22" width="10" height="20" rx="3" fill="#221c08"/>
  <rect x="76" y="16" width="12" height="26" rx="3" fill="#261e08"/>
  <ellipse cx="28" cy="16" rx="9" ry="6" fill="#2e280c" opacity=".8"/>
  <ellipse cx="28" cy="11" rx="7" ry="5" fill="#342e10" opacity=".7"/>
  <ellipse cx="28" cy="6" rx="5" ry="4" fill="#3a3212" opacity=".5"/>
  <ellipse cx="55" cy="20" rx="8" ry="5" fill="#2e280c" opacity=".7"/>
  <ellipse cx="82" cy="14" rx="9" ry="6" fill="#2e280c" opacity=".8"/>
  <ellipse cx="82" cy="9" rx="7" ry="5" fill="#342e10" opacity=".6"/>
  <circle cx="55" cy="52" r="10" fill="#1e1808"/>
  <circle cx="55" cy="52" r="7" fill="#261e0c"/>
  <circle cx="55" cy="52" r="4" fill="#302610"/>
  <rect x="51" y="40" width="8" height="6" rx="1" fill="#282008"/>
  <rect x="51" y="58" width="8" height="6" rx="1" fill="#282008"/>
  <rect x="43" y="48" width="6" height="8" rx="1" fill="#282008"/>
  <rect x="61" y="48" width="6" height="8" rx="1" fill="#282008"/>
  <circle cx="55" cy="52" r="6" fill="#ffd740" opacity=".35"/>
  <circle cx="55" cy="52" r="3" fill="#ffd740" opacity=".5"/>
  <circle cx="28" cy="13" r="5" fill="#ff9800"/><circle cx="28" cy="13" r="8" fill="rgba(255,152,0,.45)"/><circle cx="28" cy="13" r="13" fill="rgba(255,152,0,.12)"/>
  <circle cx="82" cy="11" r="4" fill="#ffd740"/><circle cx="82" cy="11" r="7" fill="rgba(255,215,64,.4)"/><circle cx="82" cy="11" r="11" fill="rgba(255,215,64,.1)"/>
  <rect x="14" y="46" width="8" height="6" rx="1" fill="#ffd740" opacity=".5"/>
  <rect x="26" y="46" width="8" height="6" rx="1" fill="#ff9800" opacity=".4"/>
  <rect x="72" y="46" width="8" height="6" rx="1" fill="#ffd740" opacity=".5"/>
  <rect x="84" y="46" width="8" height="6" rx="1" fill="#ff9800" opacity=".4"/>
</svg>`,

  SLACKER: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_slacker" cx="50%" cy="40%" r="60%"><stop offset="0%" stop-color="#0a0e12"/><stop offset="100%" stop-color="#030405"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_slacker)"/>
  <circle cx="55" cy="14" r="11" fill="#161e22" opacity=".8"/>
  <rect x="42" y="25" width="26" height="24" rx="5" fill="#141c20" opacity=".75"/>
  <rect x="26" y="27" width="16" height="8" rx="4" fill="#121a1e" opacity=".65"/>
  <rect x="68" y="27" width="16" height="8" rx="4" fill="#121a1e" opacity=".65"/>
  <rect x="44" y="49" width="8" height="17" rx="3" fill="#141c20" opacity=".7"/>
  <rect x="58" y="49" width="8" height="17" rx="3" fill="#141c20" opacity=".7"/>
  <line x1="12" y1="8" x2="98" y2="64" stroke="rgba(84,110,122,.5)" stroke-width="12" stroke-linecap="round"/>
  <line x1="98" y1="8" x2="12" y2="64" stroke="rgba(84,110,122,.5)" stroke-width="12" stroke-linecap="round"/>
  <line x1="12" y1="8" x2="98" y2="64" stroke="#78909c" stroke-width="5" stroke-linecap="round"/>
  <line x1="98" y1="8" x2="12" y2="64" stroke="#78909c" stroke-width="5" stroke-linecap="round"/>
</svg>`,

  INVISIBLE_MAN: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_inv" cx="50%" cy="40%" r="65%"><stop offset="0%" stop-color="#0a1010"/><stop offset="100%" stop-color="#030408"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_inv)"/>
  <ellipse cx="55" cy="38" rx="42" ry="28" fill="rgba(100,200,100,.04)"/>
  <ellipse cx="55" cy="68" rx="28" ry="3" fill="rgba(0,0,0,.5)"/>
  <ellipse cx="55" cy="50" rx="22" ry="14" fill="#0c1810" stroke="rgba(100,200,100,.12)" stroke-width=".5"/>
  <rect x="36" y="36" width="38" height="20" rx="6" fill="#0e1c10" stroke="rgba(100,200,100,.1)" stroke-width=".5" stroke-dasharray="3 2"/>
  <ellipse cx="55" cy="24" rx="18" ry="14" fill="#0c1810" stroke="rgba(100,200,100,.1)" stroke-width=".5" stroke-dasharray="2 3"/>
  <circle cx="45" cy="20" r="4" fill="rgba(100,200,100,.08)"/>
  <circle cx="65" cy="20" r="4" fill="rgba(100,200,100,.08)"/>
  <rect x="36" y="12" width="38" height="12" rx="5" fill="#0e1c10" stroke="rgba(100,200,100,.08)" stroke-width=".5" stroke-dasharray="4 2"/>
  <line x1="18" y1="28" x2="40" y2="38" stroke="rgba(100,200,100,.15)" stroke-width="3" stroke-linecap="round" stroke-dasharray="5 3"/>
  <line x1="92" y1="28" x2="70" y2="38" stroke="rgba(100,200,100,.15)" stroke-width="3" stroke-linecap="round" stroke-dasharray="5 3"/>
  <circle cx="55" cy="8" r="4" fill="#69f0ae"/><circle cx="55" cy="8" r="7" fill="rgba(105,240,174,.4)"/><circle cx="55" cy="8" r="11" fill="rgba(105,240,174,.12)"/>
</svg>`,

  SHUTTLE: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_shu" cx="50%" cy="42%" r="62%"><stop offset="0%" stop-color="#1e1004"/><stop offset="100%" stop-color="#060304"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_shu)"/>
  <ellipse cx="55" cy="68" rx="28" ry="3" fill="rgba(0,0,0,.5)"/>
  <rect x="30" y="48" width="50" height="18" rx="4" fill="#2a1a08" stroke="rgba(210,140,60,.15)" stroke-width=".5"/>
  <rect x="22" y="52" width="16" height="10" rx="3" fill="#241408"/>
  <rect x="72" y="52" width="16" height="10" rx="3" fill="#241408"/>
  <ellipse cx="55" cy="36" rx="26" ry="20" fill="#281808" stroke="rgba(210,140,60,.2)" stroke-width=".5"/>
  <ellipse cx="55" cy="34" rx="22" ry="16" fill="#301e0c"/>
  <rect x="42" y="22" width="26" height="14" rx="5" fill="#d4874a" opacity=".7"/>
  <rect x="44" y="23" width="22" height="12" rx="4" fill="#e8a060" opacity=".6"/>
  <rect x="46" y="25" width="8" height="4" rx="1" fill="rgba(255,255,255,.4)"/>
  <rect x="57" y="25" width="8" height="4" rx="1" fill="rgba(255,255,255,.3)"/>
  <ellipse cx="55" cy="46" rx="14" ry="4" fill="#221408"/>
  <circle cx="55" cy="8" r="4" fill="#d4874a"/><circle cx="55" cy="8" r="7" fill="rgba(212,135,74,.45)"/><circle cx="55" cy="8" r="11" fill="rgba(212,135,74,.12)"/>
</svg>`,

  CHLORELLA: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_chl" cx="50%" cy="42%" r="65%"><stop offset="0%" stop-color="#04161e"/><stop offset="100%" stop-color="#020608"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_chl)"/>
  <ellipse cx="55" cy="52" rx="44" ry="20" fill="rgba(38,198,218,.06)"/>
  <ellipse cx="55" cy="68" rx="36" ry="3" fill="rgba(0,0,0,.5)"/>
  <rect x="8" y="46" width="94" height="22" rx="4" fill="#061c24" stroke="rgba(38,198,218,.15)" stroke-width=".5"/>
  <ellipse cx="24" cy="57" rx="10" ry="6" fill="#081c28"/>
  <ellipse cx="55" cy="57" rx="12" ry="7" fill="#062030"/>
  <ellipse cx="86" cy="57" rx="10" ry="6" fill="#081c28"/>
  <ellipse cx="24" cy="55" rx="7" ry="4" fill="#26c6da" opacity=".3"/>
  <ellipse cx="55" cy="55" rx="8" ry="5" fill="#26c6da" opacity=".4"/>
  <ellipse cx="86" cy="55" rx="7" ry="4" fill="#26c6da" opacity=".3"/>
  <path d="M 30 46 Q 45 30 55 36 Q 65 42 80 24" stroke="rgba(38,198,218,.5)" stroke-width="2" fill="none" stroke-linecap="round"/>
  <circle cx="80" cy="24" r="3" fill="#26c6da" opacity=".8"/>
  <rect x="36" y="14" width="38" height="6" rx="3" fill="#062028" stroke="rgba(38,198,218,.3)" stroke-width=".5"/>
  <rect x="38" y="15" width="34" height="4" rx="2" fill="rgba(38,198,218,.2)"/>
  <circle cx="55" cy="8" r="4" fill="#26c6da"/><circle cx="55" cy="8" r="7" fill="rgba(38,198,218,.45)"/><circle cx="55" cy="8" r="11" fill="rgba(38,198,218,.12)"/>
</svg>`,

  DRONE_VENDING: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_dv" cx="50%" cy="46%" r="65%"><stop offset="0%" stop-color="#06180e"/><stop offset="100%" stop-color="#020608"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_dv)"/>
  <ellipse cx="55" cy="68" rx="32" ry="3" fill="rgba(0,0,0,.5)"/>
  <rect x="16" y="18" width="78" height="50" rx="5" fill="#0c2016" stroke="rgba(0,230,118,.15)" stroke-width=".5"/>
  <rect x="20" y="22" width="70" height="42" rx="4" fill="#102818"/>
  <rect x="24" y="26" width="28" height="18" rx="2" fill="#0c2010"/>
  <rect x="58" y="26" width="28" height="18" rx="2" fill="#0c2010"/>
  <circle cx="38" cy="35" r="7" fill="#1c3820"/><circle cx="38" cy="35" r="5" fill="#243e28"/><circle cx="38" cy="35" r="3" fill="#00e676" opacity=".7"/>
  <circle cx="72" cy="35" r="7" fill="#1c3820"/><circle cx="72" cy="35" r="5" fill="#243e28"/><circle cx="72" cy="35" r="3" fill="#00e676" opacity=".7"/>
  <rect x="24" y="50" width="62" height="8" rx="2" fill="#0c2010"/>
  <rect x="40" y="52" width="30" height="4" rx="2" fill="rgba(0,230,118,.3)"/>
  <rect x="46" y="10" width="18" height="10" rx="3" fill="#0c2010"/>
  <circle cx="55" cy="8" r="4" fill="#00e676"/><circle cx="55" cy="8" r="7" fill="rgba(0,230,118,.45)"/><circle cx="55" cy="8" r="11" fill="rgba(0,230,118,.12)"/>
</svg>`,

  UPGRADE_MILL: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_um" cx="50%" cy="44%" r="65%"><stop offset="0%" stop-color="#1e1600"/><stop offset="100%" stop-color="#060500"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_um)"/>
  <ellipse cx="55" cy="68" rx="30" ry="3" fill="rgba(0,0,0,.5)"/>
  <rect x="22" y="40" width="66" height="28" rx="4" fill="#2c2208" stroke="rgba(255,193,7,.15)" stroke-width=".5"/>
  <rect x="26" y="44" width="28" height="20" rx="2" fill="#241c06"/>
  <rect x="58" y="44" width="26" height="20" rx="2" fill="#221a06"/>
  <ellipse cx="40" cy="40" rx="10" ry="6" fill="#ffc107" opacity=".2"/>
  <polygon points="40,14 46,28 34,28" fill="#ffc107" opacity=".7"/>
  <polygon points="40,18 44,26 36,26" fill="#ffe082" opacity=".5"/>
  <polygon points="70,18 76,32 64,32" fill="#ffd740" opacity=".8"/>
  <polygon points="70,20 74,30 66,30" fill="#fff59d" opacity=".6"/>
  <line x1="40" y1="28" x2="40" y2="40" stroke="rgba(255,193,7,.4)" stroke-width="2" stroke-dasharray="3 2"/>
  <line x1="70" y1="32" x2="70" y2="44" stroke="rgba(255,215,64,.4)" stroke-width="2" stroke-dasharray="3 2"/>
  <rect x="36" y="56" width="8" height="8" rx="1" fill="#ffc107" opacity=".5"/>
  <rect x="66" y="56" width="8" height="8" rx="1" fill="#ffd740" opacity=".6"/>
  <circle cx="55" cy="8" r="4" fill="#ffc107"/><circle cx="55" cy="8" r="7" fill="rgba(255,193,7,.45)"/><circle cx="55" cy="8" r="11" fill="rgba(255,193,7,.12)"/>
</svg>`,

  TURRET_PILOT: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_tp" cx="50%" cy="44%" r="65%"><stop offset="0%" stop-color="#0c1420"/><stop offset="100%" stop-color="#030408"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_tp)"/>
  <ellipse cx="55" cy="68" rx="30" ry="3" fill="rgba(0,0,0,.5)"/>
  <ellipse cx="55" cy="56" rx="28" ry="14" fill="#101c2e" stroke="rgba(100,180,255,.12)" stroke-width=".5"/>
  <rect x="34" y="44" width="42" height="18" rx="4" fill="#121c2c"/>
  <rect x="44" y="44" width="22" height="10" rx="2" fill="#1a2840"/>
  <ellipse cx="55" cy="44" rx="12" ry="5" fill="#141e30"/>
  <rect x="48" y="26" width="14" height="20" rx="3" fill="#101828"/>
  <rect x="52" y="22" width="6" height="10" rx="2" fill="#0e1624"/>
  <line x1="55" y1="22" x2="96" y2="10" stroke="#64b4ff" stroke-width="2" stroke-linecap="round" opacity=".8"/>
  <line x1="55" y1="24" x2="14" y2="16" stroke="#64b4ff" stroke-width="1.5" stroke-linecap="round" opacity=".5"/>
  <circle cx="96" cy="10" r="4" fill="none" stroke="#64b4ff" stroke-width="1.5" opacity=".7"/>
  <circle cx="96" cy="10" r="1.5" fill="#64b4ff"/>
  <circle cx="55" cy="8" r="4" fill="#64b4ff"/><circle cx="55" cy="8" r="7" fill="rgba(100,180,255,.45)"/><circle cx="55" cy="8" r="11" fill="rgba(100,180,255,.12)"/>
</svg>`,

  WINDMASTER: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_wm" cx="50%" cy="40%" r="65%"><stop offset="0%" stop-color="#041418"/><stop offset="100%" stop-color="#020608"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_wm)"/>
  <ellipse cx="55" cy="68" rx="26" ry="3" fill="rgba(0,0,0,.5)"/>
  <path d="M 10 40 Q 30 20 55 36 Q 80 52 100 32" stroke="rgba(100,220,200,.4)" stroke-width="3" fill="none" stroke-linecap="round"/>
  <path d="M 10 46 Q 35 28 55 42 Q 75 56 100 38" stroke="rgba(100,220,200,.25)" stroke-width="2" fill="none" stroke-linecap="round"/>
  <path d="M 16 54 Q 38 38 55 48 Q 72 58 96 46" stroke="rgba(100,220,200,.15)" stroke-width="1.5" fill="none" stroke-linecap="round"/>
  <ellipse cx="55" cy="38" rx="14" ry="18" fill="#061c20" stroke="rgba(100,220,200,.2)" stroke-width=".5"/>
  <ellipse cx="55" cy="36" rx="11" ry="15" fill="#082228"/>
  <ellipse cx="42" cy="24" rx="8" ry="10" fill="#062020"/>
  <ellipse cx="68" cy="24" rx="8" ry="10" fill="#062020"/>
  <circle cx="55" cy="36" r="5" fill="#64dcc8" opacity=".6"/>
  <circle cx="55" cy="36" r="3" fill="#80e8d8" opacity=".8"/>
  <circle cx="55" cy="8" r="4" fill="#64dcc8"/><circle cx="55" cy="8" r="7" fill="rgba(100,220,200,.45)"/><circle cx="55" cy="8" r="11" fill="rgba(100,220,200,.12)"/>
</svg>`,

  UGLYQUEEN: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_uq" cx="50%" cy="38%" r="62%"><stop offset="0%" stop-color="#280c28"/><stop offset="100%" stop-color="#080208"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_uq)"/>
  <ellipse cx="55" cy="38" rx="42" ry="28" fill="rgba(244,143,177,.05)"/>
  <ellipse cx="55" cy="68" rx="28" ry="3" fill="rgba(0,0,0,.5)"/>
  <polygon points="36,16 28,30 82,30 74,16 64,22 55,14 46,22" fill="#3a1040" stroke="rgba(244,143,177,.2)" stroke-width=".5"/>
  <polygon points="38,18 32,28 78,28 72,18 63,23 55,16 47,23" fill="#481448"/>
  <ellipse cx="55" cy="42" rx="26" ry="20" fill="#341040" stroke="rgba(244,143,177,.15)" stroke-width=".5"/>
  <ellipse cx="55" cy="41" rx="23" ry="17" fill="#3c1448"/>
  <circle cx="44" cy="36" r="5" fill="#f06292"/><circle cx="44" cy="36" r="8" fill="rgba(240,98,146,.3)"/><circle cx="44" cy="34" r="2" fill="white" opacity=".8"/>
  <circle cx="66" cy="36" r="5" fill="#f06292"/><circle cx="66" cy="36" r="8" fill="rgba(240,98,146,.3)"/><circle cx="66" cy="34" r="2" fill="white" opacity=".8"/>
  <ellipse cx="55" cy="46" rx="10" ry="7" fill="#301038"/>
  <path d="M 44 52 Q 55 62 66 52" stroke="#441250" stroke-width="3" fill="none" stroke-linecap="round"/>
  <path d="M 45 53 Q 55 61 65 53" stroke="#f48fb1" stroke-width="2" fill="none" stroke-linecap="round" opacity=".7"/>
  <circle cx="55" cy="8" r="4" fill="#f48fb1"/><circle cx="55" cy="8" r="7" fill="rgba(244,143,177,.45)"/><circle cx="55" cy="8" r="11" fill="rgba(244,143,177,.12)"/>
</svg>`,

  COWSHED: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_cow" cx="50%" cy="46%" r="65%"><stop offset="0%" stop-color="#161004"/><stop offset="100%" stop-color="#050304"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_cow)"/>
  <ellipse cx="55" cy="68" rx="36" ry="3" fill="rgba(0,0,0,.5)"/>
  <rect x="10" y="34" width="90" height="34" rx="4" fill="#1c1808" stroke="rgba(180,140,80,.15)" stroke-width=".5"/>
  <polygon points="10,34 55,12 100,34" fill="#241e0c" stroke="rgba(180,140,80,.2)" stroke-width=".5"/>
  <polygon points="14,34 55,15 96,34" fill="#2c2410"/>
  <rect x="22" y="42" width="18" height="20" rx="2" fill="#181408"/>
  <rect x="70" y="42" width="18" height="20" rx="2" fill="#181408"/>
  <rect x="44" y="46" width="22" height="16" rx="3" fill="#1e1a0c" stroke="rgba(180,140,80,.12)" stroke-width=".5"/>
  <rect x="46" y="48" width="18" height="12" rx="2" fill="#221e0e"/>
  <ellipse cx="55" cy="38" rx="14" ry="8" fill="#24200e"/>
  <circle cx="42" cy="26" r="4" fill="#b48c50" opacity=".6"/>
  <circle cx="68" cy="26" r="4" fill="#b48c50" opacity=".6"/>
  <circle cx="55" cy="8" r="4" fill="#b48c50"/><circle cx="55" cy="8" r="7" fill="rgba(180,140,80,.45)"/><circle cx="55" cy="8" r="11" fill="rgba(180,140,80,.12)"/>
</svg>`,

  CHOMP: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_chp" cx="50%" cy="40%" r="62%"><stop offset="0%" stop-color="#1c0606"/><stop offset="100%" stop-color="#050202"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_chp)"/>
  <ellipse cx="55" cy="68" rx="28" ry="3" fill="rgba(0,0,0,.5)"/>
  <ellipse cx="55" cy="38" rx="38" ry="28" fill="rgba(255,100,80,.05)"/>
  <path d="M 20 44 Q 55 20 90 44" stroke="#2c1010" stroke-width="18" fill="none" stroke-linecap="round"/>
  <path d="M 22 44 Q 55 22 88 44" stroke="#381414" stroke-width="12" fill="none" stroke-linecap="round"/>
  <path d="M 24 44 Q 55 24 86 44" stroke="#441818" stroke-width="6" fill="none" stroke-linecap="round"/>
  <rect x="28" y="42" width="54" height="22" rx="5" fill="#2c1010" stroke="rgba(255,100,80,.15)" stroke-width=".5"/>
  <rect x="32" y="46" width="46" height="14" rx="3" fill="#341414"/>
  <ellipse cx="40" cy="43" rx="5" ry="3" fill="#441818"/>
  <ellipse cx="55" cy="43" rx="5" ry="3" fill="#3c1414"/>
  <ellipse cx="70" cy="43" rx="5" ry="3" fill="#441818"/>
  <circle cx="44" cy="32" r="4" fill="#241010"/><circle cx="44" cy="32" r="2.5" fill="#2c1010"/><circle cx="44" cy="32" r="1" fill="#ff6450" opacity=".8"/>
  <circle cx="66" cy="32" r="4" fill="#241010"/><circle cx="66" cy="32" r="2.5" fill="#2c1010"/><circle cx="66" cy="32" r="1" fill="#ff6450" opacity=".8"/>
  <circle cx="55" cy="8" r="4" fill="#ff6450"/><circle cx="55" cy="8" r="7" fill="rgba(255,100,80,.45)"/><circle cx="55" cy="8" r="11" fill="rgba(255,100,80,.12)"/>
</svg>`,

  CRAM_SCHOOL: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_cs" cx="50%" cy="44%" r="65%"><stop offset="0%" stop-color="#141800"/><stop offset="100%" stop-color="#040500"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_cs)"/>
  <ellipse cx="55" cy="68" rx="32" ry="3" fill="rgba(0,0,0,.5)"/>
  <rect x="14" y="28" width="82" height="40" rx="4" fill="#1c2204" stroke="rgba(200,220,80,.12)" stroke-width=".5"/>
  <rect x="18" y="32" width="36" height="28" rx="2" fill="#222a06"/>
  <rect x="58" y="32" width="34" height="28" rx="2" fill="#1e2806"/>
  <rect x="22" y="36" width="28" height="2" rx="1" fill="rgba(200,220,80,.4)"/>
  <rect x="22" y="40" width="24" height="2" rx="1" fill="rgba(200,220,80,.3)"/>
  <rect x="22" y="44" width="26" height="2" rx="1" fill="rgba(200,220,80,.35)"/>
  <rect x="22" y="48" width="20" height="2" rx="1" fill="rgba(200,220,80,.25)"/>
  <rect x="62" y="36" width="26" height="2" rx="1" fill="rgba(200,220,80,.35)"/>
  <rect x="62" y="40" width="22" height="2" rx="1" fill="rgba(200,220,80,.3)"/>
  <rect x="62" y="44" width="24" height="2" rx="1" fill="rgba(200,220,80,.25)"/>
  <polygon points="14,28 55,12 96,28" fill="#202800" stroke="rgba(200,220,80,.15)" stroke-width=".5"/>
  <polygon points="18,28 55,15 92,28" fill="#283006"/>
  <circle cx="55" cy="8" r="4" fill="#c8dc50"/><circle cx="55" cy="8" r="7" fill="rgba(200,220,80,.45)"/><circle cx="55" cy="8" r="11" fill="rgba(200,220,80,.12)"/>
</svg>`,

  LANLANLOU: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_lll" cx="50%" cy="40%" r="65%"><stop offset="0%" stop-color="#1a0428"/><stop offset="100%" stop-color="#060108"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_lll)"/>
  <ellipse cx="55" cy="68" rx="28" ry="3" fill="rgba(0,0,0,.5)"/>
  <ellipse cx="38" cy="48" rx="12" ry="18" fill="#200832" stroke="rgba(230,100,220,.15)" stroke-width=".5" transform="rotate(-15 38 48)"/>
  <ellipse cx="55" cy="42" rx="10" ry="22" fill="#280b3c" stroke="rgba(230,100,220,.18)" stroke-width=".5"/>
  <ellipse cx="72" cy="48" rx="12" ry="18" fill="#200832" stroke="rgba(230,100,220,.15)" stroke-width=".5" transform="rotate(15 72 48)"/>
  <ellipse cx="38" cy="44" rx="8" ry="12" fill="#e064dc" opacity=".3"/>
  <ellipse cx="55" cy="40" rx="7" ry="14" fill="#e064dc" opacity=".4"/>
  <ellipse cx="72" cy="44" rx="8" ry="12" fill="#e064dc" opacity=".3"/>
  <ellipse cx="55" cy="22" rx="12" ry="10" fill="#240a38"/>
  <circle cx="47" cy="18" r="3" fill="#e064dc" opacity=".6"/>
  <circle cx="63" cy="18" r="3" fill="#e064dc" opacity=".6"/>
  <circle cx="55" cy="8" r="4" fill="#e064dc"/><circle cx="55" cy="8" r="7" fill="rgba(230,100,220,.45)"/><circle cx="55" cy="8" r="11" fill="rgba(230,100,220,.12)"/>
</svg>`,

  MAGIC_SHOPPING: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_ms" cx="50%" cy="46%" r="65%"><stop offset="0%" stop-color="#1e1400"/><stop offset="100%" stop-color="#060500"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_ms)"/>
  <ellipse cx="55" cy="68" rx="34" ry="3" fill="rgba(0,0,0,.5)"/>
  <rect x="8" y="22" width="94" height="46" rx="4" fill="#281c04" stroke="rgba(255,193,7,.15)" stroke-width=".5"/>
  <rect x="12" y="26" width="86" height="38" rx="3" fill="#302008"/>
  <rect x="16" y="28" width="40" height="22" rx="2" fill="#382810"/>
  <rect x="60" y="28" width="34" height="22" rx="2" fill="#342410"/>
  <ellipse cx="36" cy="39" rx="14" ry="8" fill="#ffc107" opacity=".2"/>
  <circle cx="36" cy="39" r="8" fill="#201800"/><circle cx="36" cy="39" r="6" fill="#2c2008"/><circle cx="36" cy="39" r="4" fill="#ffc107" opacity=".6"/>
  <rect x="18" y="54" width="36" height="6" rx="2" fill="#2c2008"/>
  <rect x="19" y="55" width="34" height="4" rx="1" fill="rgba(255,193,7,.25)"/>
  <text x="77" y="45" text-anchor="middle" font-size="16" fill="#ffc107" opacity=".8" font-family="monospace">📺</text>
  <circle cx="55" cy="8" r="4" fill="#ffc107"/><circle cx="55" cy="8" r="7" fill="rgba(255,193,7,.45)"/><circle cx="55" cy="8" r="11" fill="rgba(255,193,7,.12)"/>
</svg>`,

  SUPERLING: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_sl" cx="50%" cy="40%" r="65%"><stop offset="0%" stop-color="#081606"/><stop offset="100%" stop-color="#020506"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_sl)"/>
  <ellipse cx="55" cy="68" rx="26" ry="3" fill="rgba(0,0,0,.5)"/>
  <ellipse cx="55" cy="40" rx="36" ry="26" fill="rgba(105,240,174,.04)"/>
  <path d="M 22 68 Q 38 58 48 48 Q 55 42 62 48 Q 72 58 88 68" stroke="#0e2410" stroke-width="12" fill="none" stroke-linecap="round"/>
  <path d="M 24 68 Q 40 58 50 48 Q 55 43 60 48 Q 70 58 86 68" stroke="#142c14" stroke-width="8" fill="none" stroke-linecap="round"/>
  <ellipse cx="55" cy="34" rx="20" ry="16" fill="#122018" stroke="rgba(105,240,174,.15)" stroke-width=".5"/>
  <ellipse cx="55" cy="32" rx="17" ry="14" fill="#182c1c"/>
  <circle cx="45" cy="28" r="5" fill="#69f0ae"/><circle cx="45" cy="28" r="8" fill="rgba(105,240,174,.35)"/><circle cx="45" cy="26" r="2" fill="rgba(0,0,0,.8)"/>
  <circle cx="65" cy="28" r="5" fill="#69f0ae"/><circle cx="65" cy="28" r="8" fill="rgba(105,240,174,.35)"/><circle cx="65" cy="26" r="2" fill="rgba(0,0,0,.8)"/>
  <circle cx="55" cy="8" r="4" fill="#69f0ae"/><circle cx="55" cy="8" r="7" fill="rgba(105,240,174,.45)"/><circle cx="55" cy="8" r="11" fill="rgba(105,240,174,.12)"/>
</svg>`,

  ZEALOT: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_zl" cx="50%" cy="38%" r="62%"><stop offset="0%" stop-color="#060c26"/><stop offset="100%" stop-color="#020308"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_zl)"/>
  <ellipse cx="55" cy="40" rx="42" ry="28" fill="rgba(100,140,255,.04)"/>
  <ellipse cx="55" cy="68" rx="28" ry="3" fill="rgba(0,0,0,.5)"/>
  <rect x="32" y="50" width="14" height="18" rx="3" fill="#0c1234"/>
  <rect x="64" y="50" width="14" height="18" rx="3" fill="#0a1030"/>
  <rect x="26" y="30" width="58" height="24" rx="6" fill="#0e1838" stroke="rgba(100,140,255,.2)" stroke-width=".5"/>
  <rect x="30" y="34" width="22" height="16" rx="3" fill="#121e44"/>
  <rect x="58" y="34" width="22" height="16" rx="3" fill="#101c40"/>
  <rect x="12" y="32" width="18" height="8" rx="3" fill="#0c1430"/>
  <rect x="80" y="32" width="18" height="8" rx="3" fill="#0c1430"/>
  <line x1="12" y1="36" x2="0" y2="30" stroke="#6488ff" stroke-width="3" stroke-linecap="round" opacity=".8"/>
  <line x1="98" y1="36" x2="110" y2="30" stroke="#6488ff" stroke-width="3" stroke-linecap="round" opacity=".8"/>
  <ellipse cx="55" cy="20" rx="14" ry="12" fill="#101838"/>
  <ellipse cx="55" cy="18" rx="12" ry="10" fill="#141e44"/>
  <rect x="46" y="14" width="18" height="7" rx="3" fill="#1a2858"/>
  <rect x="48" y="15" width="14" height="5" rx="2" fill="#6488ff" opacity=".7"/>
  <circle cx="55" cy="8" r="4" fill="#6488ff"/><circle cx="55" cy="8" r="7" fill="rgba(100,136,255,.45)"/><circle cx="55" cy="8" r="11" fill="rgba(100,136,255,.12)"/>
</svg>`,

  SIBERIA_SNOWMAN: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_ss" cx="50%" cy="38%" r="65%"><stop offset="0%" stop-color="#081822"/><stop offset="100%" stop-color="#020608"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_ss)"/>
  <ellipse cx="55" cy="68" rx="30" ry="3" fill="rgba(0,0,0,.5)"/>
  <ellipse cx="55" cy="42" rx="30" ry="24" fill="#0c2030" stroke="rgba(180,230,255,.1)" stroke-width=".5"/>
  <ellipse cx="55" cy="41" rx="26" ry="20" fill="#102838"/>
  <ellipse cx="55" cy="22" rx="16" ry="12" fill="#0e2232" stroke="rgba(180,230,255,.12)" stroke-width=".5"/>
  <ellipse cx="55" cy="21" rx="13" ry="10" fill="#122c40"/>
  <circle cx="47" cy="18" r="3" fill="#b4e6ff"/><circle cx="47" cy="18" r="5" fill="rgba(180,230,255,.35)"/><circle cx="47" cy="17" r="1" fill="rgba(0,0,0,.9)"/>
  <circle cx="63" cy="18" r="3" fill="#b4e6ff"/><circle cx="63" cy="18" r="5" fill="rgba(180,230,255,.35)"/><circle cx="63" cy="17" r="1" fill="rgba(0,0,0,.9)"/>
  <ellipse cx="55" cy="24" rx="6" ry="4" fill="#0e2030"/>
  <ellipse cx="55" cy="25" rx="5" ry="3" fill="#ff8a65" opacity=".8"/>
  <rect x="30" y="10" width="50" height="5" rx="2" fill="#1c3a50"/>
  <rect x="32" y="11" width="46" height="3" rx="1" fill="#b4e6ff" opacity=".5"/>
  <line x1="18" y1="40" x2="36" y2="44" stroke="#0c2030" stroke-width="5" stroke-linecap="round"/>
  <line x1="92" y1="40" x2="74" y2="44" stroke="#0c2030" stroke-width="5" stroke-linecap="round"/>
  <circle cx="45" cy="40" r="3" fill="#b4e6ff" opacity=".6"/>
  <circle cx="55" cy="42" r="3" fill="#b4e6ff" opacity=".6"/>
  <circle cx="65" cy="40" r="3" fill="#b4e6ff" opacity=".6"/>
  <circle cx="55" cy="8" r="4" fill="#b4e6ff"/><circle cx="55" cy="8" r="7" fill="rgba(180,230,255,.45)"/><circle cx="55" cy="8" r="11" fill="rgba(180,230,255,.12)"/>
</svg>`,

  RANDOMBOX: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="g_rb" cx="50%" cy="46%" r="65%"><stop offset="0%" stop-color="#140a20"/><stop offset="100%" stop-color="#040208"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#g_rb)"/>
  <ellipse cx="55" cy="68" rx="30" ry="3" fill="rgba(0,0,0,.5)"/>
  <rect x="20" y="30" width="70" height="38" rx="4" fill="#1e1030" stroke="rgba(180,100,255,.15)" stroke-width=".5"/>
  <rect x="24" y="34" width="62" height="30" rx="3" fill="#221438"/>
  <rect x="20" y="24" width="70" height="10" rx="3" fill="#281842"/>
  <rect x="46" y="18" width="18" height="12" rx="3" fill="#2c1c48"/>
  <line x1="55" y1="24" x2="55" y2="68" stroke="rgba(180,100,255,.35)" stroke-width="1.5"/>
  <line x1="20" y1="34" x2="90" y2="34" stroke="rgba(180,100,255,.25)" stroke-width="1"/>
  <circle cx="38" cy="48" r="5" fill="#ff5252" opacity=".7"/>
  <circle cx="55" cy="48" r="5" fill="#ffd740" opacity=".7"/>
  <circle cx="72" cy="48" r="5" fill="#69f0ae" opacity=".7"/>
  <circle cx="38" cy="56" r="5" fill="#29b6f6" opacity=".7"/>
  <circle cx="55" cy="56" r="5" fill="#ab47bc" opacity=".7"/>
  <circle cx="72" cy="56" r="5" fill="#ff9800" opacity=".7"/>
  <circle cx="55" cy="8" r="4" fill="#b464ff"/><circle cx="55" cy="8" r="7" fill="rgba(180,100,255,.45)"/><circle cx="55" cy="8" r="11" fill="rgba(180,100,255,.12)"/>
</svg>`,

  MAGIC_DRAW: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="mgd" cx="50%" cy="50%"><stop offset="0%" stop-color="#1a0a2e"/><stop offset="100%" stop-color="#060610"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#mgd)"/>
  <circle cx="55" cy="38" r="22" fill="none" stroke="rgba(180,100,255,.4)" stroke-width="1.5"/>
  <circle cx="55" cy="38" r="14" fill="rgba(180,100,255,.12)"/>
  <text x="55" y="43" text-anchor="middle" font-size="18" fill="#b464ff">🔮</text>
  <line x1="42" y1="22" x2="44" y2="28" stroke="#ffd740" stroke-width="1.5" opacity=".8"/>
  <line x1="68" y1="22" x2="66" y2="28" stroke="#ffd740" stroke-width="1.5" opacity=".8"/>
  <line x1="30" y1="38" x2="36" y2="38" stroke="#ffd740" stroke-width="1.5" opacity=".8"/>
  <line x1="80" y1="38" x2="74" y2="38" stroke="#ffd740" stroke-width="1.5" opacity=".8"/>
  <circle cx="55" cy="8" r="4" fill="#ffd740"/><circle cx="55" cy="8" r="7" fill="rgba(255,215,64,.4)"/><circle cx="55" cy="8" r="11" fill="rgba(255,215,64,.12)"/>
</svg>`,

  MAGIC_MINERAL: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="mgm" cx="50%" cy="50%"><stop offset="0%" stop-color="#0a1a10"/><stop offset="100%" stop-color="#060610"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#mgm)"/>
  <polygon points="55,20 65,35 55,50 45,35" fill="rgba(41,182,246,.15)" stroke="rgba(41,182,246,.6)" stroke-width="1.5"/>
  <polygon points="55,25 62,35 55,45 48,35" fill="rgba(255,215,64,.2)"/>
  <text x="55" y="41" text-anchor="middle" font-size="16" fill="#ffd740">✨</text>
  <circle cx="38" cy="28" r="3" fill="rgba(255,215,64,.5)"/>
  <circle cx="72" cy="28" r="3" fill="rgba(255,215,64,.5)"/>
  <circle cx="38" cy="48" r="2" fill="rgba(41,182,246,.4)"/>
  <circle cx="72" cy="48" r="2" fill="rgba(41,182,246,.4)"/>
  <circle cx="55" cy="8" r="4" fill="#ffd740"/><circle cx="55" cy="8" r="7" fill="rgba(255,215,64,.4)"/><circle cx="55" cy="8" r="11" fill="rgba(255,215,64,.12)"/>
</svg>`,

  MAGIC_ATTACK: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="mga" cx="50%" cy="50%"><stop offset="0%" stop-color="#200808"/><stop offset="100%" stop-color="#060610"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#mga)"/>
  <circle cx="55" cy="38" r="24" fill="rgba(255,87,34,.08)" stroke="rgba(255,87,34,.35)" stroke-width="1"/>
  <circle cx="55" cy="38" r="14" fill="rgba(255,87,34,.12)" stroke="rgba(255,87,34,.5)" stroke-width="1.5"/>
  <text x="55" y="44" text-anchor="middle" font-size="18" fill="#ff5722">💥</text>
  <line x1="55" y1="15" x2="55" y2="22" stroke="#ff5722" stroke-width="2" opacity=".7"/>
  <line x1="55" y1="54" x2="55" y2="61" stroke="#ff5722" stroke-width="2" opacity=".7"/>
  <line x1="32" y1="38" x2="39" y2="38" stroke="#ff5722" stroke-width="2" opacity=".7"/>
  <line x1="78" y1="38" x2="71" y2="38" stroke="#ff5722" stroke-width="2" opacity=".7"/>
  <circle cx="55" cy="8" r="4" fill="#ff5722"/><circle cx="55" cy="8" r="7" fill="rgba(255,87,34,.45)"/><circle cx="55" cy="8" r="11" fill="rgba(255,87,34,.12)"/>
</svg>`,

  MAGIC_HEAL: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <defs><radialGradient id="mgh" cx="50%" cy="50%"><stop offset="0%" stop-color="#081a10"/><stop offset="100%" stop-color="#060610"/></radialGradient></defs>
  <rect width="110" height="72" fill="url(#mgh)"/>
  <circle cx="55" cy="38" r="20" fill="rgba(105,240,174,.08)" stroke="rgba(105,240,174,.3)" stroke-width="1.5"/>
  <rect x="51" y="26" width="8" height="24" rx="2" fill="rgba(105,240,174,.5)"/>
  <rect x="43" y="34" width="24" height="8" rx="2" fill="rgba(105,240,174,.5)"/>
  <text x="55" y="44" text-anchor="middle" font-size="14" fill="#69f0ae" opacity=".9">💊</text>
  <circle cx="36" cy="25" r="2.5" fill="rgba(105,240,174,.3)"/>
  <circle cx="74" cy="25" r="2.5" fill="rgba(105,240,174,.3)"/>
  <circle cx="36" cy="51" r="2.5" fill="rgba(105,240,174,.3)"/>
  <circle cx="74" cy="51" r="2.5" fill="rgba(105,240,174,.3)"/>
  <circle cx="55" cy="8" r="4" fill="#69f0ae"/><circle cx="55" cy="8" r="7" fill="rgba(105,240,174,.45)"/><circle cx="55" cy="8" r="11" fill="rgba(105,240,174,.12)"/>
</svg>`,

  _default: `<svg viewBox="0 0 110 72" xmlns="http://www.w3.org/2000/svg">
  <rect width="110" height="72" fill="#080810"/>
  <circle cx="55" cy="36" r="20" stroke="rgba(255,255,255,.3)" stroke-width="2" fill="none"/>
</svg>`,
};

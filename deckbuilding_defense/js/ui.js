'use strict';

let _tooltipHideTimer;

function toggleDeckView() {
  const panel = document.getElementById('deckviewPanel');
  if (!panel) return;
  const open = panel.classList.toggle('open');
  const chevron = document.getElementById('deckviewChevron');
  if (chevron) chevron.textContent = open ? '▲' : '▼';
  if (open) renderDeckViewer();
}

function renderDeckViewer() {
  const content = document.getElementById('deckviewContent');
  if (!content) return;

  const total = (G.deck||[]).length + (G.hand||[]).length + (G.discard||[]).length + (G.marinTokens||0) + (G.magicCards||[]).length + (G.trash||[]).length;
  const cnt = document.getElementById('deckviewTotalCount');
  if (cnt) cnt.textContent = total;

  // 전체 보유 카드 집계 (id별 카운트)
  const allOwned = [...(G.deck||[]), ...(G.hand||[]), ...(G.discard||[]), ...(G.magicCards||[]), ...(G.trash||[])];
  const countMap = {};
  allOwned.forEach(c => { countMap[c.id] = (countMap[c.id] || 0) + 1; });
  if (G.marinTokens > 0) countMap['MARINE_TOKEN'] = G.marinTokens;

  // 손패에서 현재 플레이 가능한 카드 (renderHand의 canPlay 로직과 동기화)
  const playableTypes = G.phase === 'BATTLE'
    ? ['effect', 'unit', 'unit_effect', 'combo', 'resource_effect']
    : ['resource', 'resource_effect', 'effect', 'combo', 'unit_effect'];
  const playableInHand = (G.hand||[]).filter(c => playableTypes.includes(c.type));

  const zones = [
    {
      label: '✋ 손패',
      cls: 'dv-zone-hand',
      cards: G.hand || [],
      highlight: c => playableTypes.includes(c.type),
    },
    {
      label: '✨ 마법',
      cls: 'dv-zone-magic',
      cards: G.magicCards || [],
      highlight: null,
    },
    {
      label: '🂠 덱',
      cls: 'dv-zone-deck',
      cards: G.deck || [],
      highlight: null,
    },
    {
      label: '🗑 버림',
      cls: 'dv-zone-discard',
      cards: G.discard || [],
      highlight: null,
    },
    {
      label: '🏚 지하실',
      cls: 'dv-zone-basement',
      cards: G.trash || [],
      highlight: null,
    },
  ];

  // 보유 카드 요약 (상단)
  const ownedEntries = Object.entries(countMap)
    .map(([id, cnt]) => {
      const tpl = CARD_DEF[id] || { id:'MARINE_TOKEN', name:'마린 토큰', emoji:'🔵', type:'unit' };
      return { ...tpl, _count: cnt };
    })
    .sort((a, b) => (TYPE_ORDER[a.type] ?? 5) - (TYPE_ORDER[b.type] ?? 5));

  content.innerHTML = '';

  // ── 전체 보유 섹션
  const ownedRow = document.createElement('div');
  ownedRow.className = 'dv-row';
  const ownedLbl = document.createElement('span');
  ownedLbl.className = 'dv-label dv-zone-owned';
  ownedLbl.textContent = `📋 보유 (${total}장)`;
  ownedRow.appendChild(ownedLbl);
  const ownedPills = document.createElement('div');
  ownedPills.className = 'dv-pills';
  if (ownedEntries.length === 0) {
    const e = document.createElement('span');
    e.className = 'dv-empty'; e.textContent = '없음';
    ownedPills.appendChild(e);
  } else {
    ownedEntries.forEach(card => {
      const pill = document.createElement('span');
      pill.className = `dv-pill dv-type-${card.type}`;
      pill.textContent = card._count > 1 ? `${card.emoji} ${card.name} ×${card._count}` : `${card.emoji} ${card.name}`;
      if (card.desc) pill.title = card.desc;
      ownedPills.appendChild(pill);
    });
  }
  ownedRow.appendChild(ownedPills);
  content.appendChild(ownedRow);

  // ── 존별 섹션
  zones.forEach(zone => {
    const row = document.createElement('div');
    row.className = 'dv-row';
    const lbl = document.createElement('span');
    lbl.className = `dv-label ${zone.cls}`;
    lbl.textContent = `${zone.label} (${zone.cards.length})`;
    row.appendChild(lbl);
    const pills = document.createElement('div');
    pills.className = 'dv-pills';
    if (zone.cards.length === 0) {
      const e = document.createElement('span');
      e.className = 'dv-empty'; e.textContent = '없음';
      pills.appendChild(e);
    } else {
      zone.cards.forEach(card => {
        const pill = document.createElement('span');
        const canPlay = zone.highlight && zone.highlight(card);
        pill.className = `dv-pill dv-type-${card.type}${canPlay ? ' dv-playable' : ''}`;
        pill.textContent = `${card.emoji} ${card.name}`;
        if (card.desc) pill.title = card.desc;
        pills.appendChild(pill);
      });
    }
    row.appendChild(pills);
    content.appendChild(row);
  });
}

function renderMagicCards() {
  const container = document.getElementById('magicCardsList');
  if (!container) return;
  container.innerHTML = '';

  const countEl = document.getElementById('magicCardCount');
  if (countEl) countEl.textContent = (G.magicCards || []).length;

  const emptyEl = document.getElementById('magicZoneEmpty');
  if (emptyEl) emptyEl.style.display = (G.magicCards || []).length === 0 ? '' : 'none';

  (G.magicCards || []).forEach(card => {
    const el = makeCardEl(card);
    const canUse = card.id !== 'MAGIC_ATTACK' || G.phase === 'BATTLE';
    el.classList.add(canUse ? 'playable' : 'inactive');
    el.title = card.id === 'MAGIC_ATTACK' && G.phase !== 'BATTLE' ? '전투 중에만 사용 가능' : card.desc;
    el.addEventListener('click', () => playMagicCard(card.uid));
    container.appendChild(el);
  });
}

function refreshUI() { renderHand(); renderShop(); updateStats(); renderDeckViewer(); renderMagicCards(); }

function renderHand() {
  const container = document.getElementById('handCards');
  container.innerHTML = '';

  G.hand.forEach((card, idx) => {
    const el = makeCardEl(card);
    const canPlay = G.phase === 'BATTLE'
      ? (card.type === 'effect' || card.type === 'unit' || card.type === 'unit_effect' || card.type === 'combo' || card.type === 'resource_effect')
      : (card.type === 'resource' || card.type === 'resource_effect' || card.type === 'effect' || card.type === 'combo' || card.type === 'unit_effect');

    el.classList.add(canPlay ? 'playable' : 'inactive');
    if (canPlay) el.addEventListener('click', () => playCard(card.uid));

    // 드로우 애니메이션 (새로 추가된 카드에만)
    if (card._new) {
      el.classList.add('card-draw');
      el.style.animationDelay = (idx * 0.045) + 's';
    }

    container.appendChild(el);
  });

  document.getElementById('handCount').textContent = G.hand.length;
}

function makeShopCard(cardId, sizeClass) {
  const tpl = CARD_DEF[cardId];
  const el = makeCardEl({ ...tpl, uid: -1 });
  el.classList.add('shop-card', sizeClass);

  const inShopPhase = G.phase === 'SHOP';
  const canAfford   = G.minerals >= tpl.cost && G.mana >= 1;
  const canBuy      = inShopPhase && canAfford;

  if (!canBuy) {
    el.classList.add('unaffordable');

    // 준비 단계에서만 부족 배지 표시
    if (inShopPhase) {
      const parts = [];
      if (G.minerals < tpl.cost) parts.push(`⬡${tpl.cost - G.minerals} 부족`);
      if (G.mana < 1)            parts.push('마나 부족');
      if (parts.length) {
        const badge = document.createElement('div');
        badge.className = 'shop-need-badge';
        badge.textContent = parts.join(' · ');
        el.appendChild(badge);
      }
    }
  }

  if (tpl.type === 'magic') {
    if ((G.magicCards || []).length >= 3) {
      el.classList.remove('unaffordable');
      el.classList.add('sold-out');
      const b = el.querySelector('.shop-need-badge');
      if (b) b.remove();
    }
  } else if (tpl.maxCount) {
    const owned = [...G.deck, ...G.hand, ...G.discard].filter(c => c.id === cardId).length;
    if (owned >= tpl.maxCount) {
      el.classList.remove('unaffordable');
      el.classList.add('sold-out');
      const b = el.querySelector('.shop-need-badge');
      if (b) b.remove();
    }
  }

  el.addEventListener('click', () => buyCard(cardId));

  // 소형 카드는 툴팁으로 상세 미리보기
  if (sizeClass === 'shop-card-basic') {
    el.addEventListener('mouseenter', () => showCardTooltip(tpl, el));
    el.addEventListener('mouseleave', hideCardTooltip);
  }

  return el;
}

function renderShop() {
  const container = document.getElementById('shopGrid');
  container.innerHTML = '';

  // ── 기본 카드 (고정) ──
  const basicLabel = document.createElement('div');
  basicLabel.className = 'shop-section-label';
  basicLabel.textContent = '기본 카드';
  container.appendChild(basicLabel);

  const basicGrid = document.createElement('div');
  basicGrid.className = 'shop-basic-grid';
  SHOP_FIXED.forEach(cardId => basicGrid.appendChild(makeShopCard(cardId, 'shop-card-basic')));
  container.appendChild(basicGrid);

  // ── 모드 카드 (랜덤) ──
  const modeLabel = document.createElement('div');
  modeLabel.className = 'shop-section-label';
  modeLabel.textContent = '모드 카드';
  container.appendChild(modeLabel);

  const modeGrid = document.createElement('div');
  modeGrid.className = 'shop-mode-grid';
  G.shopRandom.forEach(cardId => modeGrid.appendChild(makeShopCard(cardId, 'shop-card-mode')));
  container.appendChild(modeGrid);
}

// 카드별 캐릭터 일러스트 SVG (viewBox 110×72) — 고대비 버전

function showCardTooltip(tpl, triggerEl) {
  clearTimeout(_tooltipHideTimer);
  const el = document.getElementById('cardTooltip');
  el.innerHTML = '';
  const c = makeCardEl({ ...tpl, uid: -2 });
  c.style.pointerEvents = 'none';
  el.appendChild(c);

  const rect = triggerEl.getBoundingClientRect();
  const TW = 156, TH = 234;
  let x = rect.left - TW - 10;
  if (x < 6) x = rect.right + 10;
  let y = rect.top + rect.height / 2 - TH / 2;
  if (y + TH > window.innerHeight - 8) y = window.innerHeight - TH - 8;
  if (y < 6) y = 6;

  el.style.left = x + 'px';
  el.style.top  = y + 'px';
  el.classList.add('visible');
}

function hideCardTooltip() {
  _tooltipHideTimer = setTimeout(() => {
    const el = document.getElementById('cardTooltip');
    if (el) el.classList.remove('visible');
  }, 60);
}

function getCardStat(card) {
  if (card.type === 'unit')            return `⚔ ${card.power}`;
  if (card.type === 'unit_effect')     return card.draw ? `+${card.draw} 드로우` : '★ 효과';
  if (card.type === 'resource')        return `⬡ +${card.mineral}`;
  if (card.type === 'resource_effect') return card.mineral ? `⬡+${card.mineral}${card.bonusMana ? ` 마나+${card.bonusMana}` : ''}` : card.bonusMana ? `마나 +${card.bonusMana}` : '★ 자원/효과';
  if (card.type === 'trash')           return `× ${card.mineral}`;
  if (card.type === 'combo')           return `⬡+${card.mineral} ⚔${card.power}`;
  if (card.type === 'effect') {
    if (card.draw)        return `+${card.draw} 드로우`;
    if (card.bonusPower)  return `+${card.bonusPower} 공업`;
    if (card.mineral)     return `+${card.mineral} 미네랄`;
    if (card.marineToken) return `+${card.marineToken} 마린 토큰`;
    if (card.bonusMana)   return `+${card.bonusMana} 마나`;
    return '★ 효과';
  }
  if (card.type === 'magic') {
    if (card.draw)    return `+${card.draw} 드로우`;
    if (card.mineral) return `+${card.mineral} 미네랄`;
    if (card.power)   return `⚔ ${card.power} 전체`;
    return '💊 HP +5';
  }
  return '';
}

function makeCardEl(card) {
  const el = document.createElement('div');
  el.className = `card card-${card.type}`;
  el.dataset.uid = card.uid;

  const typeLabel = { resource:'자원', unit:'유닛', effect:'효과', trash:'잉여', combo:'자원/유닛', resource_effect:'자원/효과', unit_effect:'유닛/효과', magic:'마법' };
  const art  = CARD_ART[card.id] || CARD_ART._default;
  const stat = getCardStat(card);

  el.innerHTML = `
    <div class="card-art">${art}</div>
    <div class="card-info">
      <div class="card-top">
        <div class="card-name">${card.name}</div>
        <div class="card-cost">⬡${card.cost}</div>
      </div>
      <div class="card-badge">
        <span class="type-pill">${typeLabel[card.type] || card.type}</span>
        <span class="stat-num">${stat}</span>
      </div>
      <div class="card-desc">${card.desc}</div>
      <div class="card-flavor">${card.flavor}</div>
    </div>
  `;
  return el;
}

function updateStats() {
  document.getElementById('statRound').textContent    = `${G.round} / ${G.maxRounds}`;
  document.getElementById('statHp').textContent       = G.hp;
  document.getElementById('statMinerals').textContent = G.minerals;
  document.getElementById('statDeck').textContent     = G.deck.length;
  document.getElementById('statDiscard').textContent  = G.discard.length;
  document.getElementById('handCount').textContent    = G.hand.length;
  const tokenEl = document.getElementById('statMarinToken');
  if (tokenEl) tokenEl.textContent = G.marinTokens > 0 ? `🔵 토큰 ${G.marinTokens}` : '';

  // 탈출 바
  const pct = Math.min(G.totalEscaped / G.maxEscaped * 100, 100);
  const fill = document.getElementById('escapedBarFill');
  fill.style.width = pct + '%';
  fill.style.background = pct > 70 ? '#ff5252' : pct > 40 ? '#ffab40' : '#69f0ae';

  const escEl = document.getElementById('statEscaped');
  escEl.textContent = `${G.totalEscaped} / 50`;
  escEl.className = 'hud-stat-val escaped';
  if (G.totalEscaped > 35)      escEl.classList.add('danger');
  else if (G.totalEscaped > 20) escEl.classList.add('warning');

  // DPS / 남은 적 / 타이머 (전투 중에만 표시)
  const dpsWrap   = document.getElementById('statDpsWrap');
  const enemyWrap = document.getElementById('statEnemyWrap');
  const timerWrap = document.getElementById('statTimerWrap');
  const timerEl   = document.getElementById('statTimer');
  if (G.phase === 'BATTLE') {
    if (dpsWrap)   { dpsWrap.style.display = '';   document.getElementById('statDps').textContent = calcTotalUnitPower(); }
    if (enemyWrap) { enemyWrap.style.display = '';  document.getElementById('statEnemy').textContent = (G.enemies || []).filter(e => e.hp > 0).length; }
    if (timerWrap && timerEl) {
      timerWrap.style.display = '';
      const t = Math.ceil(G.battleTimer || 0);
      timerEl.textContent = t;
      timerEl.style.color = t <= 5 ? '#ff5252' : t <= 10 ? '#ffab40' : '#29b6f6';
    }
  } else {
    if (dpsWrap)   dpsWrap.style.display   = 'none';
    if (enemyWrap) enemyWrap.style.display = 'none';
    if (timerWrap) timerWrap.style.display = 'none';
  }

  // 마나 핍
  const pipsEl = document.getElementById('manaPips');
  pipsEl.innerHTML = '';
  const total = Math.max(G.maxMana, G.mana);
  for (let i = 0; i < total; i++) {
    const pip = document.createElement('div');
    pip.className = 'mana-pip' + (i >= G.mana ? ' empty' : '');
    pipsEl.appendChild(pip);
  }
}

// ═══════════════════════════════════════════════════════
//  라운드 요약
// ═══════════════════════════════════════════════════════

function showRoundSummary(onClose) {
  const overlay = document.getElementById('summaryOverlay');
  const cleared = G.roundSurvivors === 0;
  document.getElementById('sumRound').textContent = cleared
    ? `ROUND ${G.round} — 완전 클리어! ✓`
    : `ROUND ${G.round} 완료`;

  const dmg = G.roundHpDamage || 0;
  const totalCards = G.deck.length + G.hand.length + G.discard.length + (G.trash||[]).length + (G.magicCards||[]).length;
  const rows = [
    { k:'처치한 적군',  v:`${G.roundKills} 마리`,  cls: G.roundKills > 0 ? 'success' : '' },
    { k:'생존 적군',    v:`${G.roundSurvivors} 마리`, cls: G.roundSurvivors > 0 ? 'danger' : 'success' },
    { k:'기지 HP 피해', v: dmg > 0 ? `−${dmg}  (남은 HP: ${G.hp})` : '없음', cls: dmg > 0 ? 'danger' : 'success' },
    { k:'누적 탈출',    v:`${G.totalEscaped} / 50`, cls: G.totalEscaped > 35 ? 'danger' : G.totalEscaped > 20 ? '' : 'success' },
    { k:'보유 카드',    v:`${totalCards} 장`, cls: '' },
  ];

  document.getElementById('sumRows').innerHTML = rows
    .map(r => `<div class="summary-row ${r.cls}"><span>${r.k}</span><span>${r.v}</span></div>`)
    .join('');

  const danger = G.totalEscaped > G.maxEscaped;
  document.getElementById('sumNext').textContent = danger
    ? '⚠ 기지 함락!'
    : G.round < G.maxRounds ? `다음 라운드: Round ${G.round + 1}` : '최종 클리어!';

  overlay.classList.remove('hidden');

  let closed = false;
  const close = () => {
    if (closed) return;
    closed = true;
    clearTimeout(autoTimer);
    overlay.classList.add('hidden');
    overlay.removeEventListener('click', close);
    onClose();
  };
  overlay.addEventListener('click', close);
  const autoTimer = setTimeout(close, danger ? 1000 : 2500);
}

// ═══════════════════════════════════════════════════════
//  유틸 UI
// ═══════════════════════════════════════════════════════

function generateShop() {
  return [...SHOP_RANDOM_POOL].sort(() => Math.random() - .5).slice(0, 6);
}

function spawnTextFx(text, color, center = false) {
  const el = document.createElement('div');
  el.textContent = text;
  // center=true: 화면 중앙에 크게. 아니면 캔버스 주변에 랜덤 분산
  const leftPct = center ? 50 : 38 + Math.random() * 24;
  const topPct  = center ? 46 : 48 + Math.random() * 18;
  const sz      = center ? 28 : 20 + Math.random() * 6;
  el.style.cssText = `
    position:fixed; left:${leftPct}%; top:${topPct}%;
    transform:translateX(-50%);
    font-size:${sz}px; font-weight:900;
    color:${color}; pointer-events:none; z-index:50;
    text-shadow:0 0 14px ${color};
    animation: fxFloat ${center ? 1.1 : .85}s ease forwards;
  `;
  document.body.appendChild(el);
  setTimeout(() => el.remove(), center ? 1200 : 900);
}

if (!document.getElementById('fxStyle')) {
  const s = document.createElement('style');
  s.id = 'fxStyle';
  s.textContent = `@keyframes fxFloat {
    from { opacity:1; transform:translateX(-50%) translateY(0) scale(1); }
    to   { opacity:0; transform:translateX(-50%) translateY(-50px) scale(.7); }
  }`;
  document.head.appendChild(s);
}

let toastTimer;
function showToast(msg) {
  const t = document.getElementById('toast');
  t.textContent = msg;
  t.classList.add('show');
  clearTimeout(toastTimer);
  toastTimer = setTimeout(() => t.classList.remove('show'), 2000);
}

function showGameOver(msg) {
  G.phase = 'GAME_OVER';
  if (G.animFrame) { cancelAnimationFrame(G.animFrame); G.animFrame = null; }
  document.getElementById('gameOverMsg').textContent = msg;

  const statsEl = document.getElementById('gameOverStats');
  if (statsEl) {
    const rows = [
      { k:'클리어 라운드', v:`${G.round} / ${G.maxRounds}`, cls: G.round >= 20 ? 'ms-good' : G.round <= 5 ? 'ms-danger' : '' },
      { k:'총 처치',       v:`${G.totalKills} 마리`,        cls: G.totalKills >= 50 ? 'ms-good' : '' },
      { k:'누적 탈출',     v:`${G.totalEscaped} / ${G.maxEscaped}`, cls: G.totalEscaped >= G.maxEscaped ? 'ms-danger' : '' },
      { k:'남은 기지 HP',  v:`${G.hp}`,                     cls: G.hp <= 5 ? 'ms-danger' : 'ms-good' },
    ];
    statsEl.innerHTML = rows.map(r =>
      `<div class="modal-stats-row ${r.cls}"><span>${r.k}</span><span class="ms-val">${r.v}</span></div>`
    ).join('');
  }

  document.getElementById('gameOverModal').classList.remove('hidden');
}

function showVictory() {
  G.phase = 'VICTORY';
  if (G.animFrame) { cancelAnimationFrame(G.animFrame); G.animFrame = null; }

  const statsEl = document.getElementById('victoryStats');
  if (statsEl) {
    const rows = [
      { k:'총 처치',   v:`${G.totalKills} 마리`,               cls: G.totalKills >= 100 ? 'ms-good' : '' },
      { k:'누적 탈출', v:`${G.totalEscaped} / ${G.maxEscaped}`, cls: G.totalEscaped >= G.maxEscaped * 0.5 ? 'ms-danger' : 'ms-good' },
      { k:'남은 HP',   v:`${G.hp}`,                             cls: G.hp >= 15 ? 'ms-good' : G.hp <= 5 ? 'ms-danger' : '' },
    ];
    statsEl.innerHTML = rows.map(r =>
      `<div class="modal-stats-row ${r.cls}"><span>${r.k}</span><span class="ms-val">${r.v}</span></div>`
    ).join('');
  }

  document.getElementById('victoryModal').classList.remove('hidden');
}

// ═══════════════════════════════════════════════════════
//  이벤트
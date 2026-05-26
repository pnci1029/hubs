'use strict';

let G = {};
let uidSeq = 0;
let shopAnimFrame = null;
let gameSpeed = 1;

function cycleSpeed() {
  gameSpeed = gameSpeed === 1 ? 2 : gameSpeed === 2 ? 3 : 1;
  const btn = document.getElementById('btnSpeed');
  btn.textContent = gameSpeed + '×';
  btn.className = 'btn-speed' + (gameSpeed === 2 ? ' speed-fast' : gameSpeed === 3 ? ' speed-turbo' : '');
}

function initGame() {
  if (G.animFrame) cancelAnimationFrame(G.animFrame);
  if (shopAnimFrame) { cancelAnimationFrame(shopAnimFrame); shopAnimFrame = null; }

  G = {
    phase: 'SHOP',
    round: 0,
    maxRounds: 30,
    hp: 20,
    mana: 2, maxMana: 2,
    minerals: 0,
    totalEscaped: 0, maxEscaped: 50,
    bonusPower: 0,
    marinTokens: 0,
    deck: [], hand: [], discard: [], magicCards: [], trash: [],
    shopRandom: [],
    enemies: [],
    fieldUnits: [],
    atkBeams: [],
    effects: [],
    dmgNums: [],
    particles: [],
    shake: 0,
    battleFlash: 0,
    lastKillTime: 0, comboCount: 0,
    waveClearedFx: false,
    reshuffledThisRound: false,
    starField: [],
    battleTimer: 0, battleMaxTime: 30,
    animFrame: null, lastTime: 0,
    roundKills: 0, roundSurvivors: 0,
    totalKills: 0,
  };

  STARTING_DECK.forEach(id => G.deck.push(makeCard(id)));
  shuffle(G.deck);

  const cv = document.getElementById('battleCanvas');
  for (let i = 0; i < 100; i++) {
    G.starField.push({
      x: Math.random() * cv.width,
      y: Math.random() * cv.height,
      r: Math.random() * 1.5 + .3,
      a: Math.random() * .7 + .2,
      twinkle: Math.random() * Math.PI * 2,
    });
  }

  document.getElementById('gameOverModal').classList.add('hidden');
  document.getElementById('victoryModal').classList.add('hidden');
  document.getElementById('summaryOverlay').classList.add('hidden');

  startShopPhase();
}

// ═══════════════════════════════════════════════════════
//  유틸
// ═══════════════════════════════════════════════════════

function makeCard(id) { return { ...CARD_DEF[id], uid: ++uidSeq }; }

// ─── 화면 흔들림 ───
function addShake(trauma) { G.shake = Math.min(1, (G.shake || 0) + trauma); }

// ─── 파티클 ───
function addParticles(x, y, color, count, speedMult = 1) {
  for (let i = 0; i < count; i++) {
    const angle = (i / count) * Math.PI * 2 + Math.random() * .9;
    const spd   = (55 + Math.random() * 95) * speedMult;
    G.particles.push({
      x, y, vx: Math.cos(angle) * spd, vy: Math.sin(angle) * spd,
      alpha: 1, r: 1.5 + Math.random() * 2.5,
      color, decay: 1.6 + Math.random(),
    });
  }
}

// ─── Web Audio 합성 사운드 ───
let _audio;
function _ac() { return _audio || (_audio = new AudioContext()); }
let _lastHitSnd = 0;

function playSound(type) {
  try {
    const ac = _ac();
    if (ac.state === 'suspended') ac.resume();
    const o = ac.createOscillator(), g = ac.createGain();
    o.connect(g); g.connect(ac.destination);
    const t = ac.currentTime;
    switch (type) {
      case 'hit':
        o.type = 'square'; o.frequency.value = 200;
        g.gain.setValueAtTime(.05, t); g.gain.exponentialRampToValueAtTime(.001, t + .07);
        o.start(t); o.stop(t + .07); break;
      case 'death':
        o.type = 'sawtooth'; o.frequency.setValueAtTime(260, t);
        o.frequency.exponentialRampToValueAtTime(40, t + .22);
        g.gain.setValueAtTime(.1, t); g.gain.exponentialRampToValueAtTime(.001, t + .22);
        o.start(t); o.stop(t + .22); break;
      case 'boss_death':
        o.type = 'sawtooth'; o.frequency.setValueAtTime(380, t);
        o.frequency.exponentialRampToValueAtTime(25, t + .5);
        g.gain.setValueAtTime(.18, t); g.gain.exponentialRampToValueAtTime(.001, t + .5);
        o.start(t); o.stop(t + .5); break;
      case 'buy':
        o.type = 'sine'; o.frequency.setValueAtTime(440, t); o.frequency.setValueAtTime(660, t + .06);
        g.gain.setValueAtTime(.09, t); g.gain.exponentialRampToValueAtTime(.001, t + .18);
        o.start(t); o.stop(t + .18); break;
      case 'card':
        o.type = 'triangle'; o.frequency.value = 700;
        g.gain.setValueAtTime(.06, t); g.gain.exponentialRampToValueAtTime(.001, t + .09);
        o.start(t); o.stop(t + .09); break;
      case 'base_hit':
        o.type = 'sawtooth'; o.frequency.setValueAtTime(90, t);
        o.frequency.exponentialRampToValueAtTime(55, t + .3);
        g.gain.setValueAtTime(.18, t); g.gain.exponentialRampToValueAtTime(.001, t + .3);
        o.start(t); o.stop(t + .3); break;
    }
  } catch(e) {}
}

function shuffle(arr) {
  for (let i = arr.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [arr[i], arr[j]] = [arr[j], arr[i]];
  }
}

function drawCards(n) {
  for (let i = 0; i < n; i++) {
    if (G.deck.length === 0) {
      // 라운드당 리셀은 최대 1회
      if (G.discard.length === 0 || G.reshuffledThisRound) break;
      G.deck = G.discard.splice(0);
      shuffle(G.deck);
      G.reshuffledThisRound = true;
    }
    const c = G.deck.pop();
    c._new = true;
    G.hand.push(c);
  }
}

// ═══════════════════════════════════════════════════════
//  페이즈
// ═══════════════════════════════════════════════════════

function startShopPhase() {
  G.phase = 'SHOP';
  // 마나 최대치 마일스톤: 라운드 10→3, 20→4, 25→5
  const newMax = G.round >= 25 ? 5 : G.round >= 20 ? 4 : G.round >= 10 ? 3 : 2;
  if (newMax > G.maxMana) {
    G.maxMana = newMax;
    spawnTextFx(`★ 최대 마나 +1 → ${G.maxMana}`, '#29b6f6');
  }
  G.mana = G.maxMana;
  G.minerals = 0;
  G.bonusPower = 0;

  // 덱 순환: 손패 → 버림더미. 덱 남은 거 먼저 뽑고, 모자라면 그때 1회 리셀
  G.discard.push(...G.hand);
  G.hand = [];
  G.reshuffledThisRound = false;
  drawCards(5);

  G.shopRandom = generateShop();

  // 다음 웨이브 미리보기 (적 종류, 수, 총 HP)
  const nextWave = getWave(G.round + 1);
  const waveCount = {};
  nextWave.forEach(t => waveCount[t] = (waveCount[t] || 0) + 1);
  const hpMult = 1 + G.round * 0.06;
  const ENEMY_SHORT = { ZERGLING:'저글링', HYDRALISK:'히드라', ULTRALISK:'울트라', BOSS:'★보스' };
  const totalHp = nextWave.reduce((s, t) => s + Math.floor((ENEMY_DEF[t]?.maxHp || 0) * hpMult), 0);
  const preview = Object.entries(waveCount)
    .map(([t, c]) => `${ENEMY_SHORT[t] || t} ×${c}`)
    .join('  ');
  document.getElementById('wavePreview').textContent = `다음 웨이브: ${preview}  (총 HP ${totalHp})`;

  document.getElementById('phaseLabel').textContent = `준비 단계 — Round ${G.round + 1}`;
  document.getElementById('btnStart').classList.remove('hidden');
  document.getElementById('btnEnd').classList.add('hidden');
  document.getElementById('handHint').textContent = '자원/효과';
  document.getElementById('btnResources').textContent = '⬡ 자원 전부 사용';
  document.getElementById('btnRefreshShop').style.display = '';
  document.querySelector('.shop-panel').classList.remove('shop-locked');

  // 필드 유닛 미리보기 갱신
  const cv = document.getElementById('battleCanvas');
  G.fieldUnits = buildFieldUnits(cv.width / 2, cv.height / 2);

  refreshUI();
  renderDeckViewer();
  startShopIdle();
}

function startShopIdle() {
  if (shopAnimFrame) cancelAnimationFrame(shopAnimFrame);
  let lastT = performance.now();
  function loop(now) {
    if (G.phase !== 'SHOP') { shopAnimFrame = null; return; }
    const dt = Math.min((now - lastT) / 1000, .1);
    lastT = now;
    G.starField.forEach(s => { s.twinkle += dt * 1.2; });
    renderCanvas();
    shopAnimFrame = requestAnimationFrame(loop);
  }
  shopAnimFrame = requestAnimationFrame(loop);
}

function startBattlePhase() {
  if (G.round >= G.maxRounds) { showVictory(); return; }
  if (shopAnimFrame) { cancelAnimationFrame(shopAnimFrame); shopAnimFrame = null; }

  G.round++;
  G.phase = 'BATTLE';
  G.battleTimer = G.battleMaxTime;
  G.effects = [];
  G.dmgNums = [];
  G.roundKills = 0;
  G.comboCount = 0;
  G.waveClearedFx = false;
  G.enemies = spawnEnemies(G.round);

  const hasBoss = G.enemies.some(e => e.isBoss);
  G.battleFlash = hasBoss ? 0.7 : 0.4;
  if (hasBoss) { addShake(0.35); playSound('boss_death'); }

  const cv = document.getElementById('battleCanvas');
  G.fieldUnits = buildFieldUnits(cv.width / 2, cv.height / 2);
  G.atkBeams = [];

  document.getElementById('phaseLabel').textContent = `전투 중 — Round ${G.round} / ${G.maxRounds}`;
  document.getElementById('wavePreview').textContent = '';
  document.getElementById('btnStart').classList.add('hidden');
  document.getElementById('btnEnd').classList.remove('hidden');
  document.getElementById('handHint').textContent = '효과 카드 플레이 · 유닛은 자동 공격 중';
  document.getElementById('btnResources').textContent = '★ 효과 카드 전부 사용';
  document.getElementById('btnRefreshShop').style.display = 'none';
  document.querySelector('.shop-panel').classList.add('shop-locked');

  updateStats();
  renderHand();
  renderShop();
  renderMagicCards();

  G.lastTime = performance.now();
  if (G.animFrame) cancelAnimationFrame(G.animFrame);
  G.animFrame = requestAnimationFrame(battleLoop);
}

function endRound() {
  if (G.phase !== 'BATTLE') return;
  cancelAnimationFrame(G.animFrame);
  G.animFrame = null;
  G.phase = 'ROUND_END';

  const survivors = G.enemies.filter(e => e.hp > 0);
  G.roundSurvivors = survivors.length;
  G.totalEscaped  += G.roundSurvivors;

  // 생존 적군이 기지 HP를 공격 (보스는 3 피해, 일반은 1 피해)
  G.roundHpDamage = survivors.reduce((sum, e) => sum + (e.isBoss ? 3 : 1), 0);
  G.hp = Math.max(0, G.hp - G.roundHpDamage);

  if (G.roundHpDamage > 0) {
    addShake(Math.min(0.85, G.roundHpDamage * 0.2));
    playSound('base_hit');
    const hpEl = document.getElementById('statHp');
    hpEl.classList.remove('flash');
    void hpEl.offsetWidth;
    hpEl.classList.add('flash');
    setTimeout(() => hpEl.classList.remove('flash'), 700);
  }

  updateStats();
  renderCanvas();

  // 라운드 요약 팝업
  showRoundSummary(() => {
    if (G.hp <= 0) {
      showGameOver(`기지 HP가 0이 되었습니다 — 기지가 함락되었습니다!`);
      return;
    }
    if (G.totalEscaped > G.maxEscaped) {
      showGameOver(`누적 생존 적군 ${G.totalEscaped}마리 — 기지가 함락되었습니다!`);
      return;
    }
    if (G.round >= G.maxRounds) { showVictory(); return; }
    startShopPhase();
  });
}

// ═══════════════════════════════════════════════════════
//  카드 조작
// ═══════════════════════════════════════════════════════

function playCard(uid) {
  const idx = G.hand.findIndex(c => c.uid === uid);
  if (idx < 0) return;

  const card = G.hand.splice(idx, 1)[0];
  playSound('card');

  // 카드 플레이 — 고스트 클론 애니메이션
  const cardEl = document.querySelector(`[data-uid="${uid}"]`);
  if (cardEl) {
    const rect = cardEl.getBoundingClientRect();
    const ghost = cardEl.cloneNode(true);
    ghost.style.cssText = `
      position:fixed;left:${rect.left}px;top:${rect.top}px;
      width:${rect.width}px;height:${rect.height}px;
      margin:0;pointer-events:none;z-index:500;
    `;
    ghost.classList.add('playing');
    document.body.appendChild(ghost);
    setTimeout(() => ghost.remove(), 340);
    cardEl.remove();
  }

  if (card.type === 'resource') {
    G.minerals = Math.max(0, G.minerals + card.mineral);
    spawnTextFx(`+${card.mineral} ⬡`, '#ffd740');
  } else if (card.type === 'resource_effect') {
    if (card.mineral)   { G.minerals = Math.max(0, G.minerals + card.mineral); spawnTextFx(`+${card.mineral} ⬡`, '#ffd740'); }
    if (card.draw)      { drawCards(card.draw); }
    if (card.bonusMana) { G.mana = Math.min(G.maxMana + 4, G.mana + card.bonusMana); spawnTextFx(`+${card.bonusMana} 마나`, '#29b6f6'); }
    if (card.bonusPower){ G.bonusPower += card.bonusPower; spawnTextFx(`+${card.bonusPower} 공업`, '#ffca28'); }
  } else if (card.type === 'combo') {
    // 자원+유닛 겸용 (네오살인로봇 등)
    if (card.mineral) { G.minerals = Math.max(0, G.minerals + card.mineral); spawnTextFx(`+${card.mineral} ⬡`, '#ffd740'); }
    if (card.power)   { const p = card.power + G.bonusPower; applyDamage(p); spawnTextFx(`⚔ ${p}`, '#ef5350'); }
  } else if (card.type === 'unit' || card.type === 'unit_effect') {
    if (card.special === 'impostor') {
      if (card.draw) drawCards(card.draw);
      G.bonusPower += 1;
      spawnTextFx('+1 공업', '#ffca28');
    } else if (card.special === 'kingcrab') {
      const unitCount = [...G.deck, ...G.hand, ...G.discard].filter(c => c.type === 'unit' || c.type === 'unit_effect' || c.type === 'combo').length;
      G.bonusPower += unitCount;
      spawnTextFx(`+${unitCount} 공업`, '#ffca28');
    } else {
      if (card.draw)      { drawCards(card.draw); }
      if (card.bonusMana) { G.mana = Math.min(G.maxMana + 4, G.mana + card.bonusMana); spawnTextFx(`+${card.bonusMana} 마나`, '#29b6f6'); }
    }
  } else if (card.type === 'effect') {
    if (card.special === 'sniper') {
      // 가장 싼 카드를 자동 파괴 → 그 가격만큼 드로우
      const allCards = [...G.deck, ...G.discard, ...G.hand].filter(c => c.uid !== card.uid);
      const cheapest = allCards.sort((a, b) => a.cost - b.cost)[0];
      if (cheapest) {
        const drawCount = Math.max(1, cheapest.cost);
        G.deck    = G.deck.filter(c => c.uid !== cheapest.uid);
        G.discard = G.discard.filter(c => c.uid !== cheapest.uid);
        G.hand    = G.hand.filter(c => c.uid !== cheapest.uid);
        G.trash.push(cheapest);
        drawCards(drawCount);
        spawnTextFx(`💀 +${drawCount} 카드`, '#ab47bc');
      } else { spawnTextFx('파괴할 카드 없음', '#546e7a'); }

    } else if (card.special === 'invisible_man') {
      // 가장 싼 카드 파괴 → +3 미네랄
      const allC = [...G.deck, ...G.discard, ...G.hand].filter(c => c.uid !== card.uid);
      const cheapest = allC.sort((a, b) => a.cost - b.cost)[0];
      if (cheapest) {
        G.deck = G.deck.filter(c => c.uid !== cheapest.uid);
        G.discard = G.discard.filter(c => c.uid !== cheapest.uid);
        G.hand = G.hand.filter(c => c.uid !== cheapest.uid);
        G.trash.push(cheapest);
        G.minerals += 3;
        spawnTextFx(`💀 +3 ⬡`, '#ffd740');
      } else { spawnTextFx('파괴할 카드 없음', '#546e7a'); }

    } else if (card.special === 'shuttle') {
      // +3 드로우 후 3장 자동 포기 (가장 싼 것부터)
      drawCards(3);
      const sorted = [...G.hand].sort((a, b) => a.cost - b.cost);
      const toDiscard = sorted.slice(0, Math.min(3, sorted.length));
      toDiscard.forEach(c => {
        G.hand = G.hand.filter(h => h.uid !== c.uid);
        G.discard.push(c);
      });
      spawnTextFx(`+3 드로우 · ${toDiscard.length}장 포기`, '#ab47bc');

    } else if (card.special === 'chlorella') {
      // 버림더미에서 4원 이하 카드 → 덱 위로
      const targets = G.discard.filter(c => c.cost <= 4).sort((a, b) => b.cost - a.cost);
      const picked = targets[0];
      if (picked) {
        G.discard = G.discard.filter(c => c.uid !== picked.uid);
        G.deck.push(picked);
        spawnTextFx(`↑ ${picked.name} 덱 위로`, '#80cbc4');
      } else { spawnTextFx('해당 카드 없음', '#546e7a'); }

    } else if (card.special === 'drone_vending') {
      // +1 마나, 가장 싼 카드 2장 파괴, 드론 획득
      G.mana = Math.min(G.maxMana + 4, G.mana + 1);
      spawnTextFx('+1 마나', '#29b6f6');
      let allC = [...G.deck, ...G.discard, ...G.hand].filter(c => c.uid !== card.uid).sort((a, b) => a.cost - b.cost);
      const toTrash = allC.slice(0, 2);
      toTrash.forEach(c => {
        G.deck = G.deck.filter(x => x.uid !== c.uid);
        G.discard = G.discard.filter(x => x.uid !== c.uid);
        G.hand = G.hand.filter(x => x.uid !== c.uid);
        G.trash.push(c);
      });
      G.discard.push(makeCard('DRONE'));
      spawnTextFx(`💀 ${toTrash.length}장 파괴 · 드론 획득`, '#ab47bc');

    } else if (card.special === 'upgrade_mill') {
      // 가장 싼 자원카드 파괴 → 상위 자원카드 획득
      const resCards = [...G.deck, ...G.discard, ...G.hand].filter(c => c.uid !== card.uid && c.type === 'resource').sort((a, b) => a.cost - b.cost);
      const res = resCards[0];
      if (res) {
        G.deck = G.deck.filter(c => c.uid !== res.uid);
        G.discard = G.discard.filter(c => c.uid !== res.uid);
        G.hand = G.hand.filter(c => c.uid !== res.uid);
        G.trash.push(res);
        const upgrades = { SCV:'DRONE', DRONE:'PROBE', PROBE:'LUCKCAT' };
        const nextId = upgrades[res.id];
        if (nextId) { G.discard.push(makeCard(nextId)); spawnTextFx(`↑ ${CARD_DEF[nextId].name} 획득`, '#ffd740'); }
        else { G.minerals += 3; spawnTextFx('최상위 자원 파괴 → +3 ⬡', '#ffd740'); }
      } else { spawnTextFx('자원카드 없음', '#546e7a'); }

    } else if (card.special === 'turret') {
      // +1 마나, 손패에 효과카드 없으면 +2 드로우
      G.mana = Math.min(G.maxMana + 4, G.mana + 1);
      spawnTextFx('+1 마나', '#29b6f6');
      const hasEffect = G.hand.some(c => c.type === 'effect' || c.type === 'resource_effect');
      if (!hasEffect) { drawCards(2); spawnTextFx('+2 드로우', '#ab47bc'); }

    } else if (card.special === 'windmaster') {
      // 손패 중 가장 비싼 효과카드의 기본 효과를 1회 추가 발동
      const effCards = G.hand.filter(c => (c.type === 'effect' || c.type === 'resource_effect') && !c.special).sort((a, b) => b.cost - a.cost);
      const target = effCards[0];
      if (target) {
        if (target.mineral)    { G.minerals = Math.max(0, G.minerals + target.mineral); spawnTextFx(`+${target.mineral} ⬡ (장풍)`, '#ffd740'); }
        if (target.draw)       { drawCards(target.draw); }
        if (target.bonusMana)  { G.mana = Math.min(G.maxMana + 4, G.mana + target.bonusMana); spawnTextFx(`+${target.bonusMana} 마나 (장풍)`, '#29b6f6'); }
        if (target.bonusPower) { G.bonusPower += target.bonusPower; spawnTextFx(`+${target.bonusPower} 공업 (장풍)`, '#ffca28'); }
        if (target.marineToken){ G.marinTokens += target.marineToken; spawnTextFx(`+${target.marineToken} 토큰 (장풍)`, '#29b6f6'); }
        if (!target.mineral && !target.draw && !target.bonusMana && !target.bonusPower && !target.marineToken) spawnTextFx('효과 없음', '#546e7a');
      } else { spawnTextFx('대상 효과카드 없음', '#546e7a'); }

    } else if (card.special === 'cowshed') {
      // +4 드로우, 2장 포기, 손패 효과카드당 마린 토큰
      drawCards(4);
      const sorted = [...G.hand].sort((a, b) => a.cost - b.cost);
      const toDiscard = sorted.slice(0, Math.min(2, sorted.length));
      toDiscard.forEach(c => { G.hand = G.hand.filter(h => h.uid !== c.uid); G.discard.push(c); });
      const effCount = G.hand.filter(c => c.type === 'effect' || c.type === 'resource_effect').length;
      if (effCount > 0) { G.marinTokens += effCount; spawnTextFx(`+${effCount} 마린 토큰`, '#29b6f6'); }
      spawnTextFx(`+4 드로우 · ${toDiscard.length}장 포기`, '#ab47bc');

    } else if (card.special === 'chomp') {
      const target = [...G.hand].sort((a, b) => a.cost - b.cost)[0];
      if (target) {
        G.hand    = G.hand.filter(c => c.uid !== target.uid);
        G.deck    = G.deck.filter(c => c.uid !== target.uid);
        G.discard = G.discard.filter(c => c.uid !== target.uid);
        G.trash.push(target);
        G.mana = Math.min(G.maxMana + 4, G.mana + 2);
        spawnTextFx('💀 파괴 +2 마나', '#29b6f6');
      } else { spawnTextFx('손패 없음', '#546e7a'); }

    } else if (card.special === 'cram_school') {
      // 최저가 카드 파괴 → +2원짜리 카드 획득
      const allC = [...G.deck, ...G.discard, ...G.hand].filter(c => c.uid !== card.uid).sort((a, b) => a.cost - b.cost);
      const cheapest = allC[0];
      if (cheapest) {
        G.deck = G.deck.filter(c => c.uid !== cheapest.uid);
        G.discard = G.discard.filter(c => c.uid !== cheapest.uid);
        G.hand = G.hand.filter(c => c.uid !== cheapest.uid);
        G.trash.push(cheapest);
        const targetCost = cheapest.cost + 2;
        const candidates = Object.values(CARD_DEF).filter(tpl => tpl.cost === targetCost && tpl.id !== 'SLACKER');
        if (candidates.length > 0) {
          const gained = candidates[Math.floor(Math.random() * candidates.length)];
          G.hand.push(makeCard(gained.id));
          spawnTextFx(`💀 → ${gained.name} 획득`, '#ab47bc');
        } else { G.minerals += cheapest.cost; spawnTextFx(`💀 → +${cheapest.cost} ⬡`, '#ffd740'); }
      } else { spawnTextFx('파괴할 카드 없음', '#546e7a'); }

    } else if (card.special === 'lanlanlou') {
      // 손패 5원 이하 효과카드 전부 발동 (소모 없음)
      const targets = G.hand.filter(c => (c.type === 'effect' || c.type === 'resource_effect') && c.cost <= 5 && !c.special);
      if (targets.length === 0) { spawnTextFx('발동할 카드 없음', '#546e7a'); }
      else {
        targets.forEach(t => {
          if (t.mineral)    { G.minerals = Math.max(0, G.minerals + t.mineral); }
          if (t.draw)       { drawCards(t.draw); }
          if (t.bonusMana)  { G.mana = Math.min(G.maxMana + 4, G.mana + t.bonusMana); }
          if (t.bonusPower) { G.bonusPower += t.bonusPower; }
          if (t.marineToken){ G.marinTokens += t.marineToken; }
        });
        spawnTextFx(`란란루! ${targets.length}장 발동`, '#ab47bc');
      }

    } else if (card.special === 'magic_shopping') {
      // 최저가 카드 파괴: 5원 이하면 무료 획득, 6원 이상이면 공업
      const allC = [...G.deck, ...G.discard, ...G.hand].filter(c => c.uid !== card.uid).sort((a, b) => a.cost - b.cost);
      const cheapest = allC[0];
      if (cheapest) {
        G.deck = G.deck.filter(c => c.uid !== cheapest.uid);
        G.discard = G.discard.filter(c => c.uid !== cheapest.uid);
        G.hand = G.hand.filter(c => c.uid !== cheapest.uid);
        G.trash.push(cheapest);
        if (cheapest.cost <= 5) {
          G.hand.push(makeCard(cheapest.id));
          spawnTextFx(`💀 → ${cheapest.name} 무료 획득!`, '#ffd740');
        } else {
          G.bonusPower += 1;
          spawnTextFx('💀 → +1 공업', '#ffca28');
        }
      } else { spawnTextFx('파괴할 카드 없음', '#546e7a'); }

    } else if (card.special === 'randombox') {
      // 최저가 카드 파괴 → 무작위 카드 획득
      const allC = [...G.deck, ...G.discard, ...G.hand].filter(c => c.uid !== card.uid).sort((a, b) => a.cost - b.cost);
      const cheapest = allC[0];
      if (cheapest) {
        G.deck = G.deck.filter(c => c.uid !== cheapest.uid);
        G.discard = G.discard.filter(c => c.uid !== cheapest.uid);
        G.hand = G.hand.filter(c => c.uid !== cheapest.uid);
        G.trash.push(cheapest);
        const pool = [...SHOP_RANDOM_POOL];
        const randId = pool[Math.floor(Math.random() * pool.length)];
        G.hand.push(makeCard(randId));
        spawnTextFx(`🎁 ${CARD_DEF[randId].name} 획득!`, '#ab47bc');
      } else { spawnTextFx('파괴할 카드 없음', '#546e7a'); }

    } else {
      if (card.mineral)    { G.minerals = Math.max(0, G.minerals + card.mineral); spawnTextFx(`+${card.mineral} ⬡`, '#ffd740'); }
      if (card.draw)       { drawCards(card.draw); }
      if (card.bonusMana)  { G.mana = Math.min(G.maxMana + 4, G.mana + card.bonusMana); spawnTextFx(`+${card.bonusMana} 마나`, '#29b6f6'); }
      if (card.bonusPower) { G.bonusPower += card.bonusPower; spawnTextFx(`+${card.bonusPower} 공업`, '#ffca28'); }
      if (card.marineToken){ G.marinTokens += card.marineToken; spawnTextFx(`+${card.marineToken} 마린 토큰`, '#29b6f6'); }
      if (!card.mineral && !card.bonusPower && !card.marineToken && !card.draw && !card.bonusMana) spawnTextFx('효과 발동', '#ab47bc');
    }
  } else if (card.type === 'trash') {
    G.minerals = Math.max(0, G.minerals + card.mineral);
    spawnTextFx(`${card.mineral} ⬡`, '#546e7a');
  }

  delete card._new;
  G.discard.push(card);
  if (!card._silent) {
    renderHand();
    renderShop();
    updateStats();
  }
}

function playAllResources() {
  const types = G.phase === 'BATTLE'
    ? ['effect', 'resource_effect']
    : ['resource', 'resource_effect', 'effect', 'combo', 'unit_effect'];
  const playable = G.hand.filter(c => types.includes(c.type));
  if (playable.length === 0) {
    showToast(G.phase === 'BATTLE' ? '사용할 효과 카드가 없습니다' : '사용할 자원/효과 카드가 없습니다');
    return;
  }
  // silent 플래그로 카드별 재렌더 방지 → 마지막에 한 번만
  playable.forEach(c => { c._silent = true; playCard(c.uid); delete c._silent; });
  renderHand();
  renderShop();
  updateStats();
}

function applyDamage(power) {
  let rem = power;
  const alive = G.enemies.filter(e => e.hp > 0).sort((a, b) => a.hp - b.hp);

  for (const e of alive) {
    if (rem <= 0) break;
    const hit = Math.min(rem, e.hp);
    rem -= hit;
    e.hp -= hit;
    e.hurtTimer = .4;

    // 데미지 숫자
    G.dmgNums.push({ x: e.x, y: e.y - 14 * e.scale, val: hit, alpha: 1, vy: -40, color: hit >= 5 ? '#ff5252' : '#ffffff' });
    addFx({ type:'hit', x:e.x, y:e.y, alpha:1, scale:.5, color:e.color });

    if (e.hp <= 0) {
      G.roundKills++;
      G.totalKills++;
      addFx({ type:'death', x:e.x, y:e.y, alpha:1, scale:.5, color:e.color });
      addParticles(e.x, e.y, e.color, e.isBoss ? 18 : 7);
      addShake(e.isBoss ? 0.52 : 0.12);
      playSound(e.isBoss ? 'boss_death' : 'death');
    }
  }
}

function buyCard(cardId) {
  if (G.phase !== 'SHOP') { showToast('라운드 중에는 구매할 수 없습니다'); return; }
  const tpl = CARD_DEF[cardId];
  if (!tpl) return;

  if (tpl.type === 'magic') {
    if (G.magicCards.length >= 3) { showToast('마법 카드 슬롯이 가득 찼습니다 (최대 3장)'); return; }
  } else if (tpl.maxCount) {
    const owned = [...G.deck, ...G.hand, ...G.discard].filter(c => c.id === cardId).length;
    if (owned >= tpl.maxCount) { showToast(`${tpl.name}은 최대 ${tpl.maxCount}장`); return; }
  }
  if (G.minerals < tpl.cost) { showToast('⬡ 미네랄 부족'); return; }
  if (G.mana < 1)            { showToast('마나 부족'); return; }

  G.minerals -= tpl.cost;
  G.mana -= 1;

  playSound('buy');
  if (tpl.type === 'magic') {
    G.magicCards.push(makeCard(cardId));
    showToast(`✨ ${tpl.name} 획득 → 마법 슬롯`);
    renderMagicCards();
  } else {
    G.discard.push(makeCard(cardId));
    showToast(`✔ ${tpl.name} 구매`);
  }

  renderShop();
  updateStats();
  renderDeckViewer();
}

function playMagicCard(uid) {
  const idx = G.magicCards.findIndex(c => c.uid === uid);
  if (idx < 0) return;

  if (G.phase === 'GAME_OVER' || G.phase === 'VICTORY') return;

  const card = G.magicCards[idx];

  // 공격 마법은 전투 중에만 사용 가능
  if (card.id === 'MAGIC_ATTACK' && G.phase !== 'BATTLE') {
    showToast('공격 마법은 전투 중에만 사용할 수 있습니다');
    return;
  }

  G.magicCards.splice(idx, 1);

  if (card.id === 'MAGIC_DRAW') {
    drawCards(3);
    spawnTextFx('🔮 +3 드로우', '#b464ff');
  } else if (card.id === 'MAGIC_MINERAL') {
    G.minerals += 5;
    spawnTextFx('✨ +5 ⬡', '#ffd740');
  } else if (card.id === 'MAGIC_ATTACK') {
    let killed = 0;
    G.enemies.forEach(e => {
      if (e.hp > 0) {
        applyDmgToEnemy(5, 'piercing', e);
        if (e.hp <= 0) killed++;
      }
    });
    G.roundKills += killed;
    G.totalKills += killed;
    spawnTextFx('💥 전체 5 피해', '#ef5350');
  } else if (card.id === 'MAGIC_HEAL') {
    const prev = G.hp;
    G.hp = Math.min(G.hp + 5, 20);
    spawnTextFx(`💊 HP +${G.hp - prev}`, '#69f0ae');
  }

  // 사용 즉시 소멸 — discard에 추가하지 않음
  refreshUI();
}

// ═══════════════════════════════════════════════════════
//  적군 생성
// ═══════════════════════════════════════════════════════

function spawnEnemies(round) {
  const wave = getWave(round);
  const cv = document.getElementById('battleCanvas');
  const cx = cv.width / 2, cy = cv.height / 2;
  const hpMult = 1 + (round - 1) * 0.06;

  const orbitBase = { light: 215, medium: 245, heavy: 270, boss: 305 };

  return wave.map((type, i) => {
    const def = ENEMY_DEF[type];
    const angle = (i / wave.length) * Math.PI * 2 - Math.PI / 2;
    const base = def.isBoss ? orbitBase.boss : orbitBase[def.enemyType] || 240;
    const orbitR = base + (i % 3) * 22;
    const scaledHp = Math.floor(def.maxHp * hpMult);
    return {
      ...def,
      uid: ++uidSeq,
      hp: scaledHp, maxHp: scaledHp,
      shield: def.maxShield, armor: def.armor,
      angle, orbitR,
      x: cx + Math.cos(angle) * orbitR,
      y: cy + Math.sin(angle) * orbitR,
      hurtTimer: 0,
      spawnAlpha: 0,
    };
  });
}

// ═══════════════════════════════════════════════════════
//  필드 유닛 시스템
// ═══════════════════════════════════════════════════════

const TYPE_ORDER = { unit:0, unit_effect:1, combo:2, effect:3, resource_effect:4, resource:5, trash:6, magic:7 };
const RING_LAYOUT = [
  { r:52,  n:8  },
  { r:88,  n:14 },
  { r:124, n:20 },
  { r:160, n:26 },
  { r:196, n:32 },
  { r:232, n:38 },
];

function buildFieldUnits(cx, cy) {
  const allCards = [...G.deck, ...G.hand, ...G.discard, ...(G.trash || [])];
  allCards.sort((a, b) => (TYPE_ORDER[a.type] ?? 5) - (TYPE_ORDER[b.type] ?? 5));

  const unitCount = allCards.filter(c => c.type === 'unit' || c.type === 'unit_effect' || c.type === 'combo').length;

  function toFieldUnit(card) {
    let dmg = card.atkDmg || 0;
    if (card.special === 'kingcrab') dmg = unitCount * 3;
    const isUnit = card.type === 'unit' || card.type === 'unit_effect' || card.type === 'combo';
    return {
      cardUid: card.uid, cardId: card.id,
      name: card.name, emoji: card.emoji,
      type: card.type, isUnit,
      atkDmg: dmg,
      atkSpd: card.atkSpd || 1.2,
      atkType: card.atkType || 'normal',
      splashR: card.splashR || 0,
      x: 0, y: 0,
      atkTimer: Math.random() * (card.atkSpd || 1.2),
      atkFx: 0,
    };
  }

  // 마린 토큰 (최우선)
  const units = [];
  for (let i = 0; i < G.marinTokens; i++) {
    units.push({
      cardUid: -(++uidSeq), cardId: 'MARINE_TOKEN',
      name: '마린 토큰', emoji: '🔵',
      type: 'unit', isUnit: true,
      atkDmg: 10, atkSpd: 1.0, atkType: 'piercing', splashR: 0,
      x: 0, y: 0, atkTimer: Math.random(), atkFx: 0,
    });
  }

  allCards.forEach(c => units.push(toFieldUnit(c)));

  assignFieldPositions(units, cx, cy);
  return units;
}

function assignFieldPositions(units, cx, cy) {
  let idx = 0;
  for (const ring of RING_LAYOUT) {
    for (let i = 0; i < ring.n && idx < units.length; i++, idx++) {
      const angle = (i / ring.n) * Math.PI * 2 - Math.PI / 2;
      units[idx].x = cx + Math.cos(angle) * ring.r;
      units[idx].y = cy + Math.sin(angle) * ring.r;
    }
    if (idx >= units.length) break;
  }
  // overflow: pack remaining outside last ring
  while (idx < units.length) {
    const angle = (idx / units.length) * Math.PI * 2;
    units[idx].x = cx + Math.cos(angle) * 268;
    units[idx].y = cy + Math.sin(angle) * 268;
    idx++;
  }
}

// 공격력 계산 (공업 포함)
function getEffectiveDmg(fu) {
  const base = fu.atkDmg;
  if (!base) return 0;
  return Math.floor(base * (1 + G.bonusPower * 0.1));
}

// 가장 가까운 적 탐색 (사거리 무한)
function findTarget(fu) {
  let best = null, bestDist = Infinity;
  for (const e of G.enemies) {
    if (e.hp <= 0) continue;
    const dx = e.x - fu.x, dy = e.y - fu.y;
    const d = Math.sqrt(dx*dx + dy*dy);
    if (d < bestDist) { best = e; bestDist = d; }
  }
  return best;
}

// 적에게 실제 피해 적용 (방어력/보호막 고려)
function applyDmgToEnemy(dmg, atkType, enemy) {
  let d = dmg;
  // 보호막 흡수 (모든 피해 유형 동일)
  if (enemy.shield > 0) {
    const sd = Math.min(enemy.shield, d);
    enemy.shield = Math.max(0, enemy.shield - sd);
    d -= sd;
  }
  if (d <= 0) return { hpDmg: 0, shieldDmg: Math.min(enemy.maxShield || 0, dmg) };
  // 관통형: 방어력 무시 / 일반형·폭발형: 방어력 감소
  if (atkType !== 'piercing') d = Math.max(1, d - enemy.armor);
  const hpDmg = Math.floor(d);
  enemy.hp -= hpDmg;
  enemy.hurtTimer = 0.35;
  return { hpDmg, shieldDmg: 0 };
}

// 필드 유닛 공격 처리
function fireFieldUnit(fu) {
  const dmg = getEffectiveDmg(fu);
  if (!dmg) return;
  const target = findTarget(fu);
  if (!target) return;

  const { hpDmg } = applyDmgToEnemy(dmg, fu.atkType, target);

  // 방사 피해
  if (fu.splashR > 0) {
    for (const e of G.enemies) {
      if (e === target || e.hp <= 0) continue;
      const dx = e.x - target.x, dy = e.y - target.y;
      if (Math.sqrt(dx*dx + dy*dy) <= fu.splashR) {
        applyDmgToEnemy(Math.floor(dmg * 0.6), fu.atkType, e);
      }
    }
  }

  if (target.hp <= 0) {
    G.roundKills++;
    G.totalKills++;
    addParticles(target.x, target.y, target.color, target.isBoss ? 18 : 7, target.isBoss ? 1.4 : 1);
    addShake(target.isBoss ? 0.52 : 0.12);
    playSound(target.isBoss ? 'boss_death' : 'death');

    // 멀티킬 콤보
    const now = performance.now();
    if (now - G.lastKillTime < 750) {
      G.comboCount++;
      if (G.comboCount >= 2) {
        const labels = ['','','DOUBLE!','TRIPLE!','QUAD!!','PENTA!!!'];
        const txt = labels[Math.min(G.comboCount, 5)] || `${G.comboCount} KILL!`;
        spawnTextFx(txt, G.comboCount >= 4 ? '#ff5252' : G.comboCount >= 3 ? '#ffd740' : '#69f0ae');
        addShake(Math.min(0.4, G.comboCount * 0.1));
      }
    } else {
      G.comboCount = 1;
    }
    G.lastKillTime = now;
  } else if (hpDmg > 0) {
    const now = performance.now();
    if (now - _lastHitSnd > 80) { _lastHitSnd = now; playSound('hit'); }
  }

  // 데미지 숫자
  if (hpDmg > 0) {
    const isPiercing = fu.atkType === 'piercing';
    G.dmgNums.push({
      x: target.x, y: target.y - 16 * target.scale,
      val: hpDmg, alpha: 1, vy: -45,
      color: isPiercing ? '#69f0ae' : '#ffffff',
    });
  }

  // 공격 빔
  G.atkBeams.push({ x1: fu.x, y1: fu.y, x2: target.x, y2: target.y, alpha: 0.9, atkType: fu.atkType });
  fu.atkFx = 0.35;

  addFx({ type: 'hit', x: target.x, y: target.y, alpha: 1, scale: 0.4, color: target.color });
}

// ═══════════════════════════════════════════════════════
//  배틀 루프
// ═══════════════════════════════════════════════════════

// 전체 DPS 추정 (HUD 표시용)
function calcTotalUnitPower() {
  if (!G.fieldUnits) return 0;
  return G.fieldUnits.reduce((s, fu) => s + (fu.atkDmg ? Math.floor(getEffectiveDmg(fu) / fu.atkSpd) : 0), 0);
}

function battleLoop(now) {
  const rawDt = Math.min((now - G.lastTime) / 1000, .1);
  G.lastTime = now;
  const dt = rawDt * gameSpeed;

  G.battleTimer -= dt;
  if (G.battleTimer <= 0) { endRound(); return; }

  const cv = document.getElementById('battleCanvas');
  const cx = cv.width / 2, cy = cv.height / 2;

  // 별 반짝임
  G.starField.forEach(s => { s.twinkle += dt * 1.5; });

  // 전투 시작 플래시 감쇠
  if (G.battleFlash > 0) G.battleFlash = Math.max(0, G.battleFlash - dt * 2.8);

  // 적 이동 + 등장 페이드인 + 잔상 트레일
  G.enemies.forEach(e => {
    if (e.hp <= 0) return;
    if (e.spawnAlpha < 1) e.spawnAlpha = Math.min(1, e.spawnAlpha + dt * 3.5);
    e.angle += e.speed * 1.4 * dt * 60;
    e.x = cx + Math.cos(e.angle) * e.orbitR;
    e.y = cy + Math.sin(e.angle) * e.orbitR;
    if (e.hurtTimer > 0) e.hurtTimer -= dt;
    // 빠른 적(저글링류) 잔상
    if (e.speed > 0.034 && e.spawnAlpha >= 1 && Math.random() < 0.45) {
      G.particles.push({
        x: e.x, y: e.y, vx: 0, vy: 0,
        alpha: 0.28, r: 5 * e.scale,
        color: e.color, decay: 4.5,
      });
    }
  });

  // 웨이브 클리어 감지
  if (!G.waveClearedFx && G.roundKills > 0) {
    const alive = G.enemies.filter(e => e.hp > 0).length;
    if (alive === 0) {
      G.waveClearedFx = true;
      spawnTextFx('★ PERFECT CLEAR!', '#ffd740', true);
      addShake(0.28);
      const colors = ['#69f0ae','#ffd740','#29b6f6','#ab47bc','#ff7043'];
      for (let i = 0; i < 32; i++) {
        const angle = (i / 32) * Math.PI * 2;
        G.particles.push({
          x: cx, y: cy,
          vx: Math.cos(angle) * (90 + Math.random() * 130),
          vy: Math.sin(angle) * (90 + Math.random() * 130),
          alpha: 1, r: 2.5 + Math.random() * 3,
          color: colors[i % colors.length], decay: 1.1,
        });
      }
    }
  }

  // ── 필드 유닛 개별 공격 ──
  G.fieldUnits.forEach(fu => {
    if (!fu.atkDmg) return;
    fu.atkTimer -= dt;
    if (fu.atkFx > 0) fu.atkFx -= dt * 3;
    if (fu.atkTimer <= 0) {
      fu.atkTimer = fu.atkSpd;
      fireFieldUnit(fu);
    }
  });

  // 공격 빔 페이드
  G.atkBeams.forEach(b => { b.alpha -= dt * 4; });
  G.atkBeams = G.atkBeams.filter(b => b.alpha > 0);

  // 이펙트 업데이트
  G.effects.forEach(fx => {
    fx.alpha -= dt * (fx.type === 'death' ? 1.4 : 3);
    fx.scale += dt * (fx.type === 'death' ? 3.5 : 2);
  });
  G.effects = G.effects.filter(fx => fx.alpha > 0);

  // 데미지 숫자 업데이트
  G.dmgNums.forEach(d => {
    d.y += d.vy * dt;
    d.vy += 20 * dt;
    d.alpha -= dt * 1.8;
  });
  G.dmgNums = G.dmgNums.filter(d => d.alpha > 0);

  // 파티클 업데이트
  G.particles.forEach(p => {
    p.x += p.vx * dt; p.y += p.vy * dt;
    p.vx *= 1 - dt * 4.5; p.vy *= 1 - dt * 4.5;
    p.alpha -= p.decay * dt;
  });
  G.particles = G.particles.filter(p => p.alpha > 0);

  // 화면 흔들림 감쇠
  if (G.shake > 0) G.shake = Math.max(0, G.shake - dt * 5.5);

  renderCanvas();
  updateStats();

  G.animFrame = requestAnimationFrame(battleLoop);
}

// ═══════════════════════════════════════════════════════
//  캔버스 렌더링
// ═══════════════════════════════════════════════════════


function refreshShop() {
  if (G.phase !== 'SHOP') { showToast('준비 단계에서만 가능합니다'); return; }
  if (G.mana < 1)         { showToast('마나 부족'); return; }
  G.mana -= 1;
  G.shopRandom = generateShop();
  renderShop();
  updateStats();
  spawnTextFx('🔄 상점 새로고침', '#ab47bc');
}

document.addEventListener('DOMContentLoaded', () => {
  document.getElementById('btnStart').addEventListener('click', () => {
    if (G.phase === 'SHOP') startBattlePhase();
  });

  document.getElementById('btnEnd').addEventListener('click', () => {
    if (G.phase === 'BATTLE') endRound();
  });

  document.getElementById('btnResources').addEventListener('click', playAllResources);
  document.getElementById('btnSpeed').addEventListener('click', cycleSpeed);
  document.getElementById('btnRefreshShop').addEventListener('click', refreshShop);

  // 키보드 단축키
  document.addEventListener('keydown', e => {
    if (e.target.tagName === 'INPUT' || e.target.tagName === 'TEXTAREA') return;
    if (e.key === ' ') {
      e.preventDefault();
      if (G.phase === 'SHOP')   document.getElementById('btnStart').click();
      else if (G.phase === 'BATTLE') document.getElementById('btnEnd').click();
    }
    if (e.key === 'r' || e.key === 'R') {
      if (G.phase === 'SHOP' || G.phase === 'BATTLE')
        document.getElementById('btnResources').click();
    }
    if (e.key === 's' || e.key === 'S') {
      cycleSpeed();
    }
    if (e.key === 'f' || e.key === 'F') {
      refreshShop();
    }
    if (e.key === 'Escape') {
      const summary = document.getElementById('summaryOverlay');
      if (!summary.classList.contains('hidden')) summary.click();
    }
  });

  initGame();
});

'use strict';

function renderCanvas() {
  const cv = document.getElementById('battleCanvas');
  const ctx = cv.getContext('2d');
  const W = cv.width, H = cv.height;
  const cx = W / 2, cy = H / 2;

  ctx.clearRect(0, 0, W, H);

  // 화면 흔들림
  const _sk = G.shake || 0;
  if (_sk > 0) {
    ctx.save();
    ctx.translate(
      (Math.random() * 2 - 1) * _sk * _sk * 11,
      (Math.random() * 2 - 1) * _sk * _sk * 11
    );
  }

  // 배경
  const bgGrd = ctx.createRadialGradient(cx, cy, 0, cx, cy, W * .7);
  bgGrd.addColorStop(0, '#080820');
  bgGrd.addColorStop(1, '#030308');
  ctx.fillStyle = bgGrd;
  ctx.fillRect(0, 0, W, H);

  // 별 (반짝임)
  G.starField.forEach(s => {
    const a = s.a * (.7 + .3 * Math.sin(s.twinkle));
    ctx.beginPath();
    ctx.arc(s.x, s.y, s.r, 0, Math.PI * 2);
    ctx.fillStyle = `rgba(200,200,255,${a})`;
    ctx.fill();
  });

  // 유닛 배치 링 (내부)
  [52, 88, 124, 160, 196, 232].forEach((r, i) => {
    ctx.beginPath();
    ctx.arc(cx, cy, r, 0, Math.PI * 2);
    ctx.strokeStyle = `rgba(105,240,174,${.03 + i * .008})`;
    ctx.lineWidth = 1;
    ctx.setLineDash([2, 12]);
    ctx.stroke();
    ctx.setLineDash([]);
  });

  // 적 궤도 링 (외부)
  [215, 260, 305].forEach((r, i) => {
    ctx.beginPath();
    ctx.arc(cx, cy, r, 0, Math.PI * 2);
    ctx.strokeStyle = `rgba(239,83,80,${.04 + i * .015})`;
    ctx.lineWidth = 1;
    ctx.setLineDash([3, 10]);
    ctx.stroke();
    ctx.setLineDash([]);
  });

  // 유닛/아군 영역 경계선
  ctx.beginPath();
  ctx.arc(cx, cy, 245, 0, Math.PI * 2);
  ctx.strokeStyle = 'rgba(41,182,246,0.07)';
  ctx.lineWidth = 1.5;
  ctx.setLineDash([6, 8]);
  ctx.stroke();
  ctx.setLineDash([]);

  // 기지
  drawBase(ctx, cx, cy);

  // 공격 빔 (외부 글로우 + 코어 이중 레이어)
  if (G.atkBeams) {
    G.atkBeams.forEach(b => {
      ctx.save();
      const col = b.atkType === 'piercing' ? '#69f0ae'
                : b.atkType === 'splash'   ? '#ff9800'
                : '#90caf9';
      ctx.strokeStyle = col;
      ctx.shadowColor = col;
      ctx.lineCap = 'round';

      // 외부 글로우 (넓고 반투명)
      ctx.globalAlpha = Math.max(0, b.alpha * 0.18);
      ctx.lineWidth = b.atkType === 'piercing' ? 5 : 8;
      ctx.shadowBlur = 12;
      ctx.beginPath(); ctx.moveTo(b.x1, b.y1); ctx.lineTo(b.x2, b.y2); ctx.stroke();

      // 코어 (얇고 선명)
      ctx.globalAlpha = Math.max(0, b.alpha);
      ctx.lineWidth = b.atkType === 'piercing' ? 1.5 : 2.2;
      ctx.shadowBlur = 7;
      ctx.beginPath(); ctx.moveTo(b.x1, b.y1); ctx.lineTo(b.x2, b.y2); ctx.stroke();

      ctx.restore();
    });
  }

  // 필드 유닛 그리기
  if (G.fieldUnits && G.fieldUnits.length > 0) {
    G.fieldUnits.forEach(fu => {
      const isUnit = fu.isUnit;
      const flash  = fu.atkFx > 0;
      const alpha  = isUnit ? 0.92 : (fu.atkDmg > 0 ? 0.65 : 0.4);
      const r = isUnit ? 11 : (fu.atkDmg > 0 ? 8 : 6);

      ctx.save();
      ctx.globalAlpha = alpha;

      // 글로우
      if (flash) {
        const glow = ctx.createRadialGradient(fu.x, fu.y, 0, fu.x, fu.y, r * 2.5);
        const glowCol = fu.atkType === 'piercing' ? 'rgba(105,240,174,0.6)'
                      : fu.atkType === 'splash'   ? 'rgba(255,152,0,0.6)'
                      : 'rgba(255,255,255,0.4)';
        glow.addColorStop(0, glowCol);
        glow.addColorStop(1, 'transparent');
        ctx.fillStyle = glow;
        ctx.beginPath();
        ctx.arc(fu.x, fu.y, r * 2.5, 0, Math.PI * 2);
        ctx.fill();
      }

      // 유닛 원
      ctx.beginPath();
      ctx.arc(fu.x, fu.y, r, 0, Math.PI * 2);
      const baseCol = isUnit
        ? (fu.atkType === 'piercing' ? '#1a4a2e' : fu.atkType === 'splash' ? '#3a1800' : '#1a1a3a')
        : '#0a0a1e';
      ctx.fillStyle = baseCol;
      ctx.fill();
      const borderCol = isUnit
        ? (fu.atkType === 'piercing' ? '#69f0ae' : fu.atkType === 'splash' ? '#ff9800' : '#90caf9')
        : '#37474f';
      ctx.strokeStyle = flash ? '#fff' : borderCol;
      ctx.lineWidth = flash ? 2 : 1;
      if (flash) { ctx.shadowColor = '#fff'; ctx.shadowBlur = 8; }
      ctx.stroke();
      ctx.shadowBlur = 0;

      // 이모지
      ctx.globalAlpha = alpha;
      ctx.font = `${isUnit ? 9 : 7}px sans-serif`;
      ctx.textAlign = 'center';
      ctx.textBaseline = 'middle';
      ctx.fillText(fu.emoji || '•', fu.x, fu.y);

      ctx.restore();
    });
  }

  // 적군
  G.enemies.forEach(e => { if (e.hp > 0) drawEnemy(ctx, e); });

  // 이펙트
  G.effects.forEach(fx => drawFx(ctx, fx));

  // 파티클
  if (G.particles && G.particles.length > 0) {
    G.particles.forEach(p => {
      ctx.save();
      ctx.globalAlpha = Math.max(0, p.alpha);
      ctx.beginPath();
      ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2);
      ctx.fillStyle = p.color;
      ctx.shadowColor = p.color;
      ctx.shadowBlur = 5;
      ctx.fill();
      ctx.restore();
    });
  }

  // 데미지 숫자
  G.dmgNums.forEach(d => {
    ctx.save();
    ctx.globalAlpha = Math.max(0, d.alpha);
    ctx.font = `bold ${d.val >= 5 ? 16 : 13}px monospace`;
    ctx.fillStyle = d.color;
    ctx.textAlign = 'center';
    ctx.textBaseline = 'middle';
    ctx.shadowColor = d.color;
    ctx.shadowBlur = 6;
    ctx.fillText(d.val, d.x, d.y);
    ctx.restore();
  });

  // HUD (타이머 바)
  if (G.phase === 'BATTLE' || G.phase === 'ROUND_END') {
    const pct = Math.max(0, G.battleTimer / G.battleMaxTime);
    ctx.fillStyle = '#06060e';
    ctx.fillRect(0, 0, W, 5);
    const tc = pct > .5 ? '#69f0ae' : pct > .25 ? '#ffd740' : '#ff5252';
    ctx.fillStyle = tc;
    ctx.shadowColor = tc; ctx.shadowBlur = 4;
    ctx.fillRect(0, 0, W * pct, 5);
    ctx.shadowBlur = 0;

    ctx.font = '11px monospace';
    ctx.textBaseline = 'top';
    ctx.fillStyle = '#60609a';
    ctx.textAlign = 'right';
    ctx.fillText(`${Math.ceil(G.battleTimer)}s`, W - 8, 8);

    const alive = G.enemies.filter(e => e.hp > 0).length;
    ctx.textAlign = 'left';
    ctx.fillStyle = alive > 0 ? '#ffcc02' : '#69f0ae';
    ctx.fillText(`적 ${alive}`, 8, 8);
    ctx.textBaseline = 'alphabetic';
  }

  // 준비 단계 오버레이
  if (G.phase === 'SHOP') {
    ctx.fillStyle = 'rgba(3,3,12,0.52)';
    ctx.fillRect(0, 0, W, H);
    ctx.textAlign = 'center';

    ctx.font = 'bold 22px sans-serif';
    ctx.fillStyle = '#29b6f6';
    ctx.shadowColor = '#29b6f6'; ctx.shadowBlur = 20;
    ctx.fillText(`ROUND ${G.round + 1}`, cx, cy - 18);
    ctx.shadowBlur = 0;

    ctx.font = '13px sans-serif';
    ctx.fillStyle = '#44446a';
    ctx.fillText('카드를 구매하고 라운드를 시작하세요', cx, cy + 14);

    // 배치 카드 수 안내
    const unitCnt = (G.fieldUnits || []).filter(fu => fu.type === 'unit' || fu.type === 'combo').length;
    if (unitCnt > 0) {
      ctx.font = '11px monospace';
      ctx.fillStyle = '#4caf50';
      ctx.fillText(`⚔ 유닛 ${unitCnt}개 배치됨`, cx, cy + 36);
    }
  }

  // 라운드 종료 오버레이
  if (G.phase === 'ROUND_END') {
    ctx.fillStyle = 'rgba(3,3,12,0.55)';
    ctx.fillRect(0, 0, W, H);
    const surv = G.enemies.filter(e => e.hp > 0).length;
    ctx.textAlign = 'center';
    ctx.font = 'bold 18px sans-serif';
    ctx.fillStyle = surv === 0 ? '#69f0ae' : '#ff7043';
    ctx.shadowColor = ctx.fillStyle; ctx.shadowBlur = 14;
    ctx.fillText(`ROUND ${G.round} 종료`, cx, cy - 10);
    ctx.shadowBlur = 0;
    ctx.font = '12px sans-serif';
    ctx.fillStyle = '#60609a';
    ctx.fillText(`생존 ${surv}마리 · 누적 ${G.totalEscaped} / 50`, cx, cy + 16);
  }

  // 전투 시작 플래시 오버레이
  if (G.battleFlash > 0) {
    const hasBoss = G.enemies && G.enemies.some(e => e.isBoss);
    ctx.fillStyle = hasBoss
      ? `rgba(220,30,0,${G.battleFlash * 0.32})`
      : `rgba(41,182,246,${G.battleFlash * 0.22})`;
    ctx.fillRect(0, 0, W, H);

    if (hasBoss && G.battleFlash > 0.45) {
      ctx.textAlign = 'center';
      ctx.font = `bold ${Math.floor(32 * G.battleFlash)}px sans-serif`;
      ctx.fillStyle = `rgba(255,80,80,${G.battleFlash})`;
      ctx.shadowColor = '#ff2200'; ctx.shadowBlur = 30;
      ctx.fillText('⚠ BOSS', cx, cy + 6);
      ctx.shadowBlur = 0;
    }
  }

  if (_sk > 0) ctx.restore();
}

function drawBase(ctx, cx, cy) {
  const r = 30;

  // 외부 글로우
  const grd = ctx.createRadialGradient(cx, cy, 0, cx, cy, r * 2.2);
  grd.addColorStop(0, 'rgba(41,182,246,.25)');
  grd.addColorStop(.6,'rgba(41,182,246,.06)');
  grd.addColorStop(1, 'transparent');
  ctx.fillStyle = grd;
  ctx.beginPath();
  ctx.arc(cx, cy, r * 2.2, 0, Math.PI * 2);
  ctx.fill();

  // 헥사곤
  ctx.beginPath();
  for (let i = 0; i < 6; i++) {
    const a = i * Math.PI / 3 - Math.PI / 6;
    i === 0
      ? ctx.moveTo(cx + r * Math.cos(a), cy + r * Math.sin(a))
      : ctx.lineTo(cx + r * Math.cos(a), cy + r * Math.sin(a));
  }
  ctx.closePath();
  ctx.fillStyle = '#060620';
  ctx.fill();
  ctx.strokeStyle = G.hp > 10 ? '#29b6f6' : G.hp > 5 ? '#ffd740' : '#ff5252';
  ctx.lineWidth = 2;
  ctx.shadowColor = ctx.strokeStyle; ctx.shadowBlur = 10;
  ctx.stroke();
  ctx.shadowBlur = 0;

  // 내부 십자 조준선
  const hpColor = G.hp > 10 ? 'rgba(41,182,246,.75)' : G.hp > 5 ? 'rgba(255,215,64,.75)' : 'rgba(255,82,82,.75)';
  ctx.strokeStyle = hpColor;
  ctx.lineWidth = 1.5;
  ctx.beginPath(); ctx.moveTo(cx - 11, cy); ctx.lineTo(cx + 11, cy); ctx.stroke();
  ctx.beginPath(); ctx.moveTo(cx, cy - 11); ctx.lineTo(cx, cy + 11); ctx.stroke();
  ctx.beginPath(); ctx.arc(cx, cy, 3.5, 0, Math.PI * 2);
  ctx.fillStyle = hpColor; ctx.fill();

  // HP 수치
  ctx.font = 'bold 9px monospace';
  ctx.textAlign = 'center';
  ctx.textBaseline = 'middle';
  ctx.fillStyle = G.hp > 10 ? '#69f0ae' : G.hp > 5 ? '#ffd740' : '#ff5252';
  ctx.shadowColor = ctx.fillStyle; ctx.shadowBlur = 4;
  ctx.fillText(`HP ${G.hp}`, cx, cy + 22);
  ctx.shadowBlur = 0;
  ctx.textBaseline = 'alphabetic';

  // 총 화력 표시 (전투 중)
  if (G.phase === 'BATTLE') {
    const pwr = calcTotalUnitPower();
    ctx.font = 'bold 10px monospace';
    ctx.textAlign = 'center';
    ctx.textBaseline = 'middle';
    ctx.fillStyle = '#ef5350';
    ctx.shadowColor = '#ef5350'; ctx.shadowBlur = 4;
    ctx.fillText(`⚔ ${pwr}`, cx, cy - 22);
    ctx.shadowBlur = 0;
    ctx.textBaseline = 'alphabetic';
  }
}

function drawEnemy(ctx, e) {
  const r = 14 * e.scale;
  const hurt = e.hurtTimer > 0;
  const spAlpha = e.spawnAlpha !== undefined ? e.spawnAlpha : 1;
  ctx.save();
  ctx.globalAlpha = spAlpha;

  // 글로우
  const grd = ctx.createRadialGradient(e.x, e.y, 0, e.x, e.y, r * 1.8);
  grd.addColorStop(0, hurt ? 'rgba(255,80,80,.45)' : e.color + '28');
  grd.addColorStop(1, 'transparent');
  ctx.fillStyle = grd;
  ctx.beginPath(); ctx.arc(e.x, e.y, r * 1.8, 0, Math.PI * 2); ctx.fill();

  // 타입별 도형 (이모지 없음)
  ctx.save();
  ctx.translate(e.x, e.y);

  const hotHurt = hurt && e.hurtTimer > 0.22;
  const fill   = hotHurt ? '#ffffff' : hurt ? '#2d0000' : '#0b0b22';
  const stroke = hotHurt ? '#ffffff' : hurt ? '#ff4444' : e.color;
  ctx.fillStyle   = fill;
  ctx.strokeStyle = stroke;
  ctx.lineWidth   = e.isBoss ? 2.5 : 1.8;
  if (e.isBoss) { ctx.shadowColor = e.color; ctx.shadowBlur = 14; }

  ctx.beginPath();
  if (e.id === 'ZERGLING') {
    // 삼각형 (이동 방향 기준)
    const a = e.angle + Math.PI / 2;
    ctx.moveTo(Math.cos(a) * r,           Math.sin(a) * r);
    ctx.lineTo(Math.cos(a + 2.25) * r*.8, Math.sin(a + 2.25) * r*.8);
    ctx.lineTo(Math.cos(a - 2.25) * r*.8, Math.sin(a - 2.25) * r*.8);
  } else if (e.id === 'HYDRALISK') {
    // 마름모 (다이아몬드)
    ctx.moveTo(0, -r); ctx.lineTo(r * .68, 0);
    ctx.lineTo(0, r);  ctx.lineTo(-r * .68, 0);
  } else if (e.id === 'ULTRALISK') {
    // 두꺼운 육각형
    for (let i = 0; i < 6; i++) {
      const a = i * Math.PI / 3;
      i === 0 ? ctx.moveTo(Math.cos(a) * r, Math.sin(a) * r)
               : ctx.lineTo(Math.cos(a) * r, Math.sin(a) * r);
    }
  } else {
    // BOSS — 6각 별
    for (let i = 0; i < 12; i++) {
      const a = i * Math.PI / 6 - Math.PI / 2;
      const rad = i % 2 === 0 ? r : r * .42;
      i === 0 ? ctx.moveTo(Math.cos(a) * rad, Math.sin(a) * rad)
               : ctx.lineTo(Math.cos(a) * rad, Math.sin(a) * rad);
    }
  }
  ctx.closePath();
  ctx.fill(); ctx.stroke();
  ctx.shadowBlur = 0;

  // 보스 중심 도트
  if (e.id === 'BOSS') {
    ctx.beginPath(); ctx.arc(0, 0, r * .22, 0, Math.PI * 2);
    ctx.fillStyle = e.color; ctx.fill();
  }

  ctx.restore();

  // HP 바
  const bw = r * 2.6, bh = e.isBoss ? 5 : 4;
  const hasShield = e.maxShield > 0;
  const shieldH = hasShield ? (e.isBoss ? 4 : 3) : 0;
  const barGap = hasShield ? 2 : 0;
  const by = e.y - r - 9 - shieldH - barGap;
  const bx = e.x - bw / 2;

  // 쉴드 바
  if (hasShield) {
    const sBy = by + bh + barGap;
    ctx.fillStyle = '#0a0a20';
    ctx.fillRect(bx, sBy, bw, shieldH);
    const shPct = Math.max(0, e.shield / e.maxShield);
    ctx.fillStyle = shPct > 0.5 ? '#40c4ff' : '#0288d1';
    ctx.shadowColor = '#40c4ff'; ctx.shadowBlur = shPct > 0 ? 4 : 0;
    ctx.fillRect(bx, sBy, bw * shPct, shieldH);
    ctx.shadowBlur = 0;
  }

  ctx.fillStyle = '#0a0a20';
  ctx.fillRect(bx, by, bw, bh);
  const hpPct = e.hp / e.maxHp;
  const hpCol = hpPct > .5 ? '#69f0ae' : hpPct > .25 ? '#ffd740' : '#ff5252';
  ctx.fillStyle = hpCol;
  ctx.fillRect(bx, by, bw * hpPct, bh);

  // 방어력 표시 (갑옷 아이콘)
  if (e.armor > 0) {
    ctx.font = '8px monospace';
    ctx.textAlign = 'right';
    ctx.fillStyle = 'rgba(255,215,64,0.7)';
    ctx.fillText(`🛡${e.armor}`, e.x + bw / 2, by - 2);
  }

  // 보스 HP 텍스트
  if (e.isBoss) {
    ctx.fillStyle = '#ddd';
    ctx.font = '9px monospace';
    ctx.textAlign = 'center';
    ctx.fillText(`${e.hp} / ${e.maxHp}`, e.x, by - 3);
  }

  ctx.restore();
}

function drawFx(ctx, fx) {
  ctx.save();
  if (fx.type === 'death') {
    // 내부 채움
    ctx.globalAlpha = Math.max(0, fx.alpha * 0.22);
    ctx.beginPath(); ctx.arc(fx.x, fx.y, 22 * fx.scale, 0, Math.PI * 2);
    ctx.fillStyle = fx.color; ctx.fill();
    // 주 링
    ctx.globalAlpha = Math.max(0, fx.alpha);
    ctx.beginPath(); ctx.arc(fx.x, fx.y, 22 * fx.scale, 0, Math.PI * 2);
    ctx.strokeStyle = fx.color; ctx.lineWidth = 2.5;
    ctx.shadowColor = fx.color; ctx.shadowBlur = 12;
    ctx.stroke();
    // 외부 링
    ctx.globalAlpha = Math.max(0, fx.alpha * 0.45);
    ctx.beginPath(); ctx.arc(fx.x, fx.y, 40 * fx.scale, 0, Math.PI * 2);
    ctx.lineWidth = 1; ctx.stroke();
  } else {
    ctx.globalAlpha = Math.max(0, fx.alpha);
    ctx.beginPath(); ctx.arc(fx.x, fx.y, 15 * fx.scale, 0, Math.PI * 2);
    ctx.strokeStyle = fx.color; ctx.lineWidth = 1.5;
    ctx.shadowColor = fx.color; ctx.shadowBlur = 4;
    ctx.stroke();
  }
  ctx.restore();
}

function addFx(fx) { G.effects.push(fx); }

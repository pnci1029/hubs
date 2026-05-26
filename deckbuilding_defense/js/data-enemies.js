'use strict';

const ENEMY_DEF = {
  ZERGLING:  { id:'ZERGLING',  name:'저글링',       emoji:'🐛', maxHp:50,   armor:0, maxShield:0,   speed:0.012, color:'#69f0ae', scale:1.0,  isBoss:false, enemyType:'light'  },
  HYDRALISK: { id:'HYDRALISK', name:'히드라리스크', emoji:'🐍', maxHp:200,  armor:1, maxShield:0,   speed:0.008, color:'#ffcc02', scale:1.15, isBoss:false, enemyType:'medium' },
  ULTRALISK: { id:'ULTRALISK', name:'울트라리스크', emoji:'🦏', maxHp:600,  armor:3, maxShield:0,   speed:0.005, color:'#ff7043', scale:1.35, isBoss:false, enemyType:'heavy'  },
  BOSS:      { id:'BOSS',      name:'☠ 군주',       emoji:'💀', maxHp:2000, armor:2, maxShield:300, speed:0.003, color:'#ff1744', scale:1.7,  isBoss:true,  enemyType:'heavy'  },
};

function getWave(round) {
  const result = [];
  const n = Math.min(3 + Math.floor(round * 1.7), 30);

  if (round <= 4) {
    for (let i = 0; i < n; i++) result.push('ZERGLING');
  } else if (round <= 9) {
    const h = Math.floor(n * .35);
    for (let i = 0; i < n - h; i++) result.push('ZERGLING');
    for (let i = 0; i < h; i++)     result.push('HYDRALISK');
  } else if (round <= 19) {
    const u = Math.floor(n * .2), h = Math.floor(n * .45);
    for (let i = 0; i < n - u - h; i++) result.push('ZERGLING');
    for (let i = 0; i < h; i++)         result.push('HYDRALISK');
    for (let i = 0; i < u; i++)         result.push('ULTRALISK');
  } else {
    const u = Math.floor(n * .5), h = Math.floor(n * .3);
    for (let i = 0; i < n - u - h; i++) result.push('HYDRALISK');
    for (let i = 0; i < h; i++)         result.push('HYDRALISK');
    for (let i = 0; i < u; i++)         result.push('ULTRALISK');
  }

  if ([5,10,15,20,25,30].includes(round)) result.push('BOSS');
  return result;
}

// ═══════════════════════════════════════════════════════
//  게임 상태
// ═══════════════════════════════════════════════════════
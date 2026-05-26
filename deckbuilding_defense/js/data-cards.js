'use strict';

// ═══════════════════════════════════════════════════════
//  카드 정의
// ═══════════════════════════════════════════════════════

// atkDmg=공격력, atkSpd=공격간격(초), atkType=피해유형, atkRange=사거리(px), splashR=방사범위
const CARD_DEF = {
  // ── 기본 카드 (항상 상점에 진열) ──
  SCV:      { id:'SCV',      name:'SCV',     type:'resource', cost:0,  mineral:1, draw:0, power:0, bonusMana:0, bonusPower:0, emoji:'🔧', desc:'미네랄 +1',           flavor:'건설 요원',
              atkDmg:8,   atkSpd:1.2, atkType:'normal',   atkRange:70,  splashR:0  },
  DRONE:    { id:'DRONE',    name:'드론',    type:'resource', cost:3,  mineral:2, draw:0, power:0, bonusMana:0, bonusPower:0, emoji:'🤖', desc:'미네랄 +2',           flavor:'채광 드론',
              atkDmg:20,  atkSpd:1.0, atkType:'normal',   atkRange:80,  splashR:0  },
  PROBE:    { id:'PROBE',    name:'프로브',  type:'resource', cost:6,  mineral:3, draw:0, power:0, bonusMana:0, bonusPower:0, emoji:'⚡', desc:'미네랄 +3',           flavor:'에너지 수집기',
              atkDmg:30,  atkSpd:0.9, atkType:'normal',   atkRange:90,  splashR:0  },
  MARINE:   { id:'MARINE',   name:'마린',    type:'unit',     cost:2,  mineral:0, draw:0, power:1, bonusMana:0, bonusPower:0, emoji:'🔫', desc:'화력 1 (최대 12장)',  flavor:'전선의 영웅', maxCount:12,
              atkDmg:10,  atkSpd:1.0, atkType:'piercing', atkRange:150, splashR:0  },
  HYDRA:    { id:'HYDRA',    name:'히드라',  type:'unit',     cost:5,  mineral:0, draw:0, power:3, bonusMana:0, bonusPower:0, emoji:'🐍', desc:'화력 3',              flavor:'침투 전문가',
              atkDmg:40,  atkSpd:1.1, atkType:'piercing', atkRange:175, splashR:0  },
  DRAGOON:  { id:'DRAGOON',  name:'드라군',  type:'unit',     cost:8,  mineral:0, draw:0, power:5, bonusMana:0, bonusPower:0, emoji:'🤺', desc:'화력 5',              flavor:'기갑 전투원',
              atkDmg:80,  atkSpd:2.0, atkType:'piercing', atkRange:200, splashR:45 },
  SLACKER:  { id:'SLACKER',  name:'잉여',    type:'trash',    cost:0,  mineral:-2,draw:0, power:0, bonusMana:0, bonusPower:0, emoji:'💤', desc:'미네랄 -2',           flavor:'...',
              atkDmg:0,   atkSpd:99,  atkType:'normal',   atkRange:0,   splashR:0  },

  // ── 모드 카드 (랜덤 풀) ──
  BATTLECRUISER: { id:'BATTLECRUISER', name:'배틀크루저',             type:'unit',   cost:11, mineral:0, draw:0, power:8, bonusMana:0, bonusPower:0, emoji:'🚀', desc:'화력 8 (최상급)',            flavor:'궤도 타격함',
                   atkDmg:80,  atkSpd:1.0, atkType:'piercing', atkRange:210, splashR:0  },
  SUPPLY_DEPOT:  { id:'SUPPLY_DEPOT',  name:'보급고',                type:'effect', cost:4,  mineral:0, draw:3, power:0, bonusMana:0, bonusPower:0, emoji:'📦', desc:'+3 카드 드로우',             flavor:'가장 먼저 구현된 효과 카드',
                   atkDmg:22,  atkSpd:1.3, atkType:'normal',   atkRange:110, splashR:0  },
  SWEET_PIG:     { id:'SWEET_PIG',     name:'꿀돼지',                type:'resource_effect', cost:5,  mineral:2, draw:0, power:0, bonusMana:1, bonusPower:0, emoji:'🐷', desc:'미네랄 +2, 마나 +1',         flavor:'불이라는 효과 카드를 쓰면 좋습니다',
                   atkDmg:20,  atkSpd:1.2, atkType:'normal',   atkRange:100, splashR:0  },
  INDUSTRY:      { id:'INDUSTRY',      name:'공업 단지',             type:'effect', cost:3,  mineral:0, draw:0, power:0, bonusMana:0, bonusPower:1, emoji:'🏭', desc:'+1 공업 (전체 화력 +10%)',   flavor:'공업 요원',
                   atkDmg:6,   atkSpd:1.8, atkType:'normal',   atkRange:90,  splashR:0  },
  BALLOON:       { id:'BALLOON',       name:'풍선',                  type:'effect', cost:3,  mineral:0, draw:1, power:0, bonusMana:1, bonusPower:0, emoji:'🎈', desc:'+1 카드, +1 마나',           flavor:'분위기를 북돋아주는 풍선입니다',
                   atkDmg:5,   atkSpd:1.6, atkType:'normal',   atkRange:85,  splashR:0  },
  VULTURE:       { id:'VULTURE',       name:'카드게임에 진심인 벌쳐', type:'resource_effect', cost:4,  mineral:1, draw:1, power:0, bonusMana:0, bonusPower:0, emoji:'🎴', desc:'+1 카드, +1 미네랄',         flavor:'유희왕!! 예아!!',
                   atkDmg:25,  atkSpd:1.1, atkType:'normal',   atkRange:100, splashR:0  },
  JAR:           { id:'JAR',           name:'욕망의 항아리',          type:'effect', cost:5,  mineral:0, draw:2, power:0, bonusMana:0, bonusPower:0, emoji:'🏺', desc:'+2 카드 드로우',             flavor:'옆동네에선 쓰는게 금지되었다고 합니다',
                   atkDmg:35,  atkSpd:1.5, atkType:'explosive',atkRange:150, splashR:45 },
  THREE:         { id:'THREE',         name:'"3"',                   type:'effect', cost:4,  mineral:2, draw:0, power:0, bonusMana:0, bonusPower:0, marineToken:1, emoji:'3️⃣', desc:'+2 미네랄, +1 마린 토큰', flavor:'마린 1기에 미네랄 2원, 가격은 4원이라서 이름이 "3"',
                   atkDmg:28,  atkSpd:1.2, atkType:'normal',   atkRange:105, splashR:0  },
  SNIPER:        { id:'SNIPER',        name:'핵쟁이 스나이퍼',        type:'effect', cost:5,  mineral:0, draw:0, power:0, bonusMana:0, bonusPower:0, special:'sniper', emoji:'🎯', desc:'카드 파괴 → 파괴 가격당 +1 드로우', flavor:'덱 정리와 드로우를 동시에',
                   atkDmg:60,  atkSpd:2.5, atkType:'explosive',atkRange:200, splashR:0  },
  NEOROBOT:      { id:'NEOROBOT',      name:'네오살인로봇',            type:'combo',  cost:5,  mineral:2, draw:0, power:2, bonusMana:0, bonusPower:0, emoji:'🦾', desc:'미네랄 +2, 화력 2',          flavor:'자신의 이름에 깊은 원한을 품고 있습니다',
                   atkDmg:60,  atkSpd:1.5, atkType:'piercing', atkRange:200, splashR:0  },
  LUCKCAT:       { id:'LUCKCAT',       name:'행운의 고양이',           type:'resource',cost:9, mineral:5, draw:0, power:0, bonusMana:0, bonusPower:0, emoji:'🐱', desc:'미네랄 +5',                  flavor:'영상을 찍어서 유튜브에 올리기 때문이죠!',
                   atkDmg:12,  atkSpd:1.5, atkType:'normal',   atkRange:95,  splashR:0  },
  IMPOSTOR:      { id:'IMPOSTOR',      name:'임포스터',               type:'unit',   cost:3,  mineral:0, draw:1, power:1, bonusMana:0, bonusPower:0, special:'impostor', emoji:'🔴', desc:'+1 카드, 이번 라운드 +1 공업, 화력 1', flavor:'KILL / SABOTAGE',
                   atkDmg:20,  atkSpd:1.3, atkType:'splash',   atkRange:85,  splashR:35 },
  VTUBER:        { id:'VTUBER',        name:'버튜버',                 type:'effect', cost:2,  mineral:0, draw:1, power:0, bonusMana:0, bonusPower:0, emoji:'📺', desc:'+1 카드 드로우',              flavor:'진정한 버츄얼 유튜버',
                   atkDmg:6,   atkSpd:1.4, atkType:'normal',   atkRange:80,  splashR:0  },
  KINGCRAB:      { id:'KINGCRAB',      name:'킹크랩갓디언',           type:'unit',   cost:4,  mineral:0, draw:0, power:0, bonusMana:0, bonusPower:0, special:'kingcrab', emoji:'🦀', desc:'덱 유닛 수만큼 공업 획득',         flavor:'잡덱에 특화된 카드라고 합니다',
                   atkDmg:0,   atkSpd:2.5, atkType:'piercing', atkRange:220, splashR:0  },

  // ── 추가 모드 카드 ──
  INVISIBLE_MAN: { id:'INVISIBLE_MAN', name:'보이지 않는 남자', type:'effect', cost:4, mineral:0, draw:0, power:0, bonusMana:0, bonusPower:0, special:'invisible_man', emoji:'👤', desc:'가장 싼 카드 파괴 → +3 미네랄',   flavor:'그는 투명합니다',
                   atkDmg:80,  atkSpd:2.0, atkType:'explosive',atkRange:200, splashR:50 },
  SHUTTLE:       { id:'SHUTTLE',       name:'빵셔틀',          type:'effect', cost:3, mineral:0, draw:3, power:0, bonusMana:0, bonusPower:0, special:'shuttle',      emoji:'🍞', desc:'+3 드로우 · 3장 자동 포기',       flavor:'일진들의 심부름꾼',
                   atkDmg:22,  atkSpd:1.3, atkType:'normal',   atkRange:110, splashR:0  },
  CHLORELLA:     { id:'CHLORELLA',     name:'클로렐라 수영장', type:'effect', cost:3, mineral:0, draw:0, power:0, bonusMana:0, bonusPower:0, special:'chlorella',    emoji:'🏊', desc:'버림더미 4원 이하 카드 → 덱 위로', flavor:'엽록소가 풍부합니다',
                   atkDmg:20,  atkSpd:1.4, atkType:'normal',   atkRange:100, splashR:0  },
  DRONE_VENDING: { id:'DRONE_VENDING', name:'드론 자판기',     type:'effect', cost:5, mineral:0, draw:0, power:0, bonusMana:1, bonusPower:0, special:'drone_vending',emoji:'🏧', desc:'+1 마나 · 카드 2장 파괴 · 드론 획득',flavor:'자판기에서 드론이 나옵니다',
                   atkDmg:50,  atkSpd:1.4, atkType:'piercing', atkRange:160, splashR:0  },
  UPGRADE_MILL:  { id:'UPGRADE_MILL',  name:'떡상방앗간',      type:'effect', cost:4, mineral:0, draw:0, power:0, bonusMana:0, bonusPower:0, special:'upgrade_mill', emoji:'⬆️', desc:'자원카드 파괴 → 상위 자원카드 획득', flavor:'방앗간에서 업그레이드를',
                   atkDmg:25,  atkSpd:1.5, atkType:'normal',   atkRange:110, splashR:0  },
  TURRET_PILOT:  { id:'TURRET_PILOT',  name:'터렛 조종사',     type:'effect', cost:3, mineral:0, draw:0, power:0, bonusMana:1, bonusPower:0, special:'turret',       emoji:'🎮', desc:'+1 마나 · 손패 효과카드 없으면 +2 드로우',flavor:'조종사 없는 터렛',
                   atkDmg:25,  atkSpd:1.6, atkType:'normal',   atkRange:120, splashR:0  },
  WINDMASTER:    { id:'WINDMASTER',    name:'장풍도사',        type:'effect', cost:4, mineral:0, draw:0, power:0, bonusMana:0, bonusPower:0, special:'windmaster',   emoji:'💨', desc:'손패 중 가장 비싼 효과카드 효과 1회 추가 발동',flavor:'기의 흐름을 느끼세요',
                   atkDmg:0,   atkSpd:99,  atkType:'normal',   atkRange:0,   splashR:0  },
  UGLYQUEEN:     { id:'UGLYQUEEN',     name:'못생퀸',          type:'resource_effect', cost:5, mineral:0, draw:0, power:0, bonusMana:3, bonusPower:0, emoji:'👸', desc:'+3 마나',                         flavor:'못생겼지만 마나가 넘칩니다',
                   atkDmg:0,   atkSpd:99,  atkType:'normal',   atkRange:0,   splashR:0  },
  COWSHED:       { id:'COWSHED',       name:'소난다 외양간',   type:'effect', cost:7, mineral:0, draw:4, power:0, bonusMana:0, bonusPower:0, special:'cowshed',      emoji:'🐄', desc:'+4 드로우 · 2장 포기 · 손패 효과카드당 마린 토큰',flavor:'소가 나다',
                   atkDmg:20,  atkSpd:1.5, atkType:'normal',   atkRange:100, splashR:0  },
  CHOMP:         { id:'CHOMP',         name:'쩝쩝박사',        type:'effect', cost:4, mineral:0, draw:0, power:0, bonusMana:0, bonusPower:0, special:'chomp',        emoji:'😋', desc:'손패 최저가 카드 파괴 → +2 마나',  flavor:'쩝쩝',
                   atkDmg:0,   atkSpd:99,  atkType:'normal',   atkRange:0,   splashR:0  },
  CRAM_SCHOOL:   { id:'CRAM_SCHOOL',   name:'보습 학원',       type:'effect', cost:4, mineral:0, draw:0, power:0, bonusMana:0, bonusPower:0, special:'cram_school',  emoji:'📚', desc:'최저가 카드 파괴 → +2원 카드 획득', flavor:'공부는 해야죠',
                   atkDmg:30,  atkSpd:1.5, atkType:'normal',   atkRange:120, splashR:0  },
  LANLANLOU:     { id:'LANLANLOU',     name:'란란루',          type:'effect', cost:6, mineral:0, draw:0, power:0, bonusMana:0, bonusPower:0, special:'lanlanlou',    emoji:'💃', desc:'손패 5원 이하 효과카드 전부 발동',  flavor:'란란루~',
                   atkDmg:0,   atkSpd:99,  atkType:'normal',   atkRange:0,   splashR:0  },
  MAGIC_SHOPPING:{ id:'MAGIC_SHOPPING',name:'매직 홈쇼핑',     type:'effect', cost:6, mineral:0, draw:0, power:0, bonusMana:0, bonusPower:0, special:'magic_shopping',emoji:'🛒',desc:'최저가 파괴: 5원↓ 무료획득 · 6원↑ 공업', flavor:'지금 당장 전화하세요',
                   atkDmg:20,  atkSpd:1.8, atkType:'explosive',atkRange:160, splashR:40 },
  SUPERLING:     { id:'SUPERLING',     name:'초글링',          type:'effect', cost:2, mineral:0, draw:1, power:0, bonusMana:2, bonusPower:0, emoji:'🐛', desc:'+1 드로우 · +2 마나',              flavor:'초강력 저글링',
                   atkDmg:8,   atkSpd:1.0, atkType:'normal',   atkRange:75,  splashR:0  },
  ZEALOT:        { id:'ZEALOT',        name:'칼빵찔럿',        type:'effect', cost:2, mineral:1, draw:1, power:0, bonusMana:1, bonusPower:0, emoji:'⚔️', desc:'+1 드로우 · +1 미네랄 · +1 마나', flavor:'칼빵을 찌릅니다',
                   atkDmg:15,  atkSpd:1.1, atkType:'normal',   atkRange:85,  splashR:0  },
  SIBERIA_SNOWMAN:{ id:'SIBERIA_SNOWMAN',name:'시베리아 눈사람',type:'unit_effect', cost:6, mineral:0, draw:1, power:0, bonusMana:1, bonusPower:0, emoji:'⛄', desc:'관통 방사 공격 · +1 드로우 · +1 마나',flavor:'시베리아에서 왔습니다',
                   atkDmg:40,  atkSpd:1.8, atkType:'piercing', atkRange:180, splashR:30 },
  RANDOMBOX:     { id:'RANDOMBOX',     name:'랜덤박스',        type:'effect', cost:4, mineral:0, draw:0, power:0, bonusMana:0, bonusPower:0, special:'randombox',    emoji:'🎁', desc:'최저가 카드 파괴 → 무작위 카드 획득',flavor:'무엇이 나올까요',
                   atkDmg:0,   atkSpd:99,  atkType:'normal',   atkRange:0,   splashR:0  },

  // ── 마법 카드 (별도 슬롯, 최대 3장, 사용 즉시 소멸) ──
  MAGIC_DRAW:    { id:'MAGIC_DRAW',    name:'드로우 마법',     type:'magic', cost:4, mineral:0, draw:3, power:0, bonusMana:0, bonusPower:0, emoji:'🔮', desc:'즉시 카드 +3 드로우',           flavor:'카드를 마음껏 뽑아라',
                   atkDmg:0,   atkSpd:99,  atkType:'normal',   atkRange:0,   splashR:0  },
  MAGIC_MINERAL: { id:'MAGIC_MINERAL', name:'미네랄 마법',     type:'magic', cost:5, mineral:5, draw:0, power:0, bonusMana:0, bonusPower:0, emoji:'✨', desc:'즉시 미네랄 +5',                flavor:'풍요의 마법',
                   atkDmg:0,   atkSpd:99,  atkType:'normal',   atkRange:0,   splashR:0  },
  MAGIC_ATTACK:  { id:'MAGIC_ATTACK',  name:'공격 마법',       type:'magic', cost:6, mineral:0, draw:0, power:5, bonusMana:0, bonusPower:0, emoji:'💥', desc:'전체 적에게 즉시 5 피해 (전투 중)', flavor:'폭발적인 마법',
                   atkDmg:0,   atkSpd:99,  atkType:'piercing', atkRange:0,   splashR:0  },
  MAGIC_HEAL:    { id:'MAGIC_HEAL',    name:'회복 마법',       type:'magic', cost:7, mineral:0, draw:0, power:0, bonusMana:0, bonusPower:0, emoji:'💊', desc:'기지 HP +5 회복',               flavor:'생명의 마법',
                   atkDmg:0,   atkSpd:99,  atkType:'normal',   atkRange:0,   splashR:0  },
};

// 상점 고정 기본 카드 (매 라운드 항상 진열)
const SHOP_FIXED = ['SCV', 'DRONE', 'PROBE', 'MARINE', 'HYDRA', 'DRAGOON'];
// 랜덤 모드 카드 풀 (매 라운드 6개 무작위 선택)
const SHOP_RANDOM_POOL = [
  'BATTLECRUISER','SUPPLY_DEPOT','SWEET_PIG','INDUSTRY',
  'BALLOON','VULTURE','JAR','THREE',
  'SNIPER','NEOROBOT','LUCKCAT','IMPOSTOR','VTUBER','KINGCRAB',
  'INVISIBLE_MAN','SHUTTLE','CHLORELLA','DRONE_VENDING','UPGRADE_MILL',
  'TURRET_PILOT','WINDMASTER','UGLYQUEEN','COWSHED','CHOMP',
  'CRAM_SCHOOL','LANLANLOU','MAGIC_SHOPPING','SUPERLING','ZEALOT',
  'SIBERIA_SNOWMAN','RANDOMBOX',
  'MAGIC_DRAW','MAGIC_MINERAL','MAGIC_ATTACK','MAGIC_HEAL',
];
const STARTING_DECK = ['SCV','SCV','SCV','SCV','SCV','SCV','SCV','MARINE','MARINE','MARINE'];

// ═══════════════════════════════════════════════════════
//  적군 정의
// ═══════════════════════════════════════════════════════

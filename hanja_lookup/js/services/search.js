import { CURATED_DICT } from '../data/curated-dict.js';
import { stripSuffix } from '../data/suffixes.js';
import { getMap, isLoaded } from './hanja-map.js';
import { getKeysForChar } from './hanja-index.js';

const SEARCH_LIMIT = 30;
const SUGGEST_LIMIT = 8;
const RELATED_LIMIT = 16;

const HANJA_RE = /[一-鿿㐀-䶿]/;

// 키 하나로 단일 단어 항목을 가져온다 (curated 우선, 없으면 kengdic 맵).
export function getEntry(key) {
  if (CURATED_DICT[key]) return { key, ...CURATED_DICT[key], _source: 'curated' };
  const map = getMap();
  if (map[key]) return { key, hanja: map[key], chars: [], _source: 'kengdic' };
  return null;
}

// 한자(漢字) 문자열로 검색: 해당 한자를 포함하는 단어들.
// 정확 일치 → 접두 → 포함 순, curated 우선, 짧은 단어 우선.
export function searchByHanja(query, limit = SEARCH_LIMIT) {
  const chars = [...query].filter((c) => HANJA_RE.test(c));
  if (!chars.length) return [];
  const full = chars.join('');

  const candidates = getKeysForChar(chars[0]);
  const scored = [];
  for (const key of candidates) {
    const item = getEntry(key);
    if (!item || !item.hanja) continue;
    if (full.length > 1 && !item.hanja.includes(full)) continue;
    const h = item.hanja;
    const s = h === full ? 0 : h.startsWith(full) ? 1 : 2;
    scored.push({ item, s, cur: item._source === 'curated' ? 0 : 1 });
  }
  scored.sort((a, b) => a.s - b.s || a.cur - b.cur || a.item.key.length - b.item.key.length);
  return scored.slice(0, limit).map((x) => x.item);
}

// 특정 한자 한 글자가 들어간 다른 단어들 (연관 단어).
export function relatedByChar(ch, excludeKey, limit = RELATED_LIMIT) {
  const out = [];
  for (const key of getKeysForChar(ch)) {
    if (key === excludeKey) continue;
    const item = getEntry(key);
    if (item) out.push(item);
  }
  out.sort((a, b) =>
    (a._source === 'curated' ? 0 : 1) - (b._source === 'curated' ? 0 : 1) ||
    a.key.length - b.key.length);
  return out.slice(0, limit);
}

// curated 사전 + kengdic 맵을 합쳐 검색한다.
// 한자 입력이면 한자 검색으로, 아니면 한국어 검색으로 분기.
// 한국어: 정확 일치 → 접두 일치 → 포함 검색, 각 단계에서 curated 우선.
export function searchAll(query, limit = SEARCH_LIMIT) {
  const q = query.trim();
  if (!q) return [];
  if (HANJA_RE.test(q)) return searchByHanja(q, limit);

  const map = getMap();
  const mapLoaded = isLoaded();
  const results = [];
  const seen = new Set();

  const addCurated = (key) => {
    if (!seen.has(key) && CURATED_DICT[key]) {
      seen.add(key);
      results.push({ key, ...CURATED_DICT[key], _source: 'curated' });
    }
  };
  const addMap = (key) => {
    if (!seen.has(key) && map[key]) {
      seen.add(key);
      results.push({ key, hanja: map[key], chars: [], _source: 'kengdic' });
    }
  };

  const stripped = stripSuffix(q);

  // 1. 정확 일치
  addCurated(q); addMap(q);
  if (stripped !== q) { addCurated(stripped); addMap(stripped); }

  // 2. 접두 일치
  for (const key of Object.keys(CURATED_DICT)) {
    if (key.startsWith(q)) addCurated(key);
  }
  if (mapLoaded) {
    for (const key of Object.keys(map)) {
      if (key.startsWith(q)) addMap(key);
    }
  }

  // 3. 포함 검색
  for (const key of Object.keys(CURATED_DICT)) {
    if (key.includes(q)) addCurated(key);
  }
  if (mapLoaded) {
    for (const key of Object.keys(map)) {
      if (results.length >= limit) break;
      if (key.includes(q)) addMap(key);
    }
  }

  return results.slice(0, limit);
}

// 자동완성 후보 (정확 → 접두 → 포함)
export function getSuggestions(query) {
  const q = query.trim();
  if (!q) return [];
  if (HANJA_RE.test(q)) {
    return searchByHanja(q, SUGGEST_LIMIT)
      .map((it) => ({ key: it.key, hanja: it.hanja, source: it._source }));
  }

  const map = getMap();
  const mapLoaded = isLoaded();
  const seen = new Set();
  const out = [];

  const push = (key, source) => {
    if (seen.has(key)) return;
    seen.add(key);
    const hanja = CURATED_DICT[key]?.hanja || map[key] || '';
    out.push({ key, hanja, source });
  };

  if (CURATED_DICT[q]) push(q, 'curated');
  if (map[q]) push(q, 'kengdic');

  for (const k of Object.keys(CURATED_DICT)) { if (k.startsWith(q)) push(k, 'curated'); }
  if (mapLoaded) for (const k of Object.keys(map)) { if (out.length >= 10) break; if (k.startsWith(q)) push(k, 'kengdic'); }

  for (const k of Object.keys(CURATED_DICT)) { if (out.length >= 10) break; if (k.includes(q)) push(k, 'curated'); }
  if (mapLoaded) for (const k of Object.keys(map)) { if (out.length >= 10) break; if (k.includes(q)) push(k, 'kengdic'); }

  return out.slice(0, SUGGEST_LIMIT);
}

// curated 사전에서 카테고리로 필터
export function filterByCategory(cat) {
  return Object.entries(CURATED_DICT)
    .filter(([, v]) => v.category === cat)
    .map(([key, v]) => ({ key, ...v }));
}

// 랜덤 단어 키 하나 반환
export function randomKey() {
  const keys = [
    ...Object.keys(CURATED_DICT),
    ...(isLoaded() ? Object.keys(getMap()).slice(0, 5000) : []),
  ];
  return keys[Math.floor(Math.random() * keys.length)];
}

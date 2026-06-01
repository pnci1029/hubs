import { CURATED_DICT } from '../data/curated-dict.js';
import { stripSuffix } from '../data/suffixes.js';
import { getMap, isLoaded } from './hanja-map.js';

const SEARCH_LIMIT = 30;
const SUGGEST_LIMIT = 8;

// curated 사전 + kengdic 맵을 합쳐 검색한다.
// 우선순위: 정확 일치 → 접두 일치 → 포함 검색, 각 단계에서 curated 우선.
export function searchAll(query, limit = SEARCH_LIMIT) {
  const q = query.trim();
  if (!q) return [];

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

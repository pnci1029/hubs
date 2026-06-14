// 한자 글자 → 그 글자를 포함하는 단어 키 목록 (역색인).
// "이 한자가 들어간 다른 단어" 탐색과 한자 검색을 빠르게 하기 위한 캐시.
import { CURATED_DICT } from '../data/curated-dict.js';
import { getMap, isLoaded } from './hanja-map.js';

const HANJA_RE = /[一-鿿㐀-䶿]/;

let index = null;        // Map<char, Set<key>>
let builtWithMap = false; // kengdic 맵까지 포함해 만들었는지

function build() {
  index = new Map();
  const add = (key, hanja) => {
    if (!hanja) return;
    for (const ch of hanja) {
      if (!HANJA_RE.test(ch)) continue;
      let set = index.get(ch);
      if (!set) { set = new Set(); index.set(ch, set); }
      set.add(key);
    }
  };

  for (const [key, v] of Object.entries(CURATED_DICT)) add(key, v.hanja);

  if (isLoaded()) {
    const map = getMap();
    for (const key of Object.keys(map)) add(key, map[key]);
    builtWithMap = true;
  }
}

// 처음 호출 시(또는 맵이 뒤늦게 로드된 경우) 색인을 만든다.
function ensure() {
  if (!index || (!builtWithMap && isLoaded())) build();
}

// 한 글자(한자)를 포함하는 단어 키 배열
export function getKeysForChar(ch) {
  ensure();
  const set = index.get(ch);
  return set ? [...set] : [];
}

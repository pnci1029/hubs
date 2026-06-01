// kengdic 기반 대용량 한자어 맵 (key → 한자). 약 800KB라 비동기로 지연 로드한다.
let HANJA_MAP = {};
let loaded = false;

export function getMap() { return HANJA_MAP; }
export function isLoaded() { return loaded; }

// 한 번만 로드. 성공 시 onReady(map) 콜백 호출.
export async function loadHanjaMap(onReady) {
  if (loaded) { onReady?.(HANJA_MAP); return HANJA_MAP; }
  try {
    const res = await fetch('data/hanja_map.json');
    HANJA_MAP = await res.json();
    loaded = true;
    onReady?.(HANJA_MAP);
  } catch (e) {
    console.warn('hanja_map.json 로드 실패:', e);
  }
  return HANJA_MAP;
}

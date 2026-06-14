import { CURATED_DICT } from './data/curated-dict.js';
import { loadHanjaMap } from './services/hanja-map.js';
import {
  searchAll, getSuggestions, filterByCategory, randomKey, getEntry, relatedByChar,
} from './services/search.js';
import { createAutocomplete } from './components/autocomplete.js';
import { createCategoryBar } from './components/category-bar.js';
import { createResultsList } from './components/results-list.js';
import { createDetailPanel } from './components/detail-panel.js';

const $ = (id) => document.getElementById(id);

const DEFAULT_MSG = '한국어 단어 또는 한자를 입력하세요';

function updateTotal(extra = 0) {
  $('dictTotal').textContent = (Object.keys(CURATED_DICT).length + extra).toLocaleString();
}

document.addEventListener('DOMContentLoaded', () => {
  const input = $('searchInput');
  const detailPane = $('detailPane');
  let currentQuery = '';

  // ── 상세 패널 (우측) ──
  const detail = createDetailPanel({
    contentEl: $('detailContent'),
    emptyEl: $('detailEmpty'),
    getRelated: (ch, key) => relatedByChar(ch, key),
    onSearchHanja: (ch) => { input.value = ch; runSearch(ch); detailPane.classList.remove('open'); },
    onSelectWord: (key) => openDetail(key),
    onClose: () => detailPane.classList.remove('open'),
  });

  function openDetail(key) {
    const item = getEntry(key);
    if (!item) return;
    detail.render(item);
    detailPane.classList.add('open');
  }

  // ── 결과 목록 (중앙, master) ──
  const results = createResultsList({
    resultsEl: $('results'),
    emptyEl: $('emptyState'),
    countEl: $('resultCount'),
    onSelect: (key) => openDetail(key),
    onExample: (word) => { input.value = word; openFirst(runSearch(word)); },
  });

  // 검색만 수행해 결과 목록을 채운다. 찾은 항목 배열을 반환.
  function runSearch(query) {
    currentQuery = query.trim();
    if (!currentQuery) { results.showEmpty(DEFAULT_MSG); return []; }
    const items = searchAll(currentQuery);
    if (!items.length) {
      results.showEmpty(`"${currentQuery}"에 해당하는 한자어를 찾지 못했습니다`);
      return [];
    }
    results.showResults(items, currentQuery);
    return items;
  }

  // 검색 결과 중 첫 항목(보통 정확 일치)을 상세로 연다.
  function openFirst(items) {
    if (items && items.length) openDetail(items[0].key);
  }

  // ── 자동완성 ──
  const autocomplete = createAutocomplete({
    input,
    listEl: $('acList'),
    getSuggestions,
    onSelect: (key) => { runSearch(key); openDetail(key); },
  });

  // ── 카테고리 (사이드바) ──
  const categoryBar = createCategoryBar({
    container: $('catBar'),
    onSelect: (cat) => {
      if (cat === 'all') { runSearch(input.value); return; }
      const items = filterByCategory(cat);
      if (!items.length) { results.showEmpty(DEFAULT_MSG); return; }
      results.showResults(items, '');
    },
  });

  // ── 입력 이벤트 (디바운스) ──
  let debounce;
  input.addEventListener('input', () => {
    clearTimeout(debounce);
    debounce = setTimeout(() => {
      const q = input.value.trim();
      if (q) autocomplete.show(q); else autocomplete.hide();
      runSearch(input.value);
    }, 150);
  });

  input.addEventListener('keydown', (e) => {
    if (e.key === 'ArrowDown') { e.preventDefault(); autocomplete.moveFocus(1); return; }
    if (e.key === 'ArrowUp') { e.preventDefault(); autocomplete.moveFocus(-1); return; }
    if (e.key === 'Enter') {
      clearTimeout(debounce);
      if (!autocomplete.selectFocused()) { autocomplete.hide(); openFirst(runSearch(input.value)); }
      return;
    }
    if (e.key === 'Escape') {
      if (autocomplete.isVisible()) autocomplete.hide();
      else { input.value = ''; runSearch(''); }
    }
  });

  input.addEventListener('blur', () => setTimeout(() => autocomplete.hide(), 150));
  input.addEventListener('focus', () => {
    const q = input.value.trim();
    if (q) autocomplete.show(q);
  });

  // ── 버튼 ──
  $('btnRandom').addEventListener('click', () => {
    const key = randomKey();
    input.value = key;
    openFirst(runSearch(key));
  });
  $('btnClear').addEventListener('click', () => {
    input.value = ''; runSearch(''); detail.clear(); detailPane.classList.remove('open'); input.focus();
  });

  // ── 초기화 ──
  updateTotal();
  results.showEmpty(DEFAULT_MSG);
  detail.clear();
  loadHanjaMap((map) => updateTotal(Object.keys(map).length));
  input.focus();
  void categoryBar;
});

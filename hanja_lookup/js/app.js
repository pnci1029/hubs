import { CURATED_DICT } from './data/curated-dict.js';
import { loadHanjaMap } from './services/hanja-map.js';
import { searchAll, getSuggestions, filterByCategory, randomKey } from './services/search.js';
import { createAutocomplete } from './components/autocomplete.js';
import { createCategoryBar } from './components/category-bar.js';
import { createResultsList } from './components/results-list.js';

const $ = (id) => document.getElementById(id);

const DEFAULT_MSG = '한국어 단어를 입력하세요';

function updateTotal(extra = 0) {
  $('dictTotal').textContent = (Object.keys(CURATED_DICT).length + extra).toLocaleString();
}

document.addEventListener('DOMContentLoaded', () => {
  const input = $('searchInput');
  let currentQuery = '';

  const results = createResultsList({
    resultsEl: $('results'),
    emptyEl: $('emptyState'),
    countEl: $('resultCount'),
    onSelect: (key) => { input.value = key; doSearch(key); },
  });

  function doSearch(query) {
    currentQuery = query.trim();
    if (!currentQuery) { results.showEmpty(DEFAULT_MSG); return; }

    const items = searchAll(currentQuery);
    if (!items.length) {
      results.showEmpty(`"${currentQuery}"에 해당하는 한자어를 찾지 못했습니다`);
      return;
    }
    results.showResults(items, currentQuery);
  }

  const autocomplete = createAutocomplete({
    input,
    listEl: $('acList'),
    getSuggestions,
    onSelect: (key) => doSearch(key),
  });

  const categoryBar = createCategoryBar({
    container: $('catBar'),
    onSelect: (cat) => {
      if (cat === 'all') { doSearch(input.value); return; }
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
      doSearch(input.value);
    }, 150);
  });

  input.addEventListener('keydown', (e) => {
    if (e.key === 'ArrowDown') { e.preventDefault(); autocomplete.moveFocus(1); return; }
    if (e.key === 'ArrowUp') { e.preventDefault(); autocomplete.moveFocus(-1); return; }
    if (e.key === 'Enter') {
      clearTimeout(debounce);
      if (!autocomplete.selectFocused()) { autocomplete.hide(); doSearch(input.value); }
      return;
    }
    if (e.key === 'Escape') {
      if (autocomplete.isVisible()) autocomplete.hide();
      else { input.value = ''; doSearch(''); }
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
    doSearch(key);
  });
  $('btnClear').addEventListener('click', () => {
    input.value = ''; doSearch(''); input.focus();
  });

  // ── 초기화 ──
  updateTotal();
  results.showEmpty(DEFAULT_MSG);
  loadHanjaMap((map) => updateTotal(Object.keys(map).length));
  input.focus();
  // 카테고리 바는 생성 시 자동 렌더됨
  void categoryBar;
});

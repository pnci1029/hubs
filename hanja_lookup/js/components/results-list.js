import { createResultCard } from './result-card.js';
import { EXAMPLE_WORDS } from '../data/examples.js';

// 메인 결과 영역(결과 카드 목록 · 개수 · 빈 상태)을 담당하는 컴포넌트.
// onSelect(key): 결과 카드 클릭 (상세 패널 열기)
// onExample(word): 빈 상태의 예시 칩 클릭 (검색 실행)
export function createResultsList({ resultsEl, emptyEl, countEl, onSelect, onExample }) {
  const emptyMsgEl = emptyEl.querySelector('.empty-msg');

  // 빈 상태의 예시 칩 구성 (한 번만)
  const chipsEl = emptyEl.querySelector('.example-chips');
  if (chipsEl) {
    chipsEl.innerHTML = '';
    EXAMPLE_WORDS.forEach((word) => {
      const chip = document.createElement('span');
      chip.className = 'chip';
      chip.textContent = word;
      chip.addEventListener('click', () => (onExample || onSelect)(word));
      chipsEl.appendChild(chip);
    });
  }

  function showEmpty(message) {
    resultsEl.innerHTML = '';
    countEl.textContent = '';
    emptyMsgEl.textContent = message;
    emptyEl.classList.remove('hidden');
  }

  function showResults(items, currentQuery) {
    emptyEl.classList.add('hidden');
    resultsEl.innerHTML = '';
    countEl.textContent = `${items.length}개`;
    items.forEach((item) =>
      resultsEl.appendChild(createResultCard(item, { currentQuery, onSelect })));
  }

  return { showEmpty, showResults };
}

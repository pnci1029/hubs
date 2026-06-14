import { CATEGORY_LABEL } from '../data/categories.js';
import { stripSuffix } from '../data/suffixes.js';

// 결과 목록(master)의 카드 하나. 컴팩트하게 단어·한자·뜻만 보여주고,
// 글자별 상세 분석은 클릭 시 우측 상세 패널이 담당한다.
// item: { key, hanja, meaning?, category?, chars?, _source }
// onSelect(key): 카드를 클릭했을 때 호출 (상세 패널 열기)
export function createResultCard(item, { currentQuery, onSelect }) {
  const el = document.createElement('div');
  el.className = 'result-card';

  const isExact = item.key === currentQuery || item.key === stripSuffix(currentQuery);
  if (isExact) el.classList.add('exact');

  const catLabel = item.category ? (CATEGORY_LABEL[item.category] || item.category) : '';
  const isDetailed = item.chars && item.chars.length > 0;

  el.innerHTML = `
    <div class="result-header">
      <span class="result-korean">${item.key}</span>
      <span class="result-hanja">${item.hanja}</span>
      ${catLabel ? `<span class="result-cat">${catLabel}</span>` : ''}
      ${!isDetailed && !catLabel ? '<span class="result-cat" style="color:var(--text-lo)">kengdic</span>' : ''}
    </div>
    ${item.meaning ? `<div class="result-meaning">${item.meaning}</div>` : ''}
  `;

  el.addEventListener('click', () => onSelect(item.key));
  return el;
}

import { CHAR_READING } from '../data/char-reading.js';
import { CATEGORY_LABEL } from '../data/categories.js';
import { stripSuffix } from '../data/suffixes.js';

// 한자 문자열을 글자별로 분해해 독음을 붙인다 (kengdic 결과용).
function toCharBlocks(hanjaStr, koreanWord) {
  const korChars = [...koreanWord];
  return [...hanjaStr].map((ch, i) => ({
    char: ch,
    reading: korChars[i] || CHAR_READING[ch] || '?',
  }));
}

function charBlocksHtml(blocks, withMeaning) {
  return `<div class="char-row">${blocks.map((c) => `
    <div class="char-block">
      <div class="char-hanja">${c.char}</div>
      <div class="char-reading">${c.reading}</div>
      ${withMeaning ? `<div class="char-meaning">${c.meaning}</div>` : ''}
    </div>`).join('')}</div>`;
}

// 검색 결과 카드 하나를 만든다.
// item: { key, hanja, meaning?, category?, chars?, _source }
// onSelect(key): 카드를 클릭했을 때 호출
export function createResultCard(item, { currentQuery, onSelect }) {
  const el = document.createElement('div');
  el.className = 'result-card';

  const isExact = item.key === currentQuery || item.key === stripSuffix(currentQuery);
  if (isExact) el.classList.add('exact');

  const catLabel = item.category ? (CATEGORY_LABEL[item.category] || item.category) : '';
  const isDetailed = item.chars && item.chars.length > 0;

  let charHtml = '';
  if (isDetailed) {
    charHtml = charBlocksHtml(item.chars, true);
  } else if (item.hanja && /^[一-鿿㐀-䶿]+$/.test(item.hanja)) {
    charHtml = charBlocksHtml(toCharBlocks(item.hanja, item.key), false);
  }

  el.innerHTML = `
    <div class="result-header">
      <span class="result-korean">${item.key}</span>
      <span class="result-hanja">${item.hanja}</span>
      ${catLabel ? `<span class="result-cat">${catLabel}</span>` : ''}
      ${!isDetailed ? '<span class="result-cat" style="color:var(--text-lo)">kengdic</span>' : ''}
    </div>
    ${item.meaning ? `<div class="result-meaning">${item.meaning}</div>` : ''}
    ${charHtml}
  `;

  el.addEventListener('click', () => onSelect(item.key));
  return el;
}

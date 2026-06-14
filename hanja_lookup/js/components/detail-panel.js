import { CHAR_READING } from '../data/char-reading.js';
import { CATEGORY_LABEL } from '../data/categories.js';

const HANJA_RE = /[一-鿿㐀-䶿]/;

// 우측 상세 패널. 선택한 단어의 큰 한자·뜻·글자 풀이·연관 단어를 표시한다.
// getRelated(char, key): 그 한자가 들어간 다른 단어 배열
// onSearchHanja(char): 글자 풀이의 한자를 눌렀을 때 (그 한자로 검색)
// onSelectWord(key): 연관 단어 칩을 눌렀을 때 (그 단어 상세 열기)
// onClose(): 닫기 (좁은 화면 오버레이용)
export function createDetailPanel({ contentEl, emptyEl, getRelated, onSearchHanja, onSelectWord, onClose }) {

  function blocksFor(item) {
    const kor = [...item.key];
    if (item.chars && item.chars.length) {
      return item.chars.map((c) => ({ char: c.char, reading: c.reading, meaning: c.meaning || '' }));
    }
    if (item.hanja && [...item.hanja].every((c) => HANJA_RE.test(c))) {
      return [...item.hanja].map((ch, i) => ({
        char: ch, reading: kor[i] || CHAR_READING[ch] || '?', meaning: '',
      }));
    }
    return [];
  }

  function clear() {
    contentEl.innerHTML = '';
    emptyEl.classList.remove('hidden');
  }

  function render(item) {
    emptyEl.classList.add('hidden');

    const catLabel = item.category
      ? (CATEGORY_LABEL[item.category] || item.category)
      : (item._source === 'kengdic' ? 'kengdic' : '');
    const blocks = blocksFor(item);

    const blocksHtml = blocks.map((b) => {
      const clickable = HANJA_RE.test(b.char);
      return `
        <button class="d-char${clickable ? '' : ' d-char-plain'}" data-char="${b.char}"
                ${clickable ? `title="${b.char} 들어간 단어 보기"` : 'disabled'}>
          <span class="d-char-hanja">${b.char}</span>
          <span class="d-char-reading">${b.reading}</span>
          ${b.meaning ? `<span class="d-char-meaning">${b.meaning}</span>` : ''}
        </button>`;
    }).join('');

    const relatedHtml = blocks.filter((b) => HANJA_RE.test(b.char)).map((b) => {
      const rel = getRelated(b.char, item.key);
      if (!rel.length) return '';
      const chips = rel.map((r) =>
        `<button class="d-rel-chip" data-key="${r.key}"><b>${r.key}</b><span>${r.hanja}</span></button>`
      ).join('');
      return `<div class="d-rel-group">
        <div class="d-rel-title"><span class="d-rel-char">${b.char}</span> 들어간 단어</div>
        <div class="d-rel-chips">${chips}</div>
      </div>`;
    }).join('');

    contentEl.innerHTML = `
      <button class="d-close" id="dClose" title="닫기">✕</button>
      <div class="d-head">
        ${catLabel ? `<span class="d-cat">${catLabel}</span>` : ''}
        <div class="d-korean">${item.key}</div>
        <div class="d-hanja">${item.hanja || ''}</div>
      </div>
      ${item.meaning ? `<div class="d-meaning">${item.meaning}</div>` : ''}
      ${blocks.length ? `
        <div class="d-section-title">글자 풀이 <small>한자를 누르면 그 글자가 든 단어를 찾습니다</small></div>
        <div class="d-chars">${blocksHtml}</div>` : ''}
      ${relatedHtml ? `<div class="d-section-title">연관 단어</div>${relatedHtml}` : ''}
    `;

    contentEl.querySelectorAll('.d-char:not([disabled])').forEach((el) =>
      el.addEventListener('click', () => onSearchHanja(el.dataset.char)));
    contentEl.querySelectorAll('.d-rel-chip').forEach((el) =>
      el.addEventListener('click', () => onSelectWord(el.dataset.key)));
    const close = contentEl.querySelector('#dClose');
    if (close) close.addEventListener('click', () => onClose?.());

    contentEl.scrollTop = 0;
  }

  return { render, clear };
}

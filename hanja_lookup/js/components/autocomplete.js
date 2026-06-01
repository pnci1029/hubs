// 검색 입력창의 자동완성 드롭다운 컴포넌트.
// getSuggestions(q): 후보 배열 반환 함수, onSelect(key): 선택 시 호출
export function createAutocomplete({ input, listEl, getSuggestions, onSelect }) {
  let focusIdx = -1;

  const hide = () => { listEl.classList.remove('visible'); focusIdx = -1; };

  const highlight = (text, q) => {
    const idx = text.indexOf(q);
    if (idx < 0) return text;
    return text.slice(0, idx) + '<mark>' + text.slice(idx, idx + q.length) + '</mark>' + text.slice(idx + q.length);
  };

  function show(q) {
    const items = getSuggestions(q);
    listEl.innerHTML = '';
    focusIdx = -1;
    if (!items.length) { hide(); return; }

    items.forEach((s) => {
      const el = document.createElement('div');
      el.className = 'autocomplete-item';
      el.innerHTML = `
        <span class="ac-korean">${highlight(s.key, q)}</span>
        <span class="ac-hanja">${s.hanja}</span>
        <span class="ac-badge">${s.source === 'curated' ? '상세' : 'kengdic'}</span>
      `;
      el.addEventListener('mousedown', (e) => {
        e.preventDefault();
        input.value = s.key;
        hide();
        onSelect(s.key);
      });
      listEl.appendChild(el);
    });
    listEl.classList.add('visible');
  }

  function moveFocus(dir) {
    const els = listEl.querySelectorAll('.autocomplete-item');
    if (!els.length) return;
    els.forEach((el) => el.classList.remove('focused'));
    focusIdx = Math.max(-1, Math.min(els.length - 1, focusIdx + dir));
    if (focusIdx >= 0) els[focusIdx].classList.add('focused');
  }

  // 포커스된 후보를 선택. 성공 시 true.
  function selectFocused() {
    const focused = listEl.querySelector('.autocomplete-item.focused');
    if (!focused) return false;
    const key = focused.querySelector('.ac-korean').textContent;
    input.value = key;
    hide();
    onSelect(key);
    return true;
  }

  const isVisible = () => listEl.classList.contains('visible');

  return { show, hide, moveFocus, selectFocused, isVisible };
}

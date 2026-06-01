import { CATEGORY_TABS } from '../data/categories.js';

// 상단 카테고리 필터 바. 버튼을 만들고 클릭 시 onSelect(cat) 호출.
export function createCategoryBar({ container, onSelect }) {
  container.innerHTML = '';
  const buttons = CATEGORY_TABS.map(({ cat, label }, i) => {
    const btn = document.createElement('button');
    btn.className = 'cat-btn' + (i === 0 ? ' active' : '');
    btn.dataset.cat = cat;
    btn.textContent = label;
    btn.addEventListener('click', () => {
      buttons.forEach((b) => b.classList.remove('active'));
      btn.classList.add('active');
      onSelect(cat);
    });
    container.appendChild(btn);
    return btn;
  });

  // 검색 등으로 '전체' 탭으로 되돌릴 때 사용
  function reset() {
    buttons.forEach((b, i) => b.classList.toggle('active', i === 0));
  }

  return { reset };
}

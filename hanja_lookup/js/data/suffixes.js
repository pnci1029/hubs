// 검색 시 제거할 접미사 목록 (긴 것 우선)
const SUFFIXES = [
  '적으로', '적이다', '적이고', '적인', '적이', '스럽다', '스러운', '스럽고',
  '하다', '하고', '하며', '하여', '하게', '함', '하지', '하는', '한', '히',
  '이다', '이고', '이며', '적', '성', '화', '감', '력',
];

// "대국적" → "대국" 처럼 활용형 접미사를 떼어낸다.
export function stripSuffix(word) {
  for (const s of SUFFIXES) {
    if (word.endsWith(s) && word.length > s.length) {
      return word.slice(0, word.length - s.length);
    }
  }
  return word;
}

# 한자 사전 (hanja_lookup)

한국어 단어로 한자를 찾는 경량 웹앱. 빌드 도구 없이 순수 **HTML + CSS + ES Modules**로 구성.

## 실행

ES 모듈과 `fetch`를 쓰므로 정적 서버로 열어야 한다 (`file://` 불가).

```bash
cd hanja_lookup
python3 -m http.server 8000
# http://localhost:8000
```

## 구조

컴포넌트·데이터·서비스를 작은 모듈로 분리해 가볍게 유지한다.

```
hanja_lookup/
├─ index.html
├─ css/
│  ├─ base.css          # 리셋·변수·레이아웃·헤더·검색창
│  └─ components.css     # 카드·글자분석·빈상태·자동완성
├─ data/
│  └─ hanja_map.json     # kengdic 대용량 맵 (지연 로드)
└─ js/
   ├─ app.js             # 진입점 · 이벤트 배선
   ├─ data/              # 순수 데이터
   │  ├─ curated-dict.js #   엄선 사전(독음·뜻)
   │  ├─ char-reading.js #   한자→독음 매핑
   │  ├─ categories.js   #   카테고리 라벨·탭
   │  ├─ suffixes.js     #   접미사 제거(stripSuffix)
   │  └─ examples.js     #   추천 검색어
   ├─ services/          # 로직
   │  ├─ hanja-map.js    #   대용량 맵 비동기 로더
   │  └─ search.js       #   검색·자동완성·필터
   └─ components/        # UI (콜백으로 앱과 분리)
      ├─ result-card.js
      ├─ results-list.js
      ├─ autocomplete.js
      └─ category-bar.js
```

## 데이터 출처

- `curated-dict.js`: 직접 정리한 한자어(글자별 독음·뜻 포함)
- `hanja_map.json`: kengdic 한국어 사전 데이터

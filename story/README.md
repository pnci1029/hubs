# Story - AI 소설 생성 앱

AI를 활용해 키워드와 장르 선택만으로 개인화된 소설을 생성하는 모바일 앱입니다.

## 프로젝트 구조

```
story/
├── frontend/          # Flutter 앱
│   ├── lib/
│   │   ├── main.dart
│   │   └── screens/
│   │       ├── home_screen.dart
│   │       ├── genre_selection_screen.dart
│   │       ├── keyword_input_screen.dart
│   │       └── story_reader_screen.dart
│   └── pubspec.yaml
├── backend/           # Node.js API 서버
│   ├── server.js
│   ├── package.json
│   └── .env.example
└── README.md
```

## 기능

### 메인 기능
- 장르 선택 (로맨스, 판타지, 미스터리, SF, 스릴러, 공포, 사극, 코미디)
- 키워드 기반 스토리 생성
- AI 소설 리더 (폰트 크기 조절, 북마크)
- 깔끔한 다크 테마 UI

### 기술 스택

#### Frontend (Flutter)
- **상태관리**: Flutter Riverpod
- **라우팅**: Go Router
- **HTTP**: Dio
- **폰트**: Google Fonts (나눔명조)
- **애니메이션**: Flutter Animate
- **저장소**: SQLite

#### Backend (Node.js)
- **프레임워크**: Express.js
- **보안**: Helmet, CORS
- **환경변수**: dotenv
- **HTTP클라이언트**: Axios

## 실행 방법

### 백엔드 서버 실행

```bash
cd backend
npm install
npm run dev
```

서버는 http://localhost:3000에서 실행됩니다.

### 프론트엔드 앱 실행

```bash
cd frontend
flutter pub get
flutter run
```

## API 엔드포인트

- `GET /api/genres` - 지원 장르 목록
- `POST /api/generate-story` - 스토리 생성

## 디자인 컨셉

- **색상**: 따뜻한 브라운 (#8B7355) + 다크 테마
- **타이포그래피**: 나눔명조 (책 읽기 최적화)
- **UI**: 미니멀, 깔끔, 독서 친화적
- **UX**: 3단계 플로우 (장르 선택 → 키워드 입력 → 스토리 읽기)
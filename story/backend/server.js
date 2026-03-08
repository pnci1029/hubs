const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

app.use(helmet());
app.use(cors());
app.use(express.json());

const genres = [
  { id: 'romance', name: '로맨스' },
  { id: 'fantasy', name: '판타지' },
  { id: 'mystery', name: '미스터리' },
  { id: 'scifi', name: 'SF' },
  { id: 'thriller', name: '스릴러' },
  { id: 'horror', name: '공포' },
  { id: 'historical', name: '사극' },
  { id: 'comedy', name: '코미디' }
];

app.get('/api/genres', (req, res) => {
  res.json({ genres });
});

app.post('/api/generate-story', async (req, res) => {
  try {
    const { genre, keywords } = req.body;

    if (!genre || !keywords || keywords.length === 0) {
      return res.status(400).json({ error: 'Genre and keywords are required' });
    }

    const sampleStory = {
      id: Date.now().toString(),
      title: `${keywords.join(', ')}의 이야기`,
      content: generateSampleStory(genre, keywords),
      genre: genre,
      keywords: keywords,
      createdAt: new Date().toISOString()
    };

    res.json({ story: sampleStory });
  } catch (error) {
    console.error('Story generation error:', error);
    res.status(500).json({ error: 'Failed to generate story' });
  }
});

function generateSampleStory(genre, keywords) {
  const keywordText = keywords.join(', ');
  
  return `제목: ${keywordText}의 이야기

첫 번째 장

${keywordText}가 등장하는 ${genre} 이야기가 시작됩니다.

주인공은 평범한 일상을 보내고 있었습니다. 하지만 어느 날, 예상치 못한 일이 일어났습니다. ${keywordText}와 관련된 신비로운 사건이 벌어진 것입니다.

이 사건은 주인공의 삶을 완전히 바꾸어 놓았습니다. 처음에는 당황스러웠지만, 점차 이 상황에 적응해 나가기 시작했습니다.

두 번째 장

${keywordText}의 비밀이 조금씩 드러나기 시작했습니다. 주인공은 이 모든 것이 우연이 아니라는 것을 깨달았습니다.

새로운 인물들과 만나게 되면서, 주인공의 시야는 넓어졌습니다. 그들과 함께 ${keywordText}의 진실을 파헤치기 시작했습니다.

위험한 상황들이 계속해서 닥쳐왔지만, 주인공은 포기하지 않았습니다. 동료들과 힘을 합쳐 어려움을 하나씩 극복해 나갔습니다.

세 번째 장

마침내 ${keywordText}의 진실이 밝혀졌습니다. 예상했던 것과는 전혀 다른 놀라운 사실이었습니다.

주인공은 이제 선택의 기로에 서게 되었습니다. 평범한 일상으로 돌아갈 것인지, 아니면 새로운 모험을 계속할 것인지 결정해야 했습니다.

결국 주인공은 자신의 마음을 따라 결정을 내렸습니다. 그 선택이 가져올 결과가 어떨지 모르지만, 후회 없는 삶을 살기로 다짐했습니다.

에필로그

시간이 흘러, 주인공은 자신의 선택이 옳았다는 것을 깨달았습니다. ${keywordText}로 시작된 이 모험은 인생의 가장 소중한 경험이 되었습니다.

새로운 일상 속에서도 그날의 추억들은 생생하게 남아있었습니다. 그리고 언젠가 다시 그런 모험이 찾아온다면, 주저하지 않고 받아들일 준비가 되어 있었습니다.

- 끝 -`;
}

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

module.exports = app;
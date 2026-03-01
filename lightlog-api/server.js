const express = require('express');
const cors = require('cors');
const rateLimit = require('express-rate-limit');
const axios = require('axios');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3001;

// Security middleware
app.use(cors({
  origin: ['http://localhost:3000', 'http://127.0.0.1:*'], // Flutter web origins
  credentials: true
}));

// Rate limiting - prevent API abuse
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 50, // limit each IP to 50 requests per windowMs
  message: 'Too many requests from this IP, please try again later.'
});
app.use('/api/', limiter);

app.use(express.json({ limit: '10mb' }));

// Health check
app.get('/health', (req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

// AI Analysis endpoint
app.post('/api/ai-analysis', async (req, res) => {
  try {
    const { content, mode = 'counselor' } = req.body;
    
    if (!content || content.trim().length === 0) {
      return res.status(400).json({ error: 'Content is required' });
    }

    if (content.length > 5000) {
      return res.status(400).json({ error: 'Content too long (max 5000 characters)' });
    }

    // Define prompts for different modes
    const prompts = {
      counselor: `당신은 따뜻하고 전문적인 심리 상담사입니다. 다음 일기를 읽고 긍정적인 관점에서 위로와 격려의 메시지를 한국어로 작성해주세요. 200자 내외로 답변해주세요.\n\n일기 내용: ${content}`,
      
      bestfriend: `당신은 사용자의 가장 친한 친구입니다. 다음 일기를 읽고 친근하고 따뜻한 톤으로 응원 메시지를 한국어로 작성해주세요. 이모티콘도 적절히 사용하고, 200자 내외로 답변해주세요.\n\n일기 내용: ${content}`,
      
      motivator: `당신은 열정적인 동기부여 전문가입니다. 다음 일기를 읽고 사용자가 더 나은 내일을 위해 행동할 수 있도록 동기를 부여하는 메시지를 한국어로 작성해주세요. 200자 내외로 답변해주세요.\n\n일기 내용: ${content}`,
      
      summary: `다음 일기의 핵심 내용을 3줄로 요약해주세요. 감정적인 톤은 그대로 유지하면서 간결하게 정리해주세요.\n\n일기 내용: ${content}`
    };

    const prompt = prompts[mode] || prompts.counselor;

    const response = await axios.post('https://api.openai.com/v1/chat/completions', {
      model: 'gpt-3.5-turbo',
      messages: [
        { role: 'system', content: '당신은 도움이 되는 AI 어시스턴트입니다.' },
        { role: 'user', content: prompt }
      ],
      max_tokens: 300,
      temperature: 0.7
    }, {
      headers: {
        'Authorization': `Bearer ${process.env.OPENAI_API_KEY}`,
        'Content-Type': 'application/json'
      }
    });

    const aiResponse = response.data.choices[0].message.content.trim();
    
    res.json({
      analysis: aiResponse,
      mode: mode,
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('AI Analysis Error:', error.response?.data || error.message);
    
    if (error.response?.status === 429) {
      return res.status(429).json({ error: 'OpenAI API rate limit exceeded. Please try again later.' });
    }
    
    if (error.response?.status === 401) {
      return res.status(500).json({ error: 'API configuration error' });
    }

    res.status(500).json({ error: 'AI analysis failed. Please try again.' });
  }
});

// Voice-to-text endpoint (Whisper API)
app.post('/api/voice-to-text', async (req, res) => {
  try {
    // This would handle file upload and Whisper API call
    // For now, return a placeholder
    res.json({ 
      text: 'Voice-to-text feature coming soon!',
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Voice-to-text Error:', error);
    res.status(500).json({ error: 'Voice processing failed' });
  }
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Something went wrong!' });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({ error: 'Endpoint not found' });
});

app.listen(PORT, () => {
  console.log(`🚀 LightLog API Server running on http://localhost:${PORT}`);
  console.log(`🔐 Secure OpenAI API proxy ready`);
});
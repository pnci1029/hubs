import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MagicEightBallApp());
}

class MagicEightBallApp extends StatelessWidget {
  const MagicEightBallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic 8-Ball',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const MagicEightBallScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MagicEightBallScreen extends StatefulWidget {
  const MagicEightBallScreen({super.key});

  @override
  State<MagicEightBallScreen> createState() => _MagicEightBallScreenState();
}

class _MagicEightBallScreenState extends State<MagicEightBallScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _shakeAnimation;
  
  String _currentAnswer = "Ask a question and shake me!";
  bool _isShaking = false;
  
  final TextEditingController _questionController = TextEditingController();
  
  final List<String> _answers = [
    "It is certain",
    "Reply hazy, try again",
    "Don't count on it",
    "It is decidedly so",
    "Ask again later",
    "My reply is no",
    "Without a doubt",
    "Better not tell you now",
    "My sources say no",
    "Yes definitely",
    "Cannot predict now",
    "Outlook not so good",
    "You may rely on it",
    "Concentrate and ask again",
    "Very doubtful",
    "As I see it, yes",
    "Most likely",
    "Outlook good",
    "Yes",
    "Signs point to yes"
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _shakeAnimation = Tween<double>(
      begin: 0,
      end: 20,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _questionController.dispose();
    super.dispose();
  }

  void _shakeBall() {
    if (_isShaking) return;
    
    setState(() {
      _isShaking = true;
      _currentAnswer = "...";
    });
    
    HapticFeedback.mediumImpact();
    
    _animationController.forward().then((_) {
      _animationController.reverse().then((_) {
        Future.delayed(const Duration(milliseconds: 500), () {
          final random = Random();
          final randomIndex = random.nextInt(_answers.length);
          
          setState(() {
            _currentAnswer = _answers[randomIndex];
            _isShaking = false;
          });
          
          HapticFeedback.lightImpact();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "🎱 Magic 8-Ball",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              
              // Question Input
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.purple.withOpacity(0.3)),
                ),
                child: TextField(
                  controller: _questionController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Ask your question...",
                    hintStyle: TextStyle(color: Colors.white60),
                    border: InputBorder.none,
                  ),
                ),
              ),
              
              const SizedBox(height: 60),
              
              // Magic 8-Ball
              GestureDetector(
                onTap: _shakeBall,
                child: AnimatedBuilder(
                  animation: _shakeAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(
                        _isShaking ? (_shakeAnimation.value * (Random().nextBool() ? 1 : -1)) : 0,
                        _isShaking ? (_shakeAnimation.value * (Random().nextBool() ? 1 : -1)) : 0,
                      ),
                      child: Container(
                        width: 250,
                        height: 250,
                        decoration: const BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              Colors.grey,
                              Colors.black,
                            ],
                            stops: [0.3, 1.0],
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple,
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade900,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _currentAnswer,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Instructions
              const Text(
                "Tap the ball to get your answer!",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Shake button
              ElevatedButton(
                onPressed: _isShaking ? null : _shakeBall,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  _isShaking ? "Thinking..." : "Shake the Ball",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
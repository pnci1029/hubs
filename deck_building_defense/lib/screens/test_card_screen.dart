import 'package:flutter/material.dart';
import '../widgets/simple_test_card.dart';

class TestCardScreen extends StatelessWidget {
  const TestCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("카드 디자인 테스트"),
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 20),
            
            // 카드들을 2열로 배치
            Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                // 드론 자판기 카드
                SimpleTestCard(
                  cardName: "드론 자판기",
                  description: "매턴 드론 1마리를 자동으로 소환",
                  cost: 3,
                  hp: 15,
                ),
                
                // 핵 스나이퍼 카드
                SimpleTestCard(
                  cardName: "핵 스나이퍼",
                  description: "원거리 저격. 핵탄두 강화 총알",
                  cost: 6,
                  attack: 25,
                  hp: 8,
                ),
                
                // SCV 카드
                SimpleTestCard(
                  cardName: "SCV",
                  description: "기본 자원 카드",
                  cost: 0,
                  mineral: 1,
                  attack: 10,
                  hp: 3,
                ),
                
                // 마린 카드
                SimpleTestCard(
                  cardName: "마린",
                  description: "기본 유닛 카드",
                  cost: 2,
                  attack: 10,
                ),
              ],
            ),
            
            SizedBox(height: 40),
            
            
            SizedBox(height: 20),
            
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(
                "게임으로 돌아가기",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(String title, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: TextStyle(
                color: Colors.green[400],
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: ": $description",
              style: TextStyle(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../widgets/illustrated_card.dart';
import '../models/card_model.dart';
import '../enums/game_enums.dart';

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
                // 킹크랩갓디언
                Container(
                  width: 250,
                  height: 350,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "test1",
                      name: "킹크랩갓디언",
                      description: "거대한 킹크랩이 수호자가 되어 전장을 지배합니다",
                      cost: 8,
                      type: CardType.unit,
                      attack: 45,
                      hp: 60,
                    ),
                    width: 250,
                    height: 350,
                  ),
                ),
                
                // 네오살인로봇
                Container(
                  width: 250,
                  height: 350,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "test2",
                      name: "네오살인로봇",
                      description: "미래에서 온 살인 로봇. 레이저로 적을 제거합니다",
                      cost: 7,
                      type: CardType.unit,
                      attack: 40,
                      hp: 30,
                    ),
                    width: 250,
                    height: 350,
                  ),
                ),
                
                // 란란루
                Container(
                  width: 250,
                  height: 350,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "test3",
                      name: "란란루",
                      description: "기쁘면 저질러버리는 신비로운 존재",
                      cost: 3,
                      type: CardType.magic,
                      mineral: 2,
                      attack: 15,
                    ),
                    width: 250,
                    height: 350,
                  ),
                ),
                
                // 보습학원
                Container(
                  width: 250,
                  height: 350,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "test4",
                      name: "보습학원",
                      description: "피부 건강과 교육을 동시에! 보습 효과로 HP 회복",
                      cost: 4,
                      type: CardType.effect,
                      hp: 20,
                      mineral: 1,
                    ),
                    width: 250,
                    height: 350,
                  ),
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
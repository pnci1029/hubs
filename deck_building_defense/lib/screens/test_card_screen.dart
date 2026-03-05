import 'package:flutter/material.dart';
import '../widgets/illustrated_card.dart';
import '../widgets/custom_painters.dart';
import '../widgets/icon_illustrations.dart';
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
            
            Text(
              "3가지 방법으로 만든 카드 디자인 비교",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            
            SizedBox(height: 20),
            
            // 방법 1: CustomPainter로 그린 버전
            Text(
              "방법 2: CustomPainter로 직접 그리기",
              style: TextStyle(color: Colors.yellow, fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 15,
              runSpacing: 15,
              alignment: WrapAlignment.center,
              children: [
                _buildCustomPaintCard("킹크랩갓디언", KingCrabPainter()),
                _buildCustomPaintCard("네오살인로봇", NeoKillerRobotPainter()),
                _buildCustomPaintCard("란란루", RanranruPainter()),
                _buildCustomPaintCard("보습학원", MoistureAcademyPainter()),
              ],
            ),
            
            SizedBox(height: 30),
            
            // 방법 2: Material Icons 조합
            Text(
              "방법 3: Material Icons 조합",
              style: TextStyle(color: Colors.cyan, fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 15,
              runSpacing: 15,
              alignment: WrapAlignment.center,
              children: [
                _buildIconCard("킹크랩갓디언", IconIllustrations.buildKingCrabIcon()),
                _buildIconCard("네오살인로봇", IconIllustrations.buildNeoKillerRobotIcon()),
                _buildIconCard("란란루", IconIllustrations.buildRanranruIcon()),
                _buildIconCard("보습학원", IconIllustrations.buildMoistureAcademyIcon()),
              ],
            ),
            
            SizedBox(height: 30),
            
            // 새로운 하이브리드 버전
            Text(
              "신규 버전: Container + Material Icons 하이브리드",
              style: TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 15,
              runSpacing: 15,
              alignment: WrapAlignment.center,
              children: [
                Container(
                  width: 180,
                  height: 250,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "hybrid1",
                      name: "킹크랩갓디언",
                      description: "거대한 킹크랩이 수호자가 되어 전장을 지배합니다",
                      cost: 8,
                      type: CardType.unit,
                      attack: 45,
                      hp: 60,
                    ),
                    width: 180,
                    height: 250,
                  ),
                ),
                
                Container(
                  width: 180,
                  height: 250,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "hybrid2",
                      name: "네오살인로봇",
                      description: "미래에서 온 살인 로봇. 레이저로 적을 제거합니다",
                      cost: 7,
                      type: CardType.unit,
                      attack: 40,
                      hp: 30,
                    ),
                    width: 180,
                    height: 250,
                  ),
                ),
                
                Container(
                  width: 180,
                  height: 250,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "hybrid3",
                      name: "란란루",
                      description: "기쁘면 저질러버리는 신비로운 존재",
                      cost: 3,
                      type: CardType.magic,
                      mineral: 2,
                      attack: 15,
                    ),
                    width: 180,
                    height: 250,
                  ),
                ),
                
                Container(
                  width: 180,
                  height: 250,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "hybrid4",
                      name: "보습학원",
                      description: "피부 건강과 교육을 동시에! 보습 효과로 HP 회복",
                      cost: 4,
                      type: CardType.effect,
                      hp: 20,
                      mineral: 1,
                    ),
                    width: 180,
                    height: 250,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 30),
            
            // 기존 버전 (비교용)
            Text(
              "기존 버전: Container 조합 (비교용)",
              style: TextStyle(color: Colors.orange, fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 15,
              runSpacing: 15,
              alignment: WrapAlignment.center,
              children: [
                Container(
                  width: 180,
                  height: 250,
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
                    width: 180,
                    height: 250,
                  ),
                ),
                
                Container(
                  width: 180,
                  height: 250,
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
                    width: 180,
                    height: 250,
                  ),
                ),
                
                Container(
                  width: 180,
                  height: 250,
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
                    width: 180,
                    height: 250,
                  ),
                ),
                
                Container(
                  width: 180,
                  height: 250,
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
                    width: 180,
                    height: 250,
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

  Widget _buildCustomPaintCard(String name, CustomPainter painter) {
    return Container(
      width: 180,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.orange, width: 2),
      ),
      child: Column(
        children: [
          // 헤더
          Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Center(
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // 일러스트 영역
          Expanded(
            child: CustomPaint(
              size: Size.infinite,
              painter: painter,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconCard(String name, Widget iconWidget) {
    return Container(
      width: 180,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.cyan, width: 2),
      ),
      child: Column(
        children: [
          // 헤더
          Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Center(
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // 일러스트 영역
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              child: iconWidget,
            ),
          ),
        ],
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
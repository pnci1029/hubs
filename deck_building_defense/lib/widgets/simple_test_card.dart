import 'package:flutter/material.dart';

class SimpleTestCard extends StatelessWidget {
  final String cardName;
  final String description;
  final int cost;
  final int mineral;
  final int attack;
  final int hp;

  const SimpleTestCard({
    super.key,
    required this.cardName,
    required this.description,
    required this.cost,
    this.mineral = 0,
    this.attack = 0,
    this.hp = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.blue, width: 3),
      ),
      child: Column(
        children: [
          // 헤더
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.vertical(top: Radius.circular(13)),
            ),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    cardName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (cost > 0)
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          cost.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // 일러스트 영역
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _buildIllustration(),
              ),
            ),
          ),
          
          // 설명
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              description,
              style: TextStyle(fontSize: 10),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          
          // 능력치
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (mineral > 0) _buildStat("💎", mineral.toString()),
                if (attack > 0) _buildStat("⚔️", attack.toString()),
                if (hp > 0) _buildStat("❤️", hp.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIllustration() {
    if (cardName == "드론 자판기") {
      return Stack(
        children: [
          Center(
            child: Container(
              width: 60,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.blue[800],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(4),
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 20,
            child: Text("🤖", style: TextStyle(fontSize: 20)),
          ),
        ],
      );
    } else if (cardName == "핵 스나이퍼") {
      return Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("🔫", style: TextStyle(fontSize: 30)),
                SizedBox(height: 5),
                Text("☢️", style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Text("🎯", style: TextStyle(fontSize: 15)),
          ),
        ],
      );
    }
    return Center(
      child: Text("?", style: TextStyle(fontSize: 50, color: Colors.grey)),
    );
  }

  Widget _buildStat(String emoji, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(emoji, style: TextStyle(fontSize: 12)),
        Text(value, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
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
            
            Text(
              "카드 일러스트 디자인",
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            
            SizedBox(height: 10),
            
            Text(
              "Container 구조 + Material Icons 하이브리드 방식",
              style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            
            SizedBox(height: 20),
            
            Wrap(
              spacing: 15,
              runSpacing: 15,
              alignment: WrapAlignment.center,
              children: [
                // 기존 4개 카드
                Container(
                  width: 150,
                  height: 210,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "showcase1",
                      name: "킹크랩갓디언",
                      description: "거대한 킹크랩이 수호자가 되어 전장을 지배합니다",
                      cost: 8,
                      type: CardType.unit,
                      attack: 45,
                      hp: 60,
                    ),
                    width: 150,
                    height: 210,
                  ),
                ),
                Container(
                  width: 150,
                  height: 210,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "showcase2",
                      name: "네오살인로봇",
                      description: "미래에서 온 살인 로봇. 레이저로 적을 제거합니다",
                      cost: 7,
                      type: CardType.unit,
                      attack: 40,
                      hp: 30,
                    ),
                    width: 150,
                    height: 210,
                  ),
                ),
                Container(
                  width: 150,
                  height: 210,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "showcase3",
                      name: "란란루",
                      description: "기쁘면 저질러버리는 신비로운 존재",
                      cost: 3,
                      type: CardType.magic,
                      mineral: 2,
                      attack: 15,
                    ),
                    width: 150,
                    height: 210,
                  ),
                ),
                Container(
                  width: 150,
                  height: 210,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "showcase4",
                      name: "보습학원",
                      description: "피부 건강과 교육을 동시에! 보습 효과로 HP 회복",
                      cost: 4,
                      type: CardType.effect,
                      hp: 20,
                      mineral: 1,
                    ),
                    width: 150,
                    height: 210,
                  ),
                ),
                
                // 새로 추가된 8개 카드
                Container(
                  width: 150,
                  height: 210,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "showcase5",
                      name: "히드라리스크",
                      description: "독성 가시를 발사하는 저그 생명체",
                      cost: 5,
                      type: CardType.unit,
                      attack: 35,
                      hp: 25,
                    ),
                    width: 150,
                    height: 210,
                  ),
                ),
                Container(
                  width: 150,
                  height: 210,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "showcase6",
                      name: "드라군",
                      description: "프로토스 기계 유닛. 원거리 공격 전문",
                      cost: 6,
                      type: CardType.unit,
                      attack: 30,
                      hp: 40,
                    ),
                    width: 150,
                    height: 210,
                  ),
                ),
                Container(
                  width: 150,
                  height: 210,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "showcase7",
                      name: "벌룬",
                      description: "하늘을 나는 폭탄 풍선",
                      cost: 4,
                      type: CardType.unit,
                      attack: 25,
                      hp: 15,
                    ),
                    width: 150,
                    height: 210,
                  ),
                ),
                Container(
                  width: 150,
                  height: 210,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "showcase8",
                      name: "허니 피그",
                      description: "꿀을 만드는 특별한 돼지",
                      cost: 3,
                      type: CardType.resource,
                      hp: 20,
                      mineral: 3,
                    ),
                    width: 150,
                    height: 210,
                  ),
                ),
                Container(
                  width: 150,
                  height: 210,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "showcase9",
                      name: "투명인간",
                      description: "보이지 않는 신비한 존재",
                      cost: 2,
                      type: CardType.effect,
                      attack: 10,
                      hp: 5,
                    ),
                    width: 150,
                    height: 210,
                  ),
                ),
                Container(
                  width: 150,
                  height: 210,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "showcase10",
                      name: "빵 셔틀",
                      description: "빵을 배달하는 고속 차량",
                      cost: 3,
                      type: CardType.resource,
                      attack: 5,
                      mineral: 2,
                    ),
                    width: 150,
                    height: 210,
                  ),
                ),
                Container(
                  width: 150,
                  height: 210,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "showcase11",
                      name: "어글리 퀸",
                      description: "어둠의 힘을 가진 무서운 여왕",
                      cost: 9,
                      type: CardType.unit,
                      attack: 50,
                      hp: 35,
                    ),
                    width: 150,
                    height: 210,
                  ),
                ),
                Container(
                  width: 150,
                  height: 210,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "showcase12",
                      name: "파동권 마스터",
                      description: "에너지 구체를 발사하는 격투가",
                      cost: 6,
                      type: CardType.unit,
                      attack: 35,
                      hp: 30,
                    ),
                    width: 150,
                    height: 210,
                  ),
                ),
                
                // 새로 추가된 4개 카드
                Container(
                  width: 150,
                  height: 210,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "showcase13",
                      name: "배틀크루저",
                      description: "테란의 최상급 우주 전함. 막강한 화력과 방어력을 자랑합니다",
                      cost: 11,
                      type: CardType.unit,
                      attack: 80,
                      hp: 3,
                    ),
                    width: 150,
                    height: 210,
                  ),
                ),
                Container(
                  width: 150,
                  height: 210,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "showcase14",
                      name: "시베리아 눈사람",
                      description: "러시아에선 눈사람이 당신을 녹입니다!",
                      cost: 6,
                      type: CardType.unit,
                      attack: 40,
                      hp: 2,
                    ),
                    width: 150,
                    height: 210,
                  ),
                ),
                Container(
                  width: 150,
                  height: 210,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "showcase15",
                      name: "행운의 고양이",
                      description: "어떻게 고양이가 다른 일꾼들보다 돈을 훨씬 더 많이 버냐고요?",
                      cost: 9,
                      type: CardType.resource,
                      mineral: 5,
                      hp: 1,
                    ),
                    width: 150,
                    height: 210,
                  ),
                ),
                Container(
                  width: 150,
                  height: 210,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "showcase16",
                      name: "랜덤박스",
                      description: "이 유즈맵도 랜덤가챠에 타락하고 마는 날이 결국 와버린 것입니다",
                      cost: 4,
                      type: CardType.effect,
                      hp: 1,
                    ),
                    width: 150,
                    height: 210,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 40),
            
            // 새로운 근본모드 완성 카드들 (6개)
            SizedBox(height: 20),
            
            Text(
              "🎉 근본모드 완성 카드들",
              style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            
            SizedBox(height: 10),
            
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                Container(
                  width: 150,
                  height: 210,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "showcase17",
                      name: "쩝쩝박사",
                      description: "최고의 요리 전문가. 영양가 있는 음식을 만들어줍니다",
                      cost: 5,
                      type: CardType.effect,
                      attack: 25,
                      hp: 2,
                    ),
                    width: 150,
                    height: 210,
                  ),
                ),
                Container(
                  width: 150,
                  height: 210,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "showcase18",
                      name: "매직 홈쇼핑",
                      description: "마법 같은 특가 상품을 판매합니다. 지금 주문하세요!",
                      cost: 6,
                      type: CardType.effect,
                      mineral: 3,
                      hp: 1,
                    ),
                    width: 150,
                    height: 210,
                  ),
                ),
                Container(
                  width: 150,
                  height: 210,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "showcase19",
                      name: "버튜버",
                      description: "버추얼 유튜버로 활동하며 인기를 끌고 있습니다",
                      cost: 4,
                      type: CardType.effect,
                      mineral: 2,
                      hp: 2,
                    ),
                    width: 150,
                    height: 210,
                  ),
                ),
                Container(
                  width: 150,
                  height: 210,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "showcase20",
                      name: "\"3\"",
                      description: "신비로운 숫자 3. 그 의미는 아무도 모릅니다",
                      cost: 3,
                      type: CardType.magic,
                      attack: 33,
                      hp: 3,
                    ),
                    width: 150,
                    height: 210,
                  ),
                ),
                Container(
                  width: 150,
                  height: 210,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "showcase21",
                      name: "초글링",
                      description: "아직 미숙한 초보 저글링. 하지만 성장 가능성이 무궁무진합니다",
                      cost: 1,
                      type: CardType.unit,
                      attack: 8,
                      hp: 1,
                    ),
                    width: 150,
                    height: 210,
                  ),
                ),
                Container(
                  width: 150,
                  height: 210,
                  child: IllustratedCard(
                    card: CardModel(
                      id: "showcase22",
                      name: "임포스터",
                      description: "의심스러운 정체불명의 존재. 과연 누구일까요?",
                      cost: 7,
                      type: CardType.effect,
                      attack: 35,
                      hp: 2,
                    ),
                    width: 150,
                    height: 210,
                  ),
                ),
              ],
            ),

            SizedBox(height: 40),

            Text(
              "🎊 총 22개 카드 일러스트 완성!",
              style: TextStyle(color: Colors.yellow, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            
            Text(
              "✅ 기본 7종 + 근본모드 18종(정교한 일러스트) + 프리미엄 4종",
              style: TextStyle(color: Colors.cyan, fontSize: 14),
            ),
            
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
import 'package:flutter/material.dart';

class IconIllustrations {
  // 킹크랩갓디언 - 아이콘 조합 버전
  static Widget buildKingCrabIcon() {
    return Stack(
      fit: StackFit.expand,
      children: [
        // 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red[700]!, Colors.orange[600]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        // 메인 크랩 아이콘
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 왕관
              Positioned(
                top: 15,
                child: Icon(
                  Icons.star_border,
                  size: 25,
                  color: Colors.yellow[600],
                ),
              ),
              // 크랩 몸체 (원형)
              Container(
                width: 45,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.red[800],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.orange, width: 2),
                ),
                child: Stack(
                  children: [
                    // 눈들
                    Positioned(
                      top: 8,
                      left: 10,
                      child: Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 10,
                      child: Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // 왼쪽 집게발
              Positioned(
                left: -5,
                top: 5,
                child: Icon(
                  Icons.api,
                  size: 20,
                  color: Colors.red[600],
                ),
              ),
              // 오른쪽 집게발
              Positioned(
                right: -5,
                top: 5,
                child: Transform.scale(
                  scaleX: -1,
                  child: Icon(
                    Icons.api,
                    size: 20,
                    color: Colors.red[600],
                  ),
                ),
              ),
            ],
          ),
        ),
        // 가디언 방패
        Positioned(
          top: 10,
          right: 10,
          child: Icon(
            Icons.shield,
            size: 20,
            color: Colors.blue[600],
          ),
        ),
        // 공격력/HP 표시
        Positioned(
          bottom: 8,
          left: 8,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.flash_on, size: 12, color: Colors.red),
              Text("45", style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
              SizedBox(width: 4),
              Icon(Icons.favorite, size: 12, color: Colors.green),
              Text("60", style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  // 네오살인로봇 - 아이콘 조합 버전
  static Widget buildNeoKillerRobotIcon() {
    return Stack(
      fit: StackFit.expand,
      children: [
        // 사이버 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.blue[900]!, Colors.purple[900]!],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        // 메인 로봇
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 로봇 몸체
              Icon(
                Icons.smart_toy,
                size: 50,
                color: Colors.grey[700],
              ),
              // 사이버 오버레이
              Icon(
                Icons.memory,
                size: 30,
                color: Colors.cyan[400],
              ),
              // 레드 바이저
              Positioned(
                top: 5,
                child: Container(
                  width: 25,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.red[600],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
        // NEO 태그
        Positioned(
          top: 8,
          left: 8,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.green[600],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              "NEO",
              style: TextStyle(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        // 킬러 표시
        Positioned(
          top: 8,
          right: 8,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.dangerous,
                size: 20,
                color: Colors.red[600],
              ),
              Icon(
                Icons.close,
                size: 12,
                color: Colors.white,
              ),
            ],
          ),
        ),
        // 레이저 포인터들
        Positioned(
          left: 15,
          bottom: 25,
          child: Icon(
            Icons.brightness_1,
            size: 8,
            color: Colors.red,
          ),
        ),
        Positioned(
          right: 15,
          bottom: 25,
          child: Icon(
            Icons.brightness_1,
            size: 8,
            color: Colors.red,
          ),
        ),
        // 스탯
        Positioned(
          bottom: 8,
          left: 8,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.flash_on, size: 12, color: Colors.red),
              Text("40", style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
              SizedBox(width: 4),
              Icon(Icons.favorite, size: 12, color: Colors.green),
              Text("30", style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  // 란란루 - 아이콘 조합 버전
  static Widget buildRanranruIcon() {
    return Stack(
      fit: StackFit.expand,
      children: [
        // 마법적 배경
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [Colors.pink[200]!, Colors.purple[300]!, Colors.blue[400]!],
              center: Alignment.center,
            ),
          ),
        ),
        // 메인 마법 구체
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 외부 마법 원
              Icon(
                Icons.circle,
                size: 60,
                color: Colors.purple[400],
              ),
              // 내부 에너지
              Icon(
                Icons.circle,
                size: 45,
                color: Colors.white.withOpacity(0.8),
              ),
              // 핵심 에너지
              Icon(
                Icons.star,
                size: 20,
                color: Colors.yellow[400],
              ),
              // 기쁜 얼굴
              Positioned(
                top: 15,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 3,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      width: 3,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
              // 웃는 입
              Positioned(
                bottom: 18,
                child: Container(
                  width: 12,
                  height: 6,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ],
          ),
        ),
        // 마법 파티클들
        Positioned(
          top: 15,
          left: 15,
          child: Icon(Icons.auto_awesome, size: 12, color: Colors.yellow[300]),
        ),
        Positioned(
          top: 20,
          right: 12,
          child: Icon(Icons.star_outline, size: 10, color: Colors.pink[200]),
        ),
        Positioned(
          bottom: 20,
          left: 12,
          child: Icon(Icons.fiber_manual_record, size: 8, color: Colors.white),
        ),
        Positioned(
          bottom: 15,
          right: 15,
          child: Icon(Icons.brightness_1, size: 6, color: Colors.purple[200]),
        ),
        // 스탯
        Positioned(
          bottom: 8,
          left: 8,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.flash_on, size: 12, color: Colors.purple),
              Text("15", style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
              SizedBox(width: 4),
              Icon(Icons.diamond, size: 12, color: Colors.yellow[600]),
              Text("2", style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  // 보습학원 - 아이콘 조합 버전
  static Widget buildMoistureAcademyIcon() {
    return Stack(
      fit: StackFit.expand,
      children: [
        // 수분 배경
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[100]!, Colors.cyan[200]!, Colors.blue[300]!],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        // 메인 건물
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 학교 건물
              Icon(
                Icons.school,
                size: 50,
                color: Colors.white,
              ),
              // 건물 윤곽선
              Icon(
                Icons.home_work_outlined,
                size: 45,
                color: Colors.blue[600],
              ),
            ],
          ),
        ),
        // ACADEMY 표시
        Positioned(
          top: 8,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue[600],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                "ACADEMY",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        // 수분 시스템들
        Positioned(
          top: 12,
          left: 12,
          child: Icon(Icons.water_drop, size: 8, color: Colors.blue[600]),
        ),
        Positioned(
          top: 18,
          right: 15,
          child: Icon(Icons.water_drop, size: 6, color: Colors.cyan[400]),
        ),
        Positioned(
          bottom: 25,
          left: 15,
          child: Icon(Icons.water_drop, size: 10, color: Colors.blue[400]),
        ),
        Positioned(
          bottom: 20,
          right: 12,
          child: Icon(Icons.water_drop, size: 7, color: Colors.cyan[600]),
        ),
        // 추가 수분 표시
        Positioned(
          left: 8,
          top: 35,
          child: Icon(Icons.opacity, size: 12, color: Colors.blue[300]),
        ),
        Positioned(
          right: 8,
          top: 40,
          child: Icon(Icons.opacity, size: 10, color: Colors.cyan[300]),
        ),
        // 교육 관련 아이콘들
        Positioned(
          bottom: 35,
          left: 20,
          child: Icon(Icons.menu_book, size: 8, color: Colors.brown[400]),
        ),
        Positioned(
          bottom: 35,
          right: 20,
          child: Icon(Icons.school, size: 8, color: Colors.blue[800]),
        ),
        // 스탯
        Positioned(
          bottom: 8,
          left: 8,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.favorite, size: 12, color: Colors.green),
              Text("20", style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
              SizedBox(width: 4),
              Icon(Icons.diamond, size: 12, color: Colors.yellow[600]),
              Text("1", style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }
}
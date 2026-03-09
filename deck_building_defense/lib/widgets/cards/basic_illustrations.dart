import 'package:flutter/material.dart';
import '../../models/card_model.dart';
import '../../enums/game_enums.dart';

// 기본 카드 7종 일러스트 클래스
class BasicCardIllustrations {
  
  /*
  ================================
  기본 카드 7종 (Original 7 Cards)
  ================================
  
  ✅ 구현완료:
  1. SCV - 기본 자원 카드 (🔧⛏️)
  2. 마린 - 기본 유닛 카드 (👨‍🚀🔫)  
  3. 드론 - 중급 자원 카드 (🤖⚡)
  4. 히드라리스크 - 중급 유닛 카드 (🐍💀)
  5. 프로브 - 고급 자원 카드 (🔮👽)
  6. 드라군 - 고급 유닛 카드 (🤖🚀)
  7. 잉여 - 쓰레기 효과 카드 (♻️🔄)
  */

  static Widget buildIllustration(CardModel card) {
    switch (card.name) {
      case "SCV":
        return _buildEmojiIllustration("🔧⛏️");
      case "마린":
        return _buildEmojiIllustration("👨‍🚀🔫");
      case "드론":
        return _buildEmojiIllustration("🤖⚡");
      case "히드라리스크":
        return _buildEmojiIllustration("🐍💀");
      case "프로브":
        return _buildEmojiIllustration("🔮👽");
      case "드라군":
        return _buildEmojiIllustration("🤖🚀");
      case "잉여":
      case "리던던트":
        return _buildEmojiIllustration("♻️🔄");
      default:
        return _buildDefaultIllustration();
    }
  }

  static Widget _buildEmojiIllustration(String emojis) {
    final emojiList = emojis.split('');
    return Stack(
      fit: StackFit.expand,
      children: [
        if (emojiList.length >= 1)
          Positioned(
            left: 10,
            top: 10,
            child: Text(emojiList[0], style: TextStyle(fontSize: 25)),
          ),
        if (emojiList.length >= 2)
          Positioned(
            right: 10,
            bottom: 10,
            child: Text(emojiList[1], style: TextStyle(fontSize: 20)),
          ),
      ],
    );
  }

  static Widget _buildDefaultIllustration() {
    return Center(
      child: Text(
        "❓",
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
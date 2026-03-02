import 'package:uuid/uuid.dart';
import '../enums/game_enums.dart';

class EnemyModel {
  final String id;
  final String name;
  final EnemyType type;
  final int maxHP;
  int currentHP;
  final int defense;
  final int shield;
  int currentShield;

  EnemyModel({
    required this.id,
    required this.name,
    required this.type,
    required this.maxHP,
    required this.currentHP,
    required this.defense,
    required this.shield,
    required this.currentShield,
  });

  static EnemyModel create(EnemyType type, int round) {
    final String id = const Uuid().v4();
    
    switch (type) {
      case EnemyType.mass:
        return EnemyModel(
          id: id,
          name: "물량형 적",
          type: type,
          maxHP: 5 + round,
          currentHP: 5 + round,
          defense: 0,
          shield: 0,
          currentShield: 0,
        );
        
      case EnemyType.armored:
        return EnemyModel(
          id: id,
          name: "방어형 적",
          type: type,
          maxHP: 10 + (round * 2),
          currentHP: 10 + (round * 2),
          defense: 2 + (round ~/ 3),
          shield: 0,
          currentShield: 0,
        );
        
      case EnemyType.shielded:
        final shieldAmount = 5 + round;
        return EnemyModel(
          id: id,
          name: "쉴드형 적",
          type: type,
          maxHP: 8 + round,
          currentHP: 8 + round,
          defense: 0,
          shield: shieldAmount,
          currentShield: shieldAmount,
        );
    }
  }

  void takeDamage(int damage) {
    if (damage <= 0) return;
    
    // 쉴드부터 피해 적용
    if (currentShield > 0) {
      final shieldDamage = damage.clamp(0, currentShield);
      currentShield -= shieldDamage;
      damage -= shieldDamage;
    }
    
    // 남은 피해를 HP에 적용
    if (damage > 0) {
      currentHP -= damage;
      currentHP = currentHP.clamp(0, maxHP);
    }
  }

  bool get isDead => currentHP <= 0;
  
  double get hpPercentage => maxHP > 0 ? currentHP / maxHP : 0.0;
  
  double get shieldPercentage => shield > 0 ? currentShield / shield : 0.0;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnemyModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
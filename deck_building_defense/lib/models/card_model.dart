import 'package:uuid/uuid.dart';
import '../enums/game_enums.dart';

class CardModel {
  final String id;
  final String name;
  final String description;
  final int cost;
  final CardType type;
  final int mineral;
  final int attack;
  final bool ignoreDefense;
  final int hp;
  int currentHP;

  CardModel({
    required this.id,
    required this.name,
    required this.description,
    required this.cost,
    required this.type,
    this.mineral = 0,
    this.attack = 0,
    this.ignoreDefense = false,
    this.hp = 0,
    int? currentHP,
  }) : currentHP = currentHP ?? hp;

  // 기본 7종 카드 - 위키 기준
  static CardModel scvCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "SCV",
      description: "기본 자원 카드입니다. 자원 카드가 주는 미네랄로 더 좋은 카드를 구매하세요.",
      cost: 0,
      type: CardType.resource,
      mineral: 1,
      attack: 10,
      hp: 3,
    );
  }

  static CardModel marineCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "마린",
      description: "기본적인 유닛 카드 입니다. 유닛 카드는 화력이 강하지만 효과가 없습니다.",
      cost: 2,
      type: CardType.unit,
      attack: 10,
      ignoreDefense: true,
      hp: 5,
    );
  }

  static CardModel droneCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "드론",
      description: "중급 자원 카드 입니다. 바로 옆에 있는 프로브 때문에 꿀려 보이지만 생각보다 괜찮습니다.",
      cost: 3,
      type: CardType.resource,
      mineral: 2,
      attack: 25,
      hp: 2,
    );
  }

  static CardModel hydraliskCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "히드라",
      description: "중급 유닛 카드 입니다. 마린의 3배 화력을 내면서 공간도 덜 차지합니다.",
      cost: 5,
      type: CardType.unit,
      attack: 40,
      ignoreDefense: true,
      hp: 6,
    );
  }

  static CardModel probeCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "프로브",
      description: "고급 자원 카드입니다. 인건비도 사료도 필요없기 때문에 무려 3 미네랄씩이나 줍니다.",
      cost: 6,
      type: CardType.resource,
      mineral: 3,
      attack: 35,
      hp: 4,
    );
  }

  static CardModel dragoonCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "드라군",
      description: "고급 유닛 카드 입니다. 기본 카드 중 화력이 가장 높습니다.",
      cost: 8,
      type: CardType.unit,
      attack: 80,
      ignoreDefense: true,
      hp: 8,
    );
  }

  static CardModel redundantCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "잉여",
      description: "이 카드는 너무 구려서 이 텍스트를 읽는 것 만으로도 기분이 더러워집니다.",
      cost: 0,
      type: CardType.effect,
    );
  }

  // 근본 모드 카드들 (31종) - 위키 정확한 데이터
  static CardModel supplyDepotCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "보급고",
      description: "근본 있는 드로우 카드입니다. 가장 먼저 구현된 효과 카드이기도 합니다.",
      cost: 4,
      type: CardType.effect,
      attack: 27,
      hp: 1,
    );
  }

  static CardModel balloonCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "풍선",
      description: "분위기를 북돋아주는 풍선입니다. 손이 잘풀리는 행운을 가져다 줍니다.",
      cost: 3,
      type: CardType.effect,
      hp: 2,
    );
  }

  static CardModel industrialComplexCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "공업 단지",
      description: "공업을 할 때 마다 유닛 카드들이 약 10%정도 강해집니다.",
      cost: 3,
      type: CardType.effect,
      hp: 1,
    );
  }

  static CardModel seriousGamerVultureCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "카드게임에 진심인 벌쳐",
      description: "유희왕!! 예아!! 라는 말을 남길 정도로 카드게임에 진심입니다.",
      cost: 4,
      type: CardType.effect,
      mineral: 1,
      attack: 30,
      hp: 1,
    );
  }

  static CardModel honeyPigCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "꿀돼지",
      description: "불이라는 효과 카드를 쓰면 좋습니다.",
      cost: 5,
      type: CardType.effect,
      mineral: 2,
      attack: 25,
      hp: 1,
    );
  }

  static CardModel jarOfDesireCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "욕망의 항아리",
      description: "너무나도 못생긴 항아리라 옆동네에선 쓰는게 금지되었다고 합니다.",
      cost: 5,
      type: CardType.effect,
      attack: 40,
      hp: 1,
    );
  }

  static CardModel invisibleManCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "보이지 않는 남자",
      description: "숨겨진 기능이 있지만 보이지 않습니다.",
      cost: 4,
      type: CardType.effect,
      attack: 120,
      hp: 1,
    );
  }

  static CardModel breadShuttleCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "빵셔틀",
      description: "우리의 원조 빵셔틀은 기어다니는 크로와상을 가져다 준다고 합니다.",
      cost: 3,
      type: CardType.effect,
      attack: 30,
      hp: 2,
    );
  }

  static CardModel chlorellaPoolCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "클로렐라 수영장",
      description: "클로렐라를 탕수육 소스에 타는 레시피가 있더군요.",
      cost: 3,
      type: CardType.effect,
      attack: 25,
      hp: 1,
    );
  }

  static CardModel droneVendingMachineCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "드론 자판기",
      description: "일단 뭘 넣던 간에 드론으로 바꿔줍니다.",
      cost: 5,
      type: CardType.effect,
      attack: 65,
      hp: 1,
    );
  }

  static CardModel riceMillCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "떡상방앗간",
      description: "자원 카드 떡상 가즈앗!!!",
      cost: 4,
      type: CardType.effect,
      attack: 30,
      hp: 1,
    );
  }

  static CardModel nuclearSniperCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "핵쟁이 스나이퍼",
      description: "핵 사용 유저로 신고당해서 밴당했습니다.",
      cost: 5,
      type: CardType.effect,
      attack: 60,
      hp: 1,
    );
  }

  static CardModel turretOperatorCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "터렛 조종사",
      description: "마나회복, 드로우, 락다운까지 뭐하나 빠지는게 없는 사기 카드.",
      cost: 3,
      type: CardType.effect,
      attack: 30,
      hp: 1,
    );
  }

  static CardModel hadoukenMasterCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "장풍도사",
      description: "장풍도사로 장풍도사를 내면, 효과 카드 2장을 2번씩 발동할 수 있다.",
      cost: 4,
      type: CardType.effect,
      hp: 1,
    );
  }

  static CardModel uglyQueenCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "못생퀸",
      description: "가스 제공 카드",
      cost: 5,
      type: CardType.resource,
      hp: 1,
    );
  }

  static CardModel snanDaBarnCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "소난다 외양간",
      description: "우리의 상상력은 가끔 너무 과할 때가 있습니다",
      cost: 7,
      type: CardType.effect,
      attack: 50,
      hp: 1,
    );
  }

  static CardModel kingCrabGuardianCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "킹크랩갓디언",
      description: "잡덱에 특화된 카드라고 합니다.",
      cost: 4,
      type: CardType.unit,
      attack: 0,
      hp: 1,
    );
  }

  static CardModel chompDoctorCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "쩝쩝박사",
      description: "맛있는 양념이야말로 요리의 완성입니다.",
      cost: 4,
      type: CardType.effect,
      hp: 1,
    );
  }

  static CardModel moisturizingAcademyCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "보습 학원",
      description: "살짝 애매해 보이지만 생각보다 좋은 카드입니다.",
      cost: 4,
      type: CardType.effect,
      attack: 40,
      hp: 1,
    );
  }

  static CardModel ranRanRuCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "란란루",
      description: "란란루가 뭘까요? 기쁘면 저질러버립니다.",
      cost: 6,
      type: CardType.effect,
      hp: 1,
    );
  }

  static CardModel neoAssassinRobotCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "네오살인로봇",
      description: "자신의 이름을 이따위로 지은 제작자에게 깊은 원한을 품고 있습니다.",
      cost: 5,
      type: CardType.unit,
      mineral: 2,
      attack: 60,
      hp: 3,
    );
  }

  static CardModel magicHomeShoppingCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "매직 홈쇼핑",
      description: "잭필드 넥서스! 단돈 399 미네랄! 지금 바로 주문하세요!",
      cost: 6,
      type: CardType.effect,
      attack: 28,
      hp: 1,
    );
  }

  static CardModel vtuberCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "버튜버",
      description: "사실 게임 안인지라 실제로 존재하진 않습니다.",
      cost: 2,
      type: CardType.effect,
      hp: 1,
    );
  }

  static CardModel threeCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "\"3\"",
      description: "마린은 1기 주고 미네랄은 2원 주고 가격은 4원 이라서 이름이 \"3\"인걸까요???",
      cost: 4,
      type: CardType.effect,
      mineral: 2,
      attack: 33,
      hp: 1,
    );
  }

  static CardModel earlyZerglingCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "초글링",
      description: "그 시절 초글링이라 불렸던 애들 지금은 다 아재라고 합니다.",
      cost: 2,
      type: CardType.effect,
      attack: 10,
      hp: 1,
    );
  }

  static CardModel imposterCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "임포스터",
      description: "KILL / SABOTAGE",
      cost: 3,
      type: CardType.unit,
      attack: 20,
      hp: 2,
    );
  }

  static CardModel luckyCatCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "행운의 고양이",
      description: "어떻게 고양이가 다른 일꾼들보다 돈을 훨씬 더 많이 버냐고요?",
      cost: 9,
      type: CardType.resource,
      mineral: 5,
      hp: 1,
    );
  }

  static CardModel battlecruiserCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "배틀크루저",
      description: "최상급의 유닛.",
      cost: 11,
      type: CardType.unit,
      attack: 80,
      hp: 3,
    );
  }

  static CardModel knifeZealotCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "칼빵찔럿",
      description: "외계인답게 미래를 아는거 같습니다.",
      cost: 2,
      type: CardType.effect,
      attack: 32,
      hp: 1,
    );
  }

  static CardModel siberianSnowmanCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "시베리아 눈사람",
      description: "러시아에선 눈사람이 당신을 녹입니다!",
      cost: 6,
      type: CardType.unit,
      attack: 40,
      hp: 2,
    );
  }

  static CardModel randomBoxCard() {
    return CardModel(
      id: const Uuid().v4(),
      name: "랜덤박스",
      description: "이 유즈맵도 랜덤가챠에 타락하고 마는 날이 결국 와버린 것입니다.",
      cost: 4,
      type: CardType.effect,
      hp: 1,
    );
  }

  static CardModel effectCard(String name, String description, int cost) {
    return CardModel(
      id: const Uuid().v4(),
      name: name,
      description: description,
      cost: cost,
      type: CardType.effect,
    );
  }

  static CardModel magicCard(String name, String description, int cost) {
    return CardModel(
      id: const Uuid().v4(),
      name: name,
      description: description,
      cost: cost,
      type: CardType.magic,
    );
  }

  // 기본 자원 카드들 (호환성 유지)
  static CardModel basicResource() {
    return scvCard();
  }

  static CardModel advancedResource() {
    return probeCard();
  }

  static CardModel basicUnit() {
    return marineCard();
  }

  static CardModel advancedUnit() {
    return hydraliskCard();
  }

  void takeDamage(int damage) {
    currentHP -= damage;
    if (currentHP < 0) currentHP = 0;
  }

  bool get isDead => currentHP <= 0;
  
  double get hpPercentage => hp > 0 ? currentHP / hp : 0.0;

  CardModel copyWith({
    String? id,
    String? name,
    String? description,
    int? cost,
    CardType? type,
    int? mineral,
    int? attack,
    bool? ignoreDefense,
    int? hp,
    int? currentHP,
  }) {
    return CardModel(
      id: id ?? const Uuid().v4(),
      name: name ?? this.name,
      description: description ?? this.description,
      cost: cost ?? this.cost,
      type: type ?? this.type,
      mineral: mineral ?? this.mineral,
      attack: attack ?? this.attack,
      ignoreDefense: ignoreDefense ?? this.ignoreDefense,
      hp: hp ?? this.hp,
      currentHP: currentHP ?? this.currentHP,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import '../models/card_model.dart';
import '../models/enemy_model.dart';
import '../enums/game_enums.dart';
import '../services/sound_service.dart';

class GameProvider extends ChangeNotifier {
  GameState _gameState = GameState.playing;
  int _currentRound = 1;
  int _currentMana = 2;
  int _playerHP = 100;
  int _upgrade = 0;
  
  List<CardModel> _deck = [];
  List<CardModel> _hand = [];
  List<CardModel> _shopCards = [];
  List<CardModel> _discardPile = [];
  List<CardModel> _fieldUnits = [];
  
  List<EnemyModel> _enemies = [];
  bool _isRoundActive = false;
  Timer? _roundTimer;
  int _remainingTime = 30;
  
  GameState get gameState => _gameState;
  int get currentRound => _currentRound;
  int get currentMana => _currentMana;
  int get playerHP => _playerHP;
  int get upgrade => _upgrade;
  List<CardModel> get deck => List.unmodifiable(_deck);
  List<CardModel> get hand => List.unmodifiable(_hand);
  List<CardModel> get shopCards => List.unmodifiable(_shopCards);
  List<CardModel> get fieldUnits => List.unmodifiable(_fieldUnits);
  List<EnemyModel> get enemies => List.unmodifiable(_enemies);
  bool get isRoundActive => _isRoundActive;
  int get remainingTime => _remainingTime;
  bool get isBossRound => _currentRound % 5 == 0;
  
  GameProvider() {
    _initializeGame();
  }
  
  void _initializeGame() {
    _initializeDeck();
    _initializeShop();
    _drawHand();
    notifyListeners();
  }
  
  void _initializeDeck() {
    _deck.clear();
    
    // 기본 7종 카드로 시작 덱 구성
    for (int i = 0; i < 2; i++) {
      _deck.add(CardModel.scvCard());
      _deck.add(CardModel.marineCard());
    }
    
    _deck.add(CardModel.droneCard());
    _deck.add(CardModel.probeCard());
    
    _deck.shuffle();
  }
  
  void _initializeShop() {
    _shopCards.clear();
    
    // 기본 7종 카드 상시 판매
    _shopCards.addAll([
      CardModel.scvCard(),
      CardModel.marineCard(),
      CardModel.droneCard(),
      CardModel.hydraliskCard(),
      CardModel.probeCard(),
      CardModel.dragoonCard(),
      CardModel.redundantCard(),
    ]);
    
    // 근본 모드 카드들 추가 (위키 정확한 31종)
    final random = Random();
    final advancedCards = [
      CardModel.supplyDepotCard(),
      CardModel.balloonCard(),
      CardModel.industrialComplexCard(),
      CardModel.seriousGamerVultureCard(),
      CardModel.honeyPigCard(),
      CardModel.jarOfDesireCard(),
      CardModel.invisibleManCard(),
      CardModel.breadShuttleCard(),
      CardModel.chlorellaPoolCard(),
      CardModel.droneVendingMachineCard(),
      CardModel.riceMillCard(),
      CardModel.nuclearSniperCard(),
      CardModel.turretOperatorCard(),
      CardModel.hadoukenMasterCard(),
      CardModel.uglyQueenCard(),
      CardModel.snanDaBarnCard(),
      CardModel.kingCrabGuardianCard(),
      CardModel.chompDoctorCard(),
      CardModel.moisturizingAcademyCard(),
      CardModel.ranRanRuCard(),
      CardModel.neoAssassinRobotCard(),
      CardModel.magicHomeShoppingCard(),
      CardModel.vtuberCard(),
      CardModel.threeCard(),
      CardModel.earlyZerglingCard(),
      CardModel.imposterCard(),
      CardModel.luckyCatCard(),
      CardModel.battlecruiserCard(),
      CardModel.knifeZealotCard(),
      CardModel.siberianSnowmanCard(),
      CardModel.randomBoxCard(),
    ];
    
    // 특수 효과 카드들
    final effectCards = [
      CardModel.effectCard("드로우", "카드 1장을 추가로 뽑습니다", 2),
      CardModel.effectCard("마나 부스트", "마나 +1을 얻습니다", 3),
      CardModel.magicCard("치유", "HP를 10 회복합니다", 2),
      CardModel.magicCard("공업 강화", "공업 +1", 4),
    ];
    
    // 근본 모드 카드들 무작위 추가
    for (int i = 0; i < 8; i++) {
      _shopCards.add(advancedCards[random.nextInt(advancedCards.length)]);
    }
    
    // 효과 카드들 무작위 추가
    for (int i = 0; i < 4; i++) {
      _shopCards.add(effectCards[random.nextInt(effectCards.length)]);
    }
  }
  
  void _drawHand() {
    _hand.clear();
    
    while (_hand.length < 5) {
      if (_deck.isEmpty) {
        if (_discardPile.isEmpty) break;
        _deck.addAll(_discardPile);
        _discardPile.clear();
        _deck.shuffle();
      }
      
      if (_deck.isNotEmpty) {
        _hand.add(_deck.removeAt(0));
      }
    }
    
    if (_hand.isNotEmpty) {
      SoundService().playCardDraw();
    }
  }
  
  void playCard(CardModel card) {
    if (!_hand.contains(card)) return;
    
    _hand.remove(card);
    
    switch (card.type) {
      case CardType.resource:
        _discardPile.add(card);
        break;
        
      case CardType.unit:
        _fieldUnits.add(card);
        break;
        
      case CardType.effect:
        _applyCardEffect(card);
        _discardPile.add(card);
        break;
        
      case CardType.magic:
        break;
    }
    
    notifyListeners();
  }
  
  void _applyCardEffect(CardModel card) {
    switch (card.name) {
      case "드로우":
        if (_deck.isEmpty && _discardPile.isNotEmpty) {
          _deck.addAll(_discardPile);
          _discardPile.clear();
          _deck.shuffle();
        }
        if (_deck.isNotEmpty && _hand.length < 32) {
          _hand.add(_deck.removeAt(0));
        }
        break;
        
      case "마나 부스트":
        _currentMana += 1;
        break;
    }
  }
  
  void useMagicCard(CardModel card) {
    if (!_hand.contains(card) || card.type != CardType.magic) return;
    
    _hand.remove(card);
    
    switch (card.name) {
      case "치유":
        _playerHP = (_playerHP + 10).clamp(0, 100);
        break;
        
      case "공업 강화":
        _upgrade++;
        break;
    }
    
    notifyListeners();
  }
  
  void buyCard(CardModel card) {
    if (_currentMana < 1 || !_shopCards.contains(card)) return;
    
    _currentMana--;
    
    if (!_isBasicCard(card)) {
      _shopCards.remove(card);
    }
    
    _discardPile.add(card.copyWith());
    notifyListeners();
  }
  
  bool _isBasicCard(CardModel card) {
    return card.name == "SCV" || 
           card.name == "마린" ||
           card.name == "드론" ||
           card.name == "히드라리스크" ||
           card.name == "프로브" ||
           card.name == "드라군" ||
           card.name == "잉여";
  }
  
  void startRound() {
    if (_isRoundActive) return;
    
    _isRoundActive = true;
    _remainingTime = _currentRound == 30 ? 45 : 30;
    
    _spawnEnemies();
    _startBattle();
    
    _roundTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _remainingTime--;
      _processBattle();
      
      if (_remainingTime <= 0 || _enemies.isEmpty || _fieldUnits.where((u) => !u.isDead).isEmpty) {
        _endRound();
      }
      
      notifyListeners();
    });
    
    notifyListeners();
  }
  
  void _startBattle() {
    
  }
  
  void _processBattle() {
    if (_enemies.isEmpty || _fieldUnits.where((u) => !u.isDead).isEmpty) return;
    
    final aliveUnits = _fieldUnits.where((u) => !u.isDead).toList();
    final random = Random();
    
    for (final unit in aliveUnits) {
      if (_enemies.isEmpty) break;
      
      final targetEnemy = _enemies[random.nextInt(_enemies.length)];
      final damage = unit.attack + (_upgrade * unit.attack * 0.2).round();
      final actualDamage = (damage - targetEnemy.defense).clamp(0, damage);
      
      if (actualDamage > 0) {
        targetEnemy.takeDamage(actualDamage);
        SoundService().playEnemyHit();
      }
      
      if (targetEnemy.isDead) {
        _enemies.remove(targetEnemy);
        SoundService().playEnemyDeath();
      }
    }
    
    for (final enemy in _enemies.toList()) {
      if (aliveUnits.isEmpty) break;
      
      final targetUnit = aliveUnits[random.nextInt(aliveUnits.length)];
      final damage = 1 + (_currentRound ~/ 10);
      
      targetUnit.takeDamage(damage);
      
      if (targetUnit.isDead) {
        SoundService().playEnemyHit();
      }
    }
  }
  
  void _spawnEnemies() {
    _enemies.clear();
    
    final random = Random();
    final enemyCount = 3 + (_currentRound ~/ 5);
    
    for (int i = 0; i < enemyCount; i++) {
      final enemyType = EnemyType.values[random.nextInt(EnemyType.values.length)];
      _enemies.add(EnemyModel.create(enemyType, _currentRound));
    }
  }
  
  void _attackEnemies(int damage) {
    SoundService().playAttack();
    
    for (final enemy in _enemies.toList()) {
      if (damage <= 0) break;
      
      final actualDamage = (damage - enemy.defense).clamp(0, damage);
      enemy.takeDamage(actualDamage);
      
      if (actualDamage > 0) {
        SoundService().playEnemyHit();
      }
      
      if (enemy.isDead) {
        _enemies.remove(enemy);
        SoundService().playEnemyDeath();
      }
      
      damage -= actualDamage;
    }
  }
  
  void _endRound() {
    _roundTimer?.cancel();
    _isRoundActive = false;
    
    final remainingEnemies = _enemies.length;
    if (remainingEnemies > 0) {
      _playerHP -= remainingEnemies * 2;
      
      if (_playerHP <= 0 || remainingEnemies >= 51) {
        _gameState = GameState.gameOver;
        SoundService().playGameOver();
        notifyListeners();
        return;
      }
    }
    
    _enemies.clear();
    _discardPile.addAll(_fieldUnits);
    _fieldUnits.clear();
    _currentRound++;
    
    if (_currentRound > 30) {
      _gameState = GameState.victory;
      SoundService().playVictory();
      notifyListeners();
      return;
    }
    
    SoundService().playRoundEnd();
    _nextTurn();
  }
  
  void _nextTurn() {
    _discardPile.addAll(_hand);
    _hand.clear();
    
    _currentMana = 2;
    
    _drawHand();
    
    notifyListeners();
  }
  
  void resetGame() {
    _roundTimer?.cancel();
    
    _gameState = GameState.playing;
    _currentRound = 1;
    _currentMana = 2;
    _playerHP = 100;
    _upgrade = 0;
    
    _deck.clear();
    _hand.clear();
    _shopCards.clear();
    _discardPile.clear();
    _fieldUnits.clear();
    _enemies.clear();
    
    _isRoundActive = false;
    _remainingTime = 30;
    
    _initializeGame();
  }
  
  @override
  void dispose() {
    _roundTimer?.cancel();
    super.dispose();
  }
}
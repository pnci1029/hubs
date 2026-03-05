import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/game_provider.dart';
import '../widgets/arena_battle_field.dart';
import '../widgets/shop_area.dart';
import '../widgets/hand_area.dart';
import '../widgets/status_bar.dart';
import '../widgets/game_over_dialog.dart';
import '../enums/game_enums.dart';
import '../theme/premium_theme.dart';
import 'test_card_screen.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const TestCardScreen(),
            ),
          );
        },
        backgroundColor: PremiumTheme.primaryNeon,
        child: const Icon(Icons.palette, color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: PremiumTheme.heroGradient,
        ),
        child: SafeArea(
        child: Consumer<GameProvider>(
          builder: (context, gameProvider, child) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (gameProvider.gameState != GameState.playing) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => GameOverDialog(
                    isVictory: gameProvider.gameState == GameState.victory,
                    onRestart: () {
                      Navigator.of(context).pop();
                      gameProvider.resetGame();
                    },
                  ),
                );
              }
            });
            
            return const Column(
              children: [
                StatusBar(),
                
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ShopArea(),
                      ),
                      
                      Expanded(
                        flex: 3,
                        child: ArenaBattleField(),
                      ),
                    ],
                  ),
                ),
                
                HandArea(),
              ],
            );
          },
        ),
        ),
      ),
    );
  }
}
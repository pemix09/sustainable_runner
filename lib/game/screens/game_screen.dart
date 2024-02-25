import 'package:endless_runner/game/dialogs/game_lost_dialog.dart';
import 'package:endless_runner/game/dialogs/game_pause_dialog.dart';
import 'package:endless_runner/game/dialogs/game_win_dialog.dart';
import 'package:endless_runner/game/sustainable_runner_game.dart';

import '../../audio/audio_controller.dart';
import '../../level_selection/levels.dart';
import '../../player_progress/player_progress.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:provider/provider.dart';

/// This widget defines the properties of the game screen.
///
/// It mostly sets up the overlays (widgets shown on top of the Flame game) and
/// the gets the [AudioController] from the context and passes it in to the
/// [EndlessRunner] class so that it can play audio.
class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  static const String healthBar = 'health-bar';
  static const String pauseButton = 'pause_buttton';
  static const String winDialogKey = 'win-dialog-key';
  static const String lostDialogKey = 'lost-dialog-key';
  static const String pauseDialogKey = 'pause-dialog-key';

  @override
  Widget build(BuildContext context) {
    final audioController = context.read<AudioController>();
    return Container(
      color: Colors.black,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          body: GameWidget<SustainableRunner>(
            key: const Key('play session'),
            game: SustainableRunner(),
            overlayBuilderMap: {
              pauseButton: (context, game) {
                return Positioned(
                  left: 10,
                  top: 10,
                  child: IconButton(
                    onPressed: () {
                      game.overlays.add(pauseDialogKey);
                      game.paused ? game.resumeEngine() : game.pauseEngine();
                    },
                    icon: Icon(
                      game.paused ? Icons.start : Icons.pause,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                );
              },
              healthBar: (context, game) {
                var playerHealth =
                    game.componentManager?.playerManager?.player?.health;

                if (playerHealth != null) {
                  var healthIcons = <Widget>[];
                  for (int i = 0; i < playerHealth; i++) {
                    healthIcons.add(Icon(
                      Icons.heart_broken_rounded,
                      color: Colors.red,
                    ));
                  }
                  return Positioned(
                    right: 10,
                    top: 10,
                    child: Row(
                      children: healthIcons,
                    ),
                  );
                }
                return const Text('Problem loading health');
              },
              winDialogKey: (BuildContext context, SustainableRunner game) {
                return GameWinDialog();
              },
              lostDialogKey: (BuildContext context, SustainableRunner game) {
                return GameLostDialog();
              },
              pauseDialogKey: (BuildContext context, SustainableRunner game) {
                return GamePauseDialog(
                  onResume: () {
                    game.overlays.remove(pauseDialogKey);
                    game.resumeEngine();
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

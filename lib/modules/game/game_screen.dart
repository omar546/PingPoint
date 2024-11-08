import 'package:flutter/material.dart';
import 'package:ping_pong/shared/styles/colors.dart';
import 'package:vibration/vibration.dart';
import '../../network/local/cache_helper.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int score1 = 0;
  int score2 = 0;
  int serveCount1 = 0;
  int serveCount2 = 0;
  bool isServeRed = true; // Indicates if the red player is serving

  @override
  void initState() {
    super.initState();
    _loadGame(); // Load scores and serve counts when the screen is initialized
  }

  // Load scores and serve counts from SharedPreferences
  Future<void> _loadGame() async {
    setState(() {
      score1 = CacheHelper.getData(key: 'score1') ?? 0;
      score2 = CacheHelper.getData(key: 'score2') ?? 0;
      serveCount1 = CacheHelper.getData(key: 'serveCount1') ?? 0;
      serveCount2 = CacheHelper.getData(key: 'serveCount2') ?? 0;
      isServeRed = CacheHelper.getData(key: 'isServeRed') ?? true;
    });
  }

  // Save scores and serve counts to SharedPreferences
  Future<void> _saveGame() async {
    await CacheHelper.saveData(key: 'score1', value: score1);
    await CacheHelper.saveData(key: 'score2', value: score2);
    await CacheHelper.saveData(key: 'serveCount1', value: serveCount1);
    await CacheHelper.saveData(key: 'serveCount2', value: serveCount2);
    await CacheHelper.saveData(key: 'isServeRed', value: isServeRed);
  }

  // Reset the game
  void _resetGame() {
    setState(() {
      score1 = 0;
      score2 = 0;
      serveCount1 = 0;
      serveCount2 = 0;
      isServeRed = true;
    });
    _saveGame(); // Save the game state after resetting
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Left half of the screen (Red player)
            Expanded(
              child: GestureDetector(
                onLongPress: () {
                  _undoScore(true); // Undo for Red player
                },
                onTap: () {
                  _incrementScore(true); // Increment score for Red player
                },
                child: Container(
                  color: isServeRed ? MyColors.orangeColor : MyColors.whiteColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('$serveCount1/5',
                          style: const TextStyle(color: MyColors.blackColor, fontSize: 20)),
                      const SizedBox(height: 10),
                      Text('$score1',
                          style: const TextStyle(
                              color: MyColors.blackColor,
                              fontSize: 100,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
            // Right half of the screen (Blue player)
            Expanded(
              child: GestureDetector(
                onLongPress: () {
                  _undoScore(false); // Undo for Blue player
                },
                onTap: () {
                  _incrementScore(false); // Increment score for Blue player
                },
                child: Container(
                  color: !isServeRed ? MyColors.blueColor : MyColors.whiteColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('$serveCount2/5',
                          style: const TextStyle(color: MyColors.blackColor, fontSize: 20)),
                      const SizedBox(height: 10),
                      Text('$score2',
                          style: const TextStyle(
                              color: MyColors.blackColor,
                              fontSize: 100,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: 'reset',
        heroTag: 'mini',
        mini: true, // Set this to true to make the button smaller
        onPressed: _resetGame,
        child: const Icon(Icons.network_ping_rounded),
      ),
    );
  }

  // Increment score for the specified player
  void _incrementScore(bool isRedPlayer) {
    setState(() {
      if (isRedPlayer) {
        score1++;
      } else {
        score2++;
      }
      _handleServeCount();
      _checkWinner();
      _saveGame();
      Vibration.vibrate(duration: 100);
    });
  }

  // Undo score for the specified player
  void _undoScore(bool isRedPlayer) {
    setState(() {
      if (isRedPlayer && score1 > 0) {
        score1--;
      } else if (!isRedPlayer && score2 > 0) {
        score2--;
      }

      if (isServeRed) {
        if (serveCount1 > 0) {
          serveCount1--;
        }
      } else {
        if (serveCount2 > 0) {
          serveCount2--;
        }
      }

      // Check if we need to toggle the server back if serve count reaches 0
      if ((isServeRed && serveCount1 == 0) || (!isServeRed && serveCount2 == 0)) {
        isServeRed = !isServeRed;
      }

      _saveGame();
      Vibration.vibrate(duration: 100);
    });
  }

  // Increment serve count and handle serving player switch
  void _handleServeCount() {
    setState(() {
      if (isServeRed) {
        serveCount1++;
      } else {
        serveCount2++;
      }

      // Change turn if serve count reaches 5
      if ((isServeRed && serveCount1 == 5) || (!isServeRed && serveCount2 == 5)) {
        isServeRed = !isServeRed;
        serveCount1 = 0;
        serveCount2 = 0;
      }
    });
  }

  // Check for the winner and show a pop-up
  void _checkWinner() {
    if (score1 >= 21) {
      _showWinnerDialog('RED');
    } else if (score2 >= 21) {
      _showWinnerDialog('BLUE');
    } else if (score1 == 0 && score2 == 7) {
      _showWinnerDialog('BLUE');
    } else if (score2 == 0 && score1 == 7) {
      _showWinnerDialog('RED');
    } else if ((score1 - score2) == 10 || (score2 - score1) == 10) {
      if (score1 > score2) {
        _showWinnerDialog('RED');
      } else if (score1 < score2) {
        _showWinnerDialog('BLUE');
      }
    } else if (score1 == 1 && score2 == 9) {
      _showWinnerDialog('BLUE');
    } else if (score2 == 1 && score1 == 9) {
      _showWinnerDialog('RED');
    }
  }

  // Show a pop-up with the winner
  void _showWinnerDialog(String winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          title: const Text('Game Over'),
          content: Text('$winner wins!'),
          actions: [
            TextButton(
              onPressed: () {
                _resetGame();
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }
}

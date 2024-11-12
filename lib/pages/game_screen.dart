import 'package:flutter/material.dart';
import 'dart:async';
import 'package:loop_line/logic/logic.dart';
import 'package:confetti/confetti.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  List<List<int>> board = List.generate(4, (_) => List.generate(4, (_) => 0));
  List<List<double>> rotationAngles =
      List.generate(4, (_) => List.generate(4, (_) => 0.0));
  int currentPlayer = 1;
  bool gameWon = false;
  bool isRotating = false;

  Logic logic = Logic();
  late ConfettiController _confettiController;

  Timer? _timer;
  int _remainingTime = 15;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 5));

    startTimer();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void placeBall(int i, int j) async {
    if (board[i][j] == 0 && !gameWon && !isRotating) {
      setState(() {
        board[i][j] = currentPlayer;
      });

      // Check for win right after placing the ball
      if (logic.checkWinningCondition(board, currentPlayer)) {
        setState(() {
          gameWon = true;
          _timer?.cancel(); // Stop the timer when the game is over
          showWinMessage(currentPlayer);
        });
        return; // Exit if the game is won, no need to rotate
      }

      // Start the timer again for the next move
      _timer?.cancel();
      startTimer();

      // Delay and rotate if no one has won
      await Future.delayed(const Duration(milliseconds: 300));
      setState(() => isRotating = true);
      await showRotatingOverlay();

      rotateBoard();

      setState(() {
        isRotating = false;
        currentPlayer = currentPlayer == 1 ? 2 : 1;
      });
    }
  }

  Future<void> showRotatingOverlay() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  void rotateBoard() {
    setState(() {
      board = logic.rotateAnticlockwise(board);
      for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
          rotationAngles[i][j] = (rotationAngles[i][j] + 90) % 360;
        }
      }
    });
  }

  void showWinMessage(int player) {
    String playerColor = player == 1 ? "RED" : "BLUE";
    _confettiController.play();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text(
          "Game Over",
          style: TextStyle(
            fontFamily: "SourGummy",
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          "$playerColor WINS!!!",
          style: TextStyle(
            color: player == 1 ? Colors.red : Colors.blue,
            fontFamily: "SourGummy",
            fontWeight: FontWeight.w600,
            fontSize: 45,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetGame();
            },
            child: const Text(
              "Play Again",
              style: TextStyle(
                fontFamily: "SourGummy",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    setState(() {
      board = List.generate(4, (_) => List.generate(4, (_) => 0));
      currentPlayer = 1;
      gameWon = false;
    });
    startTimer();
  }

  void startTimer() {
    _remainingTime = 10;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        rotateBoard();
        setState(() {
          currentPlayer = currentPlayer == 1 ? 2 : 1;
          _remainingTime = 10;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "LoopLine",
          style: TextStyle(
            fontFamily: "SourGummy",
            fontWeight: FontWeight.w600,
            fontSize: 35,
          ),
        ),
        backgroundColor: Colors.blueGrey[100],
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    '${currentPlayer == 1 ? 'RED' : 'BLUE'}, Your Turn',
                    style: TextStyle(
                      fontFamily: "SourGummy",
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                      color: currentPlayer == 1 ? Colors.red : Colors.blue,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    'Time Left: $_remainingTime',
                    style: const TextStyle(
                      fontFamily: "SourGummy",
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = constraints.maxWidth > 600 ? 5 : 4;
                    return SizedBox(
                      width: constraints.maxWidth * 0.9,
                      height: constraints.maxWidth * 0.9,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                        ),
                        itemCount: 16,
                        itemBuilder: (context, index) {
                          int i = index ~/ crossAxisCount;
                          int j = index % crossAxisCount;
                          return GestureDetector(
                            onTap: () => placeBall(i, j),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.2),
                                    width: 1),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[300],
                              ),
                              child: Center(
                                child: board[i][j] == 0
                                    ? null
                                    : RotationTransition(
                                        turns: AlwaysStoppedAnimation(
                                            rotationAngles[i][j] / (2 * 3.14)),
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: board[i][j] == 1
                                              ? Colors.red
                                              : Colors.blue,
                                        ),
                                      ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          if (isRotating)
            const Center(
              child: CircularProgressIndicator(),
            ),
          if (gameWon)
            ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 100,
              gravity: 0.5,
            ),
        ],
      ),
    );
  }
}

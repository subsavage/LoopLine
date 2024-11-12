import 'package:flutter/material.dart';
import 'dart:async';
import 'package:loop_line/logic.dart'; // Import the Logic class.

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  List<List<int>> board = List.generate(4, (_) => List.generate(4, (_) => 0));
  int currentPlayer = 1;
  bool gameWon = false;
  bool isRotating = false;

  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  Logic logic = Logic();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _rotationAnimation =
        Tween<double>(begin: 0.0, end: -3.14 / 2).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void placeBall(int i, int j) async {
    if (board[i][j] == 0 && !gameWon && !isRotating) {
      setState(() {
        board[i][j] = currentPlayer;
      });

      await Future.delayed(const Duration(milliseconds: 300));

      setState(() => isRotating = true);
      await showRotatingOverlay();

      rotateBoard();

      setState(() {
        isRotating = false;
        if (logic.checkWinningCondition(board, currentPlayer)) {
          gameWon = true;
          showWinMessage(currentPlayer);
        } else {
          currentPlayer = currentPlayer == 1 ? 2 : 1;
        }
      });
    }
  }

  Future<void> showRotatingOverlay() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  void rotateBoard() {
    setState(() {
      board = logic.rotateAnticlockwise(board);
    });
  }

  bool isBoardFull() {
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (board[i][j] == 0) {
          return false;
        }
      }
    }
    return true;
  }

  void showWinMessage(int player) {
    String playerColor = player == 1 ? "RED" : "BLUE";
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Game Over"),
        content: Text(
          "$playerColor WINS!!!",
          style: TextStyle(
            color: player == 1 ? Colors.red : Colors.blue,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetGame();
            },
            child: const Text("Play Again"),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LoopLine")),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center vertically
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.width * 0.9,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                    ),
                    itemCount: 16,
                    itemBuilder: (context, index) {
                      int i = index ~/ 4;
                      int j = index % 4;
                      return GestureDetector(
                        onTap: () => placeBall(i, j),
                        child: Container(
                          color: Colors.grey[300],
                          child: Center(
                            child: board[i][j] == 0
                                ? null
                                : board[i][j] == 1
                                    ? const CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.red,
                                      )
                                    : const CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.blue,
                                      ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Rotating overlay
          if (isRotating)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}

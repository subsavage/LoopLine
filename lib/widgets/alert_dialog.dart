// import 'package:flutter/material.dart';

// class PopUp extends StatelessWidget {
//   const PopUp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text("Game Over"),
//       content: Text(
//         "$playerColor WINS!!!",
//         style: TextStyle(
//           color: player == 1 ? Colors.red : Colors.blue,
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//             resetGame();
//           },
//           child: const Text("Play Again"),
//         ),
//       ],
//     );
//   }
// }

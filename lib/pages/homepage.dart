import 'package:flutter/material.dart';
import 'package:loop_line/music/music.dart'; // Assuming AudioController is here
import 'package:loop_line/pages/game_screen.dart';
import 'package:loop_line/pages/help.dart';

class HomePage extends StatefulWidget {
  final AudioController audioController;

  const HomePage({super.key, required this.audioController});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isMusicPlaying = true; // Keeps track of music state

  @override
  void initState() {
    super.initState();
    // Start the music when the homepage loads
    widget.audioController.startMusic();
  }

  @override
  void dispose() {
    // Stop the music when navigating away from homepage
    widget.audioController.fadeOutMusic();
    super.dispose();
  }

  void toggleMusic() {
    setState(() {
      isMusicPlaying = !isMusicPlaying;
      if (isMusicPlaying) {
        widget.audioController.startMusic();
      } else {
        widget.audioController.stopMusic();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "LoopLine",
                style: TextStyle(
                  fontFamily: "SourGummy",
                  fontWeight: FontWeight.w600,
                  fontSize: 50,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScreen(),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[80],
                ),
                child: const Text(
                  "Play Game",
                  style: TextStyle(
                    fontFamily: "SourGummy",
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HelpPage(),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[80],
                ),
                child: const Text(
                  "Help",
                  style: TextStyle(
                    fontFamily: "SourGummy",
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Music : ",
                    style: TextStyle(
                      fontFamily: "SourGummy",
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isMusicPlaying ? Icons.volume_up : Icons.volume_off,
                      size: 24,
                    ),
                    onPressed: toggleMusic,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

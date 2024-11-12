import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[100],
        centerTitle: true,
        title: const Text(
          "Instructions",
          style: TextStyle(
            fontFamily: "SourGummy",
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.blueGrey[100],
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CarouselSlider(
                  carouselController: _controller,
                  options: CarouselOptions(
                    height: 200,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    autoPlay: false,
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items: [
                    Image.asset("assets/images/instruction_1.png", scale: 1.8),
                    Image.asset("assets/images/instruction_2.png", scale: 1.8),
                    Image.asset("assets/images/instruction_3.png", scale: 1.8),
                  ],
                ),

                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            _currentIndex == index ? Colors.blue : Colors.grey,
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 20),
                const Text(
                  "The balls move counterclockwise after every move.",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "SourGummy",
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // Title for Winning Conditions
                const Text(
                  "Winning Conditions",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: "SourGummy",
                  ),
                ),
                const SizedBox(height: 10),

                CarouselSlider(
                  carouselController: _controller,
                  options: CarouselOptions(
                    height: 200,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    autoPlay: false,
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items: [
                    Image.asset("assets/images/instruction_4.png", scale: 1.8),
                    Image.asset("assets/images/instruction_5.png", scale: 1.8),
                    Image.asset("assets/images/instruction_6.png", scale: 1.8),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            _currentIndex == index ? Colors.blue : Colors.grey,
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 20),
                const Text(
                  "Four balls aligned either horizontally/vertically/diagonally",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "SourGummy",
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

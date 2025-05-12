import 'package:flutter/material.dart';
import 'dart:math';
import 'package:klaklouk_app/components/custom_snackbar.dart';
import 'package:klaklouk_app/components/custom_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int balance = 20000;
  Map<String, int> bets = {};
  List<String> animals = ['kla', 'klok', 'morn', 'bongkong', 'kdam', 'trey'];
  List<String> selectedImages = [];
  bool hasBet = false;
  bool isResultVisible = false;
  int totalCurrentBet = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    for (var animal in animals) {
      bets[animal] = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animateBowl() {
    if (!hasBet) return;

    _controller.forward(from: 0.0);
    _randomizeImages();
    _calculateResult();
    setState(() {
      isResultVisible = true;
      hasBet = false;
    });
  }

  void _randomizeImages() {
    final random = Random();
    selectedImages = List.generate(3, (_) => animals[random.nextInt(animals.length)]);
  }

  void _calculateResult() {
    int win = 0;

    for (var entry in bets.entries) {
      int betAmount = entry.value;
      if (betAmount > 0) {
        int matchCount = selectedImages.where((img) => img == entry.key).length;
        if (matchCount > 0) {
          win += matchCount * betAmount;
          balance += betAmount; // Return original bet amount
        }
      }
    }

    balance += win; // Add winnings

    // Clear bets after result
    bets.updateAll((key, value) => 0);
    totalCurrentBet = 0;
  }


  void _placeBet(String animal) {
    if (!isResultVisible && balance >= 1000) {
      bets[animal] = (bets[animal] ?? 0) + 1000;
      balance -= 1000;
      totalCurrentBet += 1000;
      hasBet = true;
      setState(() {});
    }
  }

  void _resetGame() {
    setState(() {
      selectedImages.clear();
      isResultVisible = false;
      hasBet = false;
    });
    CustomSnackbar(
      context: context,
      message: 'The game was reset',
      icon: Icons.check_circle_outline,
      backgroundColor: Colors.green,
      duration: Duration(seconds: 4),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('splash_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Top bar with money and buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(12),
                          backgroundColor: Colors.amber,
                        ),
                        child: const Icon(Icons.home, color: Colors.white),
                      ),
                      Text(
                        '$balance ៛',
                        style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          CustomDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(12),
                          backgroundColor: Colors.amber,
                        ),
                        child: const Icon(Icons.shopping_cart, color: Colors.white),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Animal grid
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    children: animals.map((animal) {
                      bool isSelected = selectedImages.contains(animal);
                      return GestureDetector(
                        onTap: () => _placeBet(animal),
                        child: Opacity(
                          opacity: selectedImages.isEmpty ? 1.0 : (isSelected ? 1.0 : 0.3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('$animal.jpg', width: 80, height: 80),
                              Text('${bets[animal]} ៛', style: const TextStyle(fontSize: 14, color: Colors.white)),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                // Show result images
                if (isResultVisible)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: selectedImages.map((animal) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.asset('$animal.jpg', width: 40, height: 40),
                      );
                    }).toList(),
                  ),

                // Bowl animation
                ScaleTransition(
                  scale: Tween(begin: 1.0, end: 1.2).animate(
                    CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
                  ),
                  child: Image.asset('bowl.png', width: 100, height: 100),
                ),

                const SizedBox(height: 20),

                // Button for shuffle or reset
                ElevatedButton(
                  onPressed: () {
                    if (isResultVisible) {
                      _resetGame();
                    } else {
                      _animateBowl();
                    }
                  },
                  child: Text(isResultVisible ? 'ក្រឡុកម្តងទៀត' : 'ក្រឡុក'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

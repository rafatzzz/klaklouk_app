import 'package:flutter/material.dart';
import 'Mainpage/home_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) :super(key: key);


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'splash_background.png',
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'klaklouk_logo.png',
                  width: 150,
                  height: 155,
                ),
                const SizedBox(height: 10),


                ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.amberAccent),

                      ),
                    ),
                  ),
                  child: const Text(
                    'ចូលលេងឥឡូវនេះ',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20),
                          backgroundColor: Colors.amber,
                        ),
                        child: const Icon(Icons.settings, color: Colors.white),
                      ),
                      const SizedBox(width: 8), // small spacing
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20),
                          backgroundColor: Colors.amber,
                        ),
                        child: const Icon(Icons.share, color: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20),
                          backgroundColor: Colors.amber,
                        ),
                        child: const Icon(Icons.star, color: Colors.white),
                      ),
                    ],
                  ),
                )


              ],
            ),
          )
        ],
      ),
    );
  }
}
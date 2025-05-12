import 'package:flutter/material.dart';
import 'Mainpage/home_screen.dart';
import 'start_screen.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({Key? key}) : super(key: key);
  
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  @override
  void initState() {
    super.initState();
    // after sec , navigate to homepage 
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const StartScreen())
      );
    });
  }



  @override
  Widget build(BuildContext context) {
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
                // const Text(
                //   'ខ្លាឃ្លោក ខ្មែរ',
                //   style: TextStyle(
                //     fontFamily: 'KhmerOSMoul.ttf',
                //     fontSize: 32,
                //     color: Colors.white,
                //   ),
                // )
              ],
            ),
          )
        ],
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Image.asset(
        //       'klaklouk_logo.png',
        //       width: 150,
        //       height: 155,
        //     ),
        //     const SizedBox(height: 10),
        //     Text(
        //       'ខ្លាឃ្លោក ខ្មែរ',
        //       style: TextStyle(
        //         fontFamily: 'KhmerOSMoul',
        //         color: Colors.white,
        //
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}


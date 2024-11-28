import 'package:flutter/material.dart';
import 'package:seniguard/check_list.dart';

void main() {
  runApp(const Page_Goodjob());
}

// Generated by: https://www.figma.com/community/plugin/842128343887142055/
class Page_Goodjob extends StatelessWidget {
  const Page_Goodjob({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: const Scaffold(
        body: ResponsiveContainer(),
      ),
    );
  }
}

class ResponsiveContainer extends StatelessWidget {
  const ResponsiveContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    // 3초 후에 다음 페이지로 이동
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Page_CheckList()),
      );
    });

    return Container(
      width: screenSize.width,
      height: screenSize.height,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Stack(
        children: [
          // 텍스트
          Positioned(
            top: screenSize.height * 0.2,
            left: screenSize.width * 0.1,
            right: screenSize.width * 0.1,
            child: Text(
              '잘했어요!\n오늘도 더 건강해지셨네요!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: screenSize.width * 0.05,
                fontFamily: 'Hana2.0 L',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          // 이미지
          Positioned(
            top: screenSize.height * 0.35,
            left: screenSize.width * 0.05,
            right: screenSize.width * 0.05,
            child: Container(
              width: screenSize.width * 0.9,
              height: screenSize.height * 0.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/good_hand.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
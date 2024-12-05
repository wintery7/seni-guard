import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:seniguard/sample_screen.dart';

void main() {
  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsFlutterBinding.ensureInitialized();

  // Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: '6adea7b512e4a581e9d7ab7d6c26a2a6',
  );

  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: SingleChildScrollView( // 화면을 스크롤할 수 있도록 적용
          child: StartApp(),
        ),
      ),
    );
  }
}

class StartApp extends StatefulWidget {
  @override
  _StartAppState createState() => _StartAppState();
}

class _StartAppState extends State<StartApp> {
  @override
  void initState() {
    super.initState();
    // 3초 뒤에 sample_screen.dart로 이동
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FigmaToCode_1()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          width: screenWidth,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.15, // 화면 너비의 15%
            vertical: screenHeight * 0.45, // 화면 높이의 45%
          ),
          decoration: const BoxDecoration(color: Color(0xFF53B175)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // '시니가드' 텍스트
              SizedBox(
                width: screenWidth * 0.5, // 화면 너비의 50%
                child: Text(
                  '시니가드',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.105, // 화면 너비의 10%
                    fontFamily: 'Freesentation',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // '당신의 건강 지킴이' 텍스트
              SizedBox(
                width: screenWidth * 0.5, // 화면 너비의 50%
                child: Text(
                  '당신의 건강 지킴이',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.04, // 화면 너비의 4%
                    fontFamily: 'Freesentation',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
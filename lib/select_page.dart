import 'package:flutter/material.dart';
import 'package:seniguard/chat_bot.dart';
// import 'package:seniguard/chat.dart';
import 'dart:async';

void main() {
  runApp(const FigmaToCode_2());
}

class FigmaToCode_2 extends StatelessWidget {
  const FigmaToCode_2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(
          children: [
            SelectPage(),
          ],
        ),
      ),
    );
  }
}

class SelectPage extends StatelessWidget {
  final ValueNotifier<String> _currentTimeNotifier =
      ValueNotifier<String>(_getCurrentTime());

  TimeDisplayWidget() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      _currentTimeNotifier.value = _getCurrentTime(); // 시간 갱신
    });
  }

  // 현재 시간을 시:분 형식으로 반환하는 함수
  static String _getCurrentTime() {
    final DateTime now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // 폰트 크기를 화면 너비에 따라 조정
    final baseFontSize = screenWidth * 0.05;

    return Column(
      children: [
        Container(
          width: screenWidth,
          height: screenHeight,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: screenWidth,
                  height: screenHeight * 0.04,
                  decoration: BoxDecoration(color: Color(0xFF53B175)),
                ),
              ),
              Positioned(
                left: screenWidth * 0.067,
                top: screenHeight * 0.072,
                child: SizedBox(
                  width: screenWidth * 0.48,
                  child: Text(
                    '오늘 하루는 어떠신가요 ?',
                    style: TextStyle(
                      color: Color(0xFF3F414E),
                      fontSize: baseFontSize * 0.8, // 폰트 크기 조정
                      fontFamily: 'Freesentation',
                      fontWeight: FontWeight.w400,
                      height: 0.02,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: screenWidth * 0.067,
                top: screenHeight * 0.105,
                child: Text(
                  'can choose what you want to do:',
                  style: TextStyle(
                    color: Color(0xFFA1A4B2),
                    fontSize: baseFontSize * 0.6, // 폰트 크기 조정
                    fontFamily: 'Freesentation',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),

              // 실시간 시계
              Positioned(
                left: screenWidth * 0.79,
                top: screenHeight * 0.062,
                child: ValueListenableBuilder<String>(
                  valueListenable: _currentTimeNotifier,
                  builder: (context, currentTime, child) {
                    return SizedBox(
                      width: screenWidth * 0.158,
                      child: Text(
                        currentTime, // 실시간으로 업데이트되는 시간 표시
                        style: TextStyle(
                          color: Color(0xFF3F414E),
                          fontSize: baseFontSize * 1.15, // 폰트 크기 조정
                          fontFamily: 'Freesentation',
                          fontWeight: FontWeight.w400,
                          height: 0.02,
                        ),
                      ),
                    );
                  },
                ),
              ),
              // 실시간 시계

              // 백그라운드 이미지
              Positioned(
                left: 0, // 화면에 맞게 위치 설정
                top: screenHeight * 0.45, // 상단 여백을 계산하여 위치 설정
                child: Container(
                  width: screenWidth, // 화면 너비에 맞게 설정
                  height: screenHeight * 0.5, // 화면 높이에 맞게 설정
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/select_page_back_image.png"),
                      fit: BoxFit.fitWidth, // 이미지를 화면에 맞게 커버
                    ),
                  ),
                ),
              ),
              // 백그라운드 이미지

              // Positioned(
              //   left: -screenWidth * 0.066,
              //   top: screenHeight * 0.81,
              //   child: Container(
              //     width: screenWidth * 1.11,
              //     height: screenHeight * 0.28,
              //     child: Stack(
              //       children: [
              //         Positioned(
              //           left: 0,
              //           top: screenHeight * 0.053,
              //           child: Container(
              //             width: screenWidth * 0.295,
              //             height: screenHeight * 0.226,
              //             child: Stack(
              //               children: [
              //                 Positioned(
              //                   left: 0,
              //                   top: screenHeight * 0.091,
              //                   child: Container(
              //                     width: screenWidth * 0.295,
              //                     height: screenHeight * 0.136,
              //                     child: Stack(),
              //                   ),
              //                 ),
              //                 Positioned(
              //                   left: screenWidth * 0.039,
              //                   top: screenHeight * 0.129,
              //                   child: Container(
              //                     width: screenWidth * 0.105,
              //                     height: screenHeight * 0.049,
              //                     child: FlutterLogo(),
              //                   ),
              //                 ),
              //                 Positioned(
              //                   left: screenWidth * 0.159,
              //                   top: screenHeight * 0.113,
              //                   child: Container(
              //                     width: screenWidth * 0.086,
              //                     height: screenHeight * 0.039,
              //                     child: FlutterLogo(),
              //                   ),
              //                 ),
              //                 Positioned(
              //                   left: screenWidth * 0.029,
              //                   top: -screenHeight * 0.004,
              //                   child: Container(
              //                     width: screenWidth * 0.236,
              //                     height: screenHeight * 0.108,
              //                     child: Stack(
              //                       children: [
              //                         Positioned(
              //                           left: -screenWidth * 0.006,
              //                           top: -screenHeight * 0.001,
              //                           child: Container(
              //                             width: screenWidth * 0.249,
              //                             height: screenHeight * 0.109,
              //                             child: Stack(
              //                               children: [
              //                                 Positioned(
              //                                   left: screenWidth * 0.085,
              //                                   top: screenHeight * 0.001,
              //                                   child: Container(
              //                                     width: screenWidth * 0.079,
              //                                     height: screenHeight * 0.108,
              //                                     child: FlutterLogo(),
              //                                   ),
              //                                 ),
              //                                 Positioned(
              //                                   left: screenWidth * 0.002,
              //                                   top: screenHeight * 0.054,
              //                                   child: Transform(
              //                                     transform: Matrix4.identity()
              //                                       ..translate(0.0, 0.0)
              //                                       ..rotateZ(-1.19),
              //                                     child: Container(
              //                                       width: screenWidth * 0.066,
              //                                       height: screenHeight * 0.129,
              //                                       child: FlutterLogo(),
              //                                     ),
              //                                   ),
              //                                 ),
              //                                 Positioned(
              //                                   left: screenWidth * 0.087,
              //                                   top: screenHeight * 0.109,
              //                                   child: Transform(
              //                                     transform: Matrix4.identity()
              //                                       ..translate(0.0, 0.0)
              //                                       ..rotateZ(-2.60),
              //                                     child: Container(
              //                                       width: screenWidth * 0.074,
              //                                       height: screenHeight * 0.117,
              //                                       child: FlutterLogo(),
              //                                     ),
              //                                   ),
              //                                 ),
              //                                 Positioned(
              //                                   left: screenWidth * 0.227,
              //                                   top: screenHeight * 0.088,
              //                                   child: Transform(
              //                                     transform: Matrix4.identity()
              //                                       ..translate(0.0, 0.0)
              //                                       ..rotateZ(2.60),
              //                                     child: Container(
              //                                       width: screenWidth * 0.074,
              //                                       height: screenHeight * 0.117,
              //                                       child: FlutterLogo(),
              //                                     ),
              //                                   ),
              //                                 ),
              //                                 Positioned(
              //                                   left: screenWidth * 0.224,
              //                                   top: screenHeight * 0.019,
              //                                   child: Transform(
              //                                     transform: Matrix4.identity()
              //                                       ..translate(0.0, 0.0)
              //                                       ..rotateZ(1.19),
              //                                     child: Container(
              //                                       width: screenWidth * 0.066,
              //                                       height: screenHeight * 0.129,
              //                                       child: FlutterLogo(),
              //                                     ),
              //                                   ),
              //                                 ),
              //                               ],
              //                             ),
              //                           ),
              //                         ),
              //                         Positioned(
              //                           left: screenWidth * 0.054,
              //                           top: -screenHeight * 0.005,
              //                           child: Transform(
              //                             transform: Matrix4.identity()
              //                               ..translate(0.0, 0.0)
              //                               ..rotateZ(0.27),
              //                             child: Container(
              //                               width: screenWidth * 0.201,
              //                               height: screenHeight * 0.096,
              //                               child: FlutterLogo(),
              //                             ),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //         Positioned(
              //           left: screenWidth * 0.219,
              //           top: 0,
              //           child: Container(
              //             width: screenWidth * 0.295,
              //             height: screenHeight * 0.226,
              //             child: Stack(
              //               children: [
              //                 Positioned(
              //                   left: 0,
              //                   top: screenHeight * 0.091,
              //                   child: Container(
              //                     width: screenWidth * 0.295,
              //                     height: screenHeight * 0.136,
              //                     child: Stack(),
              //                   ),
              //                 ),
              //                 Positioned(
              //                   left: screenWidth * 0.13,
              //                   top: screenHeight * 0.113,
              //                   child: Transform(
              //                     transform: Matrix4.identity()
              //                       ..translate(0.0, 0.0)
              //                       ..rotateZ(2.70),
              //                     child: Container(
              //                       width: screenWidth * 0.134,
              //                       height: screenHeight * 0.068,
              //                       child: Stack(
              //                         children: [
              //                           Positioned(
              //                             left: screenWidth * 0.021,
              //                             top: 0,
              //                             child: Container(
              //                               width: screenWidth * 0.091,
              //                               height: screenHeight * 0.029,
              //                               child: Stack(
              //                                 children: [
              //                                   Positioned(
              //                                     left: screenWidth * 0.003,
              //                                     top: screenHeight * 0.005,
              //                                     child: Container(
              //                                       width: screenWidth * 0.006,
              //                                       height: screenHeight * 0.003,
              //                                       decoration: ShapeDecoration(
              //                                         color: Color(0xFFFB5D66),
              //                                         shape: OvalBorder(),
              //                                       ),
              //                                     ),
              //                                   ),
              //                                   Positioned(
              //                                     left: screenWidth * 0.021,
              //                                     top: screenHeight * 0.008,
              //                                     child: Container(
              //                                       width: screenWidth * 0.006,
              //                                       height: screenHeight * 0.003,
              //                                       decoration: ShapeDecoration(
              //                                         color: Color(0xFFFB5D66),
              //                                         shape: OvalBorder(),
              //                                       ),
              //                                     ),
              //                                   ),
              //                                   Positioned(
              //                                     left: screenWidth * 0.035,
              //                                     top: screenHeight * 0.011,
              //                                     child: Container(
              //                                       width: screenWidth * 0.006,
              //                                       height: screenHeight * 0.003,
              //                                       decoration: ShapeDecoration(
              //                                         color: Color(0xFFFB5D66),
              //                                         shape: OvalBorder(),
              //                                       ),
              //                                     ),
              //                                   ),
              //                                   Positioned(
              //                                     left: screenWidth * 0.083,
              //                                     top: screenHeight * 0.018,
              //                                     child: Container(
              //                                       width: screenWidth * 0.006,
              //                                       height: screenHeight * 0.003,
              //                                       decoration: ShapeDecoration(
              //                                         color: Color(0xFFFB5D66),
              //                                         shape: OvalBorder(),
              //                                       ),
              //                                     ),
              //                                   ),
              //                                   Positioned(
              //                                     left: screenWidth * 0.085,
              //                                     top: screenHeight * 0.022,
              //                                     child: Container(
              //                                       width: screenWidth * 0.006,
              //                                       height: screenHeight * 0.003,
              //                                       decoration: ShapeDecoration(
              //                                         color: Color(0xFFFB5D66),
              //                                         shape: OvalBorder(),
              //                                       ),
              //                                     ),
              //                                   ),
              //                                   Positioned(
              //                                     left: screenWidth * 0.014,
              //                                     top: screenHeight * 0.021,
              //                                     child: Container(
              //                                       width: screenWidth * 0.006,
              //                                       height: screenHeight * 0.003,
              //                                       decoration: ShapeDecoration(
              //                                         color: Color(0xFFFB5D66),
              //                                         shape: OvalBorder(),
              //                                       ),
              //                                     ),
              //                                   ),
              //                                   Positioned(
              //                                     left: screenWidth * 0.015,
              //                                     top: screenHeight * 0.026,
              //                                     child: Container(
              //                                       width: screenWidth * 0.006,
              //                                       height: screenHeight * 0.003,
              //                                       decoration: ShapeDecoration(
              //                                         color: Color(0xFFFB5D66),
              //                                         shape: OvalBorder(),
              //                                       ),
              //                                     ),
              //                                   ),
              //                                   Positioned(
              //                                     left: 0,
              //                                     top: screenHeight * 0.008,
              //                                     child: Container(
              //                                       width: screenWidth * 0.007,
              //                                       height: screenHeight * 0.003,
              //                                       decoration: ShapeDecoration(
              //                                         color: Color(0xFFFB5D66),
              //                                         shape: OvalBorder(),
              //                                       ),
              //                                     ),
              //                                   ),
              //                                   Positioned(
              //                                     left: screenWidth * 0.073,
              //                                     top: 0,
              //                                     child: Container(
              //                                       width: screenWidth * 0.006,
              //                                       height: screenHeight * 0.003,
              //                                       decoration: ShapeDecoration(
              //                                         color: Color(0xFFFB5D66),
              //                                         shape: OvalBorder(),
              //                                       ),
              //                                     ),
              //                                   ),
              //                                   Positioned(
              //                                     left: screenWidth * 0.083,
              //                                     top: screenHeight * 0.001,
              //                                     child: Container(
              //                                       width: screenWidth * 0.006,
              //                                       height: screenHeight * 0.003,
              //                                       decoration: ShapeDecoration(
              //                                         color: Color(0xFFFB5D66),
              //                                         shape: OvalBorder(),
              //                                       ),
              //                                     ),
              //                                   ),
              //                                 ],
              //                               ),
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //                 Positioned(
              //                   left: screenWidth * 0.029,
              //                   top: 0,
              //                   child: Container(
              //                     width: screenWidth * 0.236,
              //                     height: screenHeight * 0.108,
              //                     child: Stack(
              //                       children: [
              //                         Positioned(
              //                           left: 0,
              //                           top: 0,
              //                           child: Container(
              //                             width: screenWidth * 0.236,
              //                             height: screenHeight * 0.108,
              //                             child: FlutterLogo(),
              //                           ),
              //                         ),
              //                         Positioned(
              //                           left: 0,
              //                           top: 0,
              //                           child: Container(
              //                             width: screenWidth * 0.236,
              //                             height: screenHeight * 0.108,
              //                             child: FlutterLogo(),
              //                           ),
              //                         ),
              //                         Positioned(
              //                           left: 0,
              //                           top: 0,
              //                           child: Container(
              //                             width: screenWidth * 0.236,
              //                             height: screenHeight * 0.108,
              //                             child: FlutterLogo(),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //                 Positioned(
              //                   left: 0,
              //                   top: screenHeight * 0.115,
              //                   child: Transform(
              //                     transform: Matrix4.identity()
              //                       ..translate(0.0, 0.0)
              //                       ..rotateZ(-0.44),
              //                     child: Container(
              //                       width: screenWidth * 0.074,
              //                       height: screenHeight * 0.037,
              //                       child: Stack(
              //                         children: [
              //                           Positioned(
              //                             left: 0,
              //                             top: 0,
              //                             child: Container(
              //                               width: screenWidth * 0.074,
              //                               height: screenHeight * 0.037,
              //                               child: FlutterLogo(),
              //                             ),
              //                           ),
              //                           Positioned(
              //                             left: 0,
              //                             top: 0,
              //                             child: Container(
              //                               width: screenWidth * 0.074,
              //                               height: screenHeight * 0.037,
              //                               child: FlutterLogo(),
              //                             ),
              //                           ),
              //                           Positioned(
              //                             left: 0,
              //                             top: 0,
              //                             child: Container(
              //                               width: screenWidth * 0.074,
              //                               height: screenHeight * 0.037,
              //                               child: FlutterLogo(),
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //                 Positioned(
              //                   left: screenWidth * 0.282,
              //                   top: screenHeight * 0.114,
              //                   child: Transform(
              //                     transform: Matrix4.identity()
              //                       ..translate(0.0, 0.0)
              //                       ..rotateZ(3.12),
              //                     child: Container(
              //                       width: screenWidth * 0.159,
              //                       height: screenHeight * 0.073,
              //                       child: FlutterLogo(),
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //         Positioned(
              //           left: screenWidth * 0.823,
              //           top: screenHeight * 0.010,
              //           child: Container(
              //             width: screenWidth * 0.295,
              //             height: screenHeight * 0.226,
              //             child: Stack(
              //               children: [
              //                 Positioned(
              //                   left: 0,
              //                   top: screenHeight * 0.091,
              //                   child: Container(
              //                     width: screenWidth * 0.295,
              //                     height: screenHeight * 0.136,
              //                     child: Stack(),
              //                   ),
              //                 ),
              //                 Positioned(
              //                   left: screenWidth * 0.093,
              //                   top: screenHeight * 0.133,
              //                   child: Container(
              //                     width: screenWidth * 0.201,
              //                     height: screenHeight * 0.092,
              //                     child: FlutterLogo(),
              //                   ),
              //                 ),
              //                 Positioned(
              //                   left: screenWidth * 0.029,
              //                   top: screenHeight * 0.165,
              //                   child: Transform(
              //                     transform: Matrix4.identity()
              //                       ..translate(0.0, 0.0)
              //                       ..rotateZ(0.29),
              //                     child: Container(
              //                       width: screenWidth * 0.231,
              //                       height: screenHeight * 0.110,
              //                       child: Stack(
              //                         children: [
              //                           Positioned(
              //                             left: 0,
              //                             top: 0,
              //                             child: Container(
              //                               width: screenWidth * 0.231,
              //                               height: screenHeight * 0.110,
              //                               child: FlutterLogo(),
              //                             ),
              //                           ),
              //                           Positioned(
              //                             left: 0,
              //                             top: 0,
              //                             child: Container(
              //                               width: screenWidth * 0.231,
              //                               height: screenHeight * 0.110,
              //                               child: FlutterLogo(),
              //                             ),
              //                           ),
              //                           Positioned(
              //                             left: 0,
              //                             top: 0,
              //                             child: Container(
              //                               width: screenWidth * 0.231,
              //                               height: screenHeight * 0.110,
              //                               child: FlutterLogo(),
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //                 Positioned(
              //                   left: screenWidth * 0.05,
              //                   top: screenHeight * 0.098,
              //                   child: Container(
              //                     width: screenWidth * 0.101,
              //                     height: screenHeight * 0.045,
              //                     child: FlutterLogo(),
              //                   ),
              //                 ),
              //                 Positioned(
              //                   left: screenWidth * 0.174,
              //                   top: screenHeight * 0.103,
              //                   child: Transform(
              //                     transform: Matrix4.identity()
              //                       ..translate(0.0, 0.0)
              //                       ..rotateZ(0.22),
              //                     child: Container(
              //                       width: screenWidth * 0.095,
              //                       height: screenHeight * 0.045,
              //                       child: FlutterLogo(),
              //                     ),
              //                   ),
              //                 ),
              //                 Positioned(
              //                   left: -screenWidth * 0.192,
              //                   top: screenHeight * 0.033,
              //                   child: Container(
              //                     width: screenWidth * 0.295,
              //                     height: screenHeight * 0.226,
              //                     child: Stack(
              //                       children: [
              //                         Positioned(
              //                           left: 0,
              //                           top: screenHeight * 0.091,
              //                           child: Container(
              //                             width: screenWidth * 0.295,
              //                             height: screenHeight * 0.136,
              //                             child: Stack(),
              //                           ),
              //                         ),
              //                         Positioned(
              //                           left: screenWidth * 0.076,
              //                           top: screenHeight * 0.113,
              //                           child: Container(
              //                             width: screenWidth * 0.073,
              //                             height: screenHeight * 0.034,
              //                             child: FlutterLogo(),
              //                           ),
              //                         ),
              //                         Positioned(
              //                           left: screenWidth * 0.171,
              //                           top: screenHeight * 0.101,
              //                           child: Transform(
              //                             transform: Matrix4.identity()
              //                               ..translate(0.0, 0.0)
              //                               ..rotateZ(0.22),
              //                             child: Container(
              //                               width: screenWidth * 0.228,
              //                               height: screenHeight * 0.107,
              //                               child: FlutterLogo(),
              //                             ),
              //                           ),
              //                         ),
              //                         Positioned(
              //                           left: screenWidth * 0.157,
              //                           top: screenHeight * 0.104,
              //                           child: Container(
              //                             width: screenWidth * 0.051,
              //                             height: screenHeight * 0.024,
              //                             child: FlutterLogo(),
              //                           ),
              //                         ),
              //                         Positioned(
              //                           left: screenWidth * 0.042,
              //                           top: 0,
              //                           child: Container(
              //                             width: screenWidth * 0.236,
              //                             height: screenHeight * 0.108,
              //                             child: Stack(
              //                               children: [
              //                                 Positioned(
              //                                   left: 0,
              //                                   top: 0,
              //                                   child: Container(
              //                                     width: screenWidth * 0.236,
              //                                     height: screenHeight * 0.108,
              //                                     child: FlutterLogo(),
              //                                   ),
              //                                 ),
              //                                 Positioned(
              //                                   left: 0,
              //                                   top: 0,
              //                                   child: Container(
              //                                     width: screenWidth * 0.236,
              //                                     height: screenHeight * 0.108,
              //                                     child: FlutterLogo(),
              //                                   ),
              //                                 ),
              //                                 Positioned(
              //                                   left: 0,
              //                                   top: 0,
              //                                   child: Container(
              //                                     width: screenWidth * 0.236,
              //                                     height: screenHeight * 0.108,
              //                                     child: FlutterLogo(),
              //                                   ),
              //                                 ),
              //                               ],
              //                             ),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //                 Positioned(
              //                   left: -screenWidth * 0.216,
              //                   top: screenHeight * 0.024,
              //                   child: Container(
              //                     width: screenWidth * 0.423,
              //                     height: screenHeight * 0.079,
              //                     child: Stack(
              //                       children: [
              //                         Positioned(
              //                           left: 0,
              //                           top: 0,
              //                           child: Container(
              //                             width: screenWidth * 0.423,
              //                             height: screenHeight * 0.079,
              //                             decoration: ShapeDecoration(
              //                               color: Color(0xFF9B9B9B),
              //                               shape: RoundedRectangleBorder(
              //                                 borderRadius:
              //                                     BorderRadius.circular(10),
              //                               ),
              //                             ),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              // 산책 이동 버튼
              Positioned(
                left: screenWidth * 0.068,
                top: screenHeight * 0.492,
                child: Container(
                  width: screenWidth * 0.423,
                  height: screenHeight * 0.316,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: screenWidth * 0.423,
                          height: screenHeight * 0.316,
                          decoration: ShapeDecoration(
                            color: Color(0xFFEFCEFE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.015, // 화면에 맞게 위치 설정
                        top: screenHeight * 0.01, // 상단 여백을 계산하여 위치 설정
                        right: screenWidth * 0.015,
                        bottom: screenHeight * 0.1,
                        child: Container(
                          width: screenWidth,
                          height: screenHeight,
                          decoration: ShapeDecoration(
                            color: Color.fromARGB(255, 247, 246, 245),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.005, // 화면에 맞게 위치 설정
                        top: screenHeight * 0.01, // 상단 여백을 계산하여 위치 설정
                        right: screenWidth * 0.005,
                        bottom: screenHeight * 0.1,
                        child: Container(
                          width: screenWidth, // 화면 너비에 맞게 설정
                          height: screenHeight * 0.2, // 화면 높이에 맞게 설정
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/warking_button.png"),
                              fit: BoxFit.fitHeight, // 이미지를 화면에 맞게 커버
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.101,
                        top: screenHeight * 0.233,
                        child: SizedBox(
                          width: screenWidth * 0.225,
                          height: screenHeight * 0.048,
                          child: Text(
                            '산책 하기',
                            style: TextStyle(
                              color: Color(0xFFFDF9F3),
                              fontSize: baseFontSize * 1.0, // 폰트 크기 조정
                              fontFamily: 'Freesentation',
                              fontWeight: FontWeight.w600,
                              height: 0.01,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // 산책 이동 버튼

              // 챗봇 이동 버튼
              Positioned(
                left: screenWidth * 0.069,
                top: screenHeight * 0.138,
                child: GestureDetector(
                  onTap: () {
                    // 네비게이션 동작
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FigmaToCode_3()),
                    );
                  },
                  child: Container(
                    width: screenWidth * 0.423,
                    height: screenHeight * 0.316,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: screenWidth * 0.423,
                            height: screenHeight * 0.316,
                            decoration: ShapeDecoration(
                              color: Color(0xFFF05D48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: screenWidth * 0.015, // 화면에 맞게 위치 설정
                          top: screenHeight * 0.01, // 상단 여백을 계산하여 위치 설정
                          right: screenWidth * 0.015,
                          bottom: screenHeight * 0.1,
                          child: Container(
                            width: screenWidth,
                            height: screenHeight,
                            decoration: ShapeDecoration(
                              color: Color.fromARGB(255, 247, 246, 245),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: screenWidth * 0.005, // 화면에 맞게 위치 설정
                          top: screenHeight * 0.01, // 상단 여백을 계산하여 위치 설정
                          right: screenWidth * 0.005,
                          bottom: screenHeight * 0.1,
                          child: Container(
                            width: screenWidth, // 화면 너비에 맞게 설정
                            height: screenHeight * 0.2, // 화면 높이에 맞게 설정
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("images/chatbot_button.png"),
                                fit: BoxFit.fitHeight, // 이미지를 화면에 맞게 커버
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: screenWidth * 0.099,
                          top: screenHeight * 0.235,
                          child: SizedBox(
                            width: screenWidth * 0.227,
                            height: screenHeight * 0.048,
                            child: Text(
                              '시니 대화',
                              style: TextStyle(
                                color: Color(0xFFFDF9F3),
                                fontSize: baseFontSize * 1.0, // 폰트 크기 조정
                                fontFamily: 'Freesentation',
                                fontWeight: FontWeight.w600,
                                height: 0.01,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // 챗봇 이동 버튼

              // 체크리스트
              Positioned(
                left: screenWidth * 0.54,
                top: screenHeight * 0.138,
                child: Container(
                  width: screenWidth * 0.423,
                  height: screenHeight * 0.316,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: screenWidth * 0.423,
                          height: screenHeight * 0.316,
                          decoration: ShapeDecoration(
                            color: Color(0xFFF9CF88),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.015, // 화면에 맞게 위치 설정
                        top: screenHeight * 0.01, // 상단 여백을 계산하여 위치 설정
                        right: screenWidth * 0.015,
                        bottom: screenHeight * 0.1,
                        child: Container(
                          width: screenWidth,
                          height: screenHeight,
                          decoration: ShapeDecoration(
                            color: Color.fromARGB(255, 232, 203, 173),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.005, // 화면에 맞게 위치 설정
                        top: screenHeight * 0.01, // 상단 여백을 계산하여 위치 설정
                        right: screenWidth * 0.005,
                        bottom: screenHeight * 0.1,
                        child: Container(
                          width: screenWidth, // 화면 너비에 맞게 설정
                          height: screenHeight * 0.2, // 화면 높이에 맞게 설정
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/checklist_button.png"),
                              fit: BoxFit.fitHeight, // 이미지를 화면에 맞게 커버
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.088,
                        top: screenHeight * 0.235,
                        child: SizedBox(
                          width: screenWidth * 0.261,
                          height: screenHeight * 0.048,
                          child: Text(
                            '체크리스트',
                            style: TextStyle(
                              color: Color(0xFFFDF9F3),
                              fontSize: baseFontSize * 1.0, // 폰트 크기 조정
                              fontFamily: 'Freesentation',
                              fontWeight: FontWeight.w600,
                              height: 0.01,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // 체크리스트

              // 알람
              Positioned(
                left: screenWidth * 0.54,
                top: screenHeight * 0.492,
                child: Container(
                  width: screenWidth * 0.423,
                  height: screenHeight * 0.316,
                  decoration: ShapeDecoration(
                    color: Color(0xFFF9CF88),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              // 알람

              // Positioned(
              //   left: screenWidth * 0.545,
              //   top: screenHeight * 0.138,
              //   child: Container(
              //     width: screenWidth * 0.415,
              //     height: screenHeight * 0.212,
              //     clipBehavior: Clip.antiAlias,
              //     decoration: BoxDecoration(),
              //     child: Stack(),
              //   ),
              // ),
              // Positioned(
              //   left: screenWidth * 0.069,
              //   top: screenHeight * 0.524,
              //   child: Container(
              //     width: screenWidth * 0.419,
              //     height: screenHeight * 0.186,
              //     clipBehavior: Clip.antiAlias,
              //     decoration: BoxDecoration(),
              //     child: Stack(),
              //   ),
              // ),
              // Positioned(
              //   left: screenWidth * 0.054,
              //   top: screenHeight * 0.165,
              //   child: Container(
              //     width: screenWidth * 0.417,
              //     height: screenHeight * 0.200,
              //     child: Row(
              //       mainAxisSize: MainAxisSize.min,
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Container(
              //           width: screenWidth * 0.458,
              //           height: screenHeight * 0.138,
              //           clipBehavior: Clip.antiAlias,
              //           decoration: BoxDecoration(),
              //           child: Stack(
              //             children: [
              //               Positioned(
              //                 left: 0,
              //                 top: 0,
              //                 child: Container(
              //                   width: screenWidth * 0.458,
              //                   height: screenHeight * 0.138,
              //                   child: Stack(
              //                     children: [
              //                       Positioned(
              //                         left: 0,
              //                         top: 0,
              //                         child: Container(
              //                           width: screenWidth * 0.458,
              //                           height: screenHeight * 0.138,
              //                           child: Stack(),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

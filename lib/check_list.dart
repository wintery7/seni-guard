import 'package:flutter/material.dart';
import 'package:seniguard/add_check_list.dart';
import 'package:seniguard/list_check.dart';
import 'package:seniguard/select_page.dart';

void main() {
  runApp(const Page_CheckList());
}

class Page_CheckList extends StatelessWidget {
  const Page_CheckList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back), // 뒤로가기 아이콘
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FigmaToCode_2(), // 원하는 화면으로 이동
                ),
              );
            },
          ),
          title: const Text('오늘의 할일'),
          centerTitle: true, // 텍스트 중앙 정렬
          backgroundColor: const Color(0xFF53B175),
        ),
        body: ListView(
          children: [
            CheckList(),
          ],
        ),
      ),
    );
  }
}

// 체크리스트 블럭
class CheckListBlock extends StatelessWidget {
  final String time;
  final String task;
  final Color iconColor;
  final IconData icon;

  const CheckListBlock({
    super.key,
    required this.time,
    required this.task,
    required this.iconColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final double baseWidth = 1080;
    final double baseHeight = 1920;

    final Size screenSize = MediaQuery.of(context).size;
    final double scaleWidth = screenSize.width / baseWidth;
    final double scaleHeight = screenSize.height / baseHeight;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16 * scaleHeight),
      child: Container(
        width: 1000 * scaleWidth,
        height: 300 * scaleHeight,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Stack(
          children: [
            // 시간 텍스트
            Positioned(
              left: 60 * scaleWidth,
              top: 80 * scaleHeight,
              child: Text(
                time,
                style: TextStyle(
                  color: const Color(0xFF3F414E),
                  fontSize: 60 * scaleWidth,
                  fontFamily: 'Freesentation',
                  fontWeight: FontWeight.w400,
                  height: 0.02,
                ),
              ),
            ),
            // 작업 텍스트
            Positioned(
              left: 60 * scaleWidth,
              top: 180 * scaleHeight,
              child: Text(
                task,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 60 * scaleWidth,
                  fontFamily: 'Freesentation',
                  fontWeight: FontWeight.w400,
                  height: 0.02,
                ),
              ),
            ),
            // 체크 아이콘
            Positioned(
              right: 60 * scaleWidth,
              top: 62.5 * scaleHeight,
              child: Container(
                width: 175 * scaleWidth,
                height: 175 * scaleHeight,
                decoration: ShapeDecoration(
                  color: iconColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(705.88),
                  ),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 100 * scaleWidth,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 기본 디자인 크기
    final double baseWidth = 1080;
    final double baseHeight = 1920;

    // 현재 화면 크기
    final Size screenSize = MediaQuery.of(context).size;

    // 스케일 팩터 계산
    final double scaleWidth = screenSize.width / baseWidth;
    final double scaleHeight = screenSize.height / baseHeight;

    return Column(
      children: [
        Container(
          width: baseWidth * scaleWidth,
          height: baseHeight * scaleHeight,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              // 체크리스트 추가 버튼
              Positioned(
                left: 40 * scaleWidth,
                top: 98 * scaleHeight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Page_Add_List(), // 이동할 페이지 지정
                      ),
                    );
                  },
                  child: Container(
                    width: 1000 * scaleWidth,
                    height: 180 * scaleHeight,
                    decoration: ShapeDecoration(
                      color: Color(0xFFD9D9D9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 100 * scaleWidth,
                      ),
                    ),
                  ),
                ),
              ),

              // 첫 번째 체크바
              Positioned(
                left: 50 * scaleWidth,
                right: 50 * scaleWidth,
                top: 350 * scaleHeight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Page_List_Check(), // 이동할 화면
                      ),
                    );
                  },
                  child: const CheckListBlock(
                    time: '11:35',
                    task: '혈압약 복용',
                    iconColor: Colors.green,
                    icon: Icons.check,
                  ),
                ),
              ),
              // 첫 번째 체크바

              // 두 번째 체크바
              Positioned(
                left: 50 * scaleWidth,
                right: 50 * scaleWidth,
                top: 700 * scaleHeight,
                child: const CheckListBlock(
                  time: '11:35',
                  task: '혈압약 복용',
                  iconColor: Color(0xFFEA4335),
                  icon: Icons.close,
                ),
              ),
              // 두 번째 체크바

              // Positioned(
              //   left: 40 * scaleWidth,
              //   top: 730 * scaleHeight,
              //   child: Container(
              //     width: 1000 * scaleWidth,
              //     height: 300 * scaleHeight,
              //     decoration: ShapeDecoration(
              //       color: Colors.white,
              //       shape: RoundedRectangleBorder(
              //         side: BorderSide(
              //           width: 2,
              //           strokeAlign: BorderSide.strokeAlignCenter,
              //         ),
              //         borderRadius: BorderRadius.circular(30),
              //       ),
              //     ),
              //   ),
              // ),
              // Positioned(
              //   left: 490 * scaleWidth,
              //   top: 138 * scaleHeight,
              //   child: Container(
              //     width: 100 * scaleWidth,
              //     height: 100 * scaleHeight,
              //     child: Stack(),
              //   ),
              // ),
              // Positioned(
              //   left: 816 * scaleWidth,
              //   top: 780 * scaleHeight,
              //   child: Container(
              //     width: 200 * scaleWidth,
              //     height: 200 * scaleHeight,
              //     decoration: ShapeDecoration(
              //       color: Colors.white,
              //       shape: RoundedRectangleBorder(side: BorderSide(width: 1)),
              //     ),
              //   ),
              // ),
              // Positioned(
              //   left: 828 * scaleWidth,
              //   top: 793 * scaleHeight,
              //   child: Container(
              //     width: 175 * scaleWidth,
              //     height: 175 * scaleHeight,
              //     clipBehavior: Clip.antiAlias,
              //     decoration: ShapeDecoration(
              //       color: Color(0xFFEA4335),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(705.88),
              //       ),
              //     ),
              //     child: Stack(
              //       alignment: Alignment.center,
              //       children: [
              //         // 체크 아이콘
              //         Icon(
              //           Icons.close, // 체크 모양 아이콘
              //           color: Colors.white,
              //           size: 100 * scaleWidth, // 아이콘 크기 비율 조정
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // Positioned(
              //   left: 40 * scaleWidth,
              //   top: 1106 * scaleHeight,
              //   child: Container(
              //     width: 1000 * scaleWidth,
              //     height: 300 * scaleHeight,
              //     decoration: ShapeDecoration(
              //       color: Colors.white,
              //       shape: RoundedRectangleBorder(
              //         side: BorderSide(
              //           width: 2,
              //           strokeAlign: BorderSide.strokeAlignCenter,
              //         ),
              //         borderRadius: BorderRadius.circular(30),
              //       ),
              //     ),
              //   ),
              // ),
              // Positioned(
              //   left: 816 * scaleWidth,
              //   top: 1156 * scaleHeight,
              //   child: Container(
              //     width: 200 * scaleWidth,
              //     height: 200 * scaleHeight,
              //     decoration: ShapeDecoration(
              //       color: Colors.white,
              //       shape: RoundedRectangleBorder(side: BorderSide(width: 1)),
              //     ),
              //   ),
              // ),
              // Positioned(
              //   left: 828 * scaleWidth,
              //   top: 1169 * scaleHeight,
              //   child: Container(
              //     width: 175 * scaleWidth,
              //     height: 175 * scaleHeight,
              //     clipBehavior: Clip.antiAlias,
              //     decoration: ShapeDecoration(
              //       color: Color(0xFF9B9B9B),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(705.88),
              //       ),
              //     ),
              //     child: Stack(
              //       alignment: Alignment.center,
              //       children: [
              //         // 체크 아이콘
              //         Icon(
              //           Icons.remove, // 체크 모양 아이콘
              //           color: Colors.white,
              //           size: 100 * scaleWidth, // 아이콘 크기 비율 조정
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // Positioned(
              //   left: 1004 * scaleWidth,
              //   top: 12 * scaleHeight,
              //   child: Container(
              //     width: 50 * scaleWidth,
              //     height: 50 * scaleHeight,
              //     padding: const EdgeInsets.all(2),
              //     child: Row(
              //       mainAxisSize: MainAxisSize.min,
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Container(
              //           width: 20 * scaleWidth,
              //           height: 20 * scaleHeight,
              //           padding: const EdgeInsets.all(2),
              //           child: Column(
              //             mainAxisSize: MainAxisSize.min,
              //             mainAxisAlignment: MainAxisAlignment.start,
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [],
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

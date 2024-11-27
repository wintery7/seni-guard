import 'package:flutter/material.dart';
import 'package:seniguard/check_list.dart';
import 'package:seniguard/goodjob.dart';

void main() {
  runApp(const Page_List_Check());
}

class Page_List_Check extends StatelessWidget {
  const Page_List_Check({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(
          children: [
            const CheckToList(),
          ],
        ),
      ),
    );
  }
}

class CheckToList extends StatelessWidget {
  const CheckToList({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width,
      height: screenSize.height,
      decoration: const BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          // 질문 텍스트
          Positioned(
            top: screenSize.height * 0.2,
            left: screenSize.width * 0.1,
            right: screenSize.width * 0.1,
            child: Text(
              '오늘 아침에\n혈압약을 복용하셨나요?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: screenSize.width * 0.07, // 텍스트 크기 비율
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
          // 취소 버튼 (오른쪽에서 왼쪽으로 이동)
          Positioned(
            bottom: screenSize.height * 0.2,
            left: screenSize.width * 0.1,
            child: GestureDetector(
              onTap: () {
                // 버튼 클릭 시 새 화면으로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Page_CheckList(),
                  ),
                );
              },
              child: Container(
                width: screenSize.width * 0.35,
                height: screenSize.width * 0.35,
                child: Center(
                  child: Container(
                    width: screenSize.width * 0.3,
                    height: screenSize.width * 0.3,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFEA4335),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // 확인 버튼 (왼쪽에서 오른쪽으로 이동)
          Positioned(
            bottom: screenSize.height * 0.2,
            right: screenSize.width * 0.1, // 기존 left에서 right로 변경
            child: GestureDetector(
              onTap: () {
                // 버튼 클릭 시 새 화면으로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Page_Goodjob(),
                  ),
                );
              },
              child: Container(
                width: screenSize.width * 0.35,
                height: screenSize.width * 0.35,
                child: Center(
                  child: Container(
                    width: screenSize.width * 0.3,
                    height: screenSize.width * 0.3,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF53B175),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

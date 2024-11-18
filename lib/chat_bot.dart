import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:seniguard/seni_modal.dart';

void main() {
  runApp(const FigmaToCode_3());
}

class FigmaToCode_3 extends StatelessWidget {
  const FigmaToCode_3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(children: [
          ChatBotPage(),
        ]),
      ),
    );
  }
}

class ChatBotPage extends StatefulWidget {
  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  // TextField 컨트롤러 선언
  final TextEditingController _textController = TextEditingController();
  String _response = ''; // 서버 응답 저장 변수

  // 챗봇에 텍스트 요청 보내는 함수
  Future<void> _sendTextToChatBot(String text) async {
    print('챗봇에 요청 보내려 왔음');
    final url =
        Uri.parse('https://chatbot-iya6loaa4q-uc.a.run.app'); // 챗봇 서버 URL

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'message': text}), // 서버로 보낼 데이터
      );

      if (response.statusCode == 200) {
        // 서버 응답이 성공적일 경우
        final data = json.decode(response.body);
        print(_response); // Gemini Response 확인용
        setState(() {
          _response = data['response'] ?? '응답을 받을 수 없습니다.';
        });
      } else {
        setState(() {
          _response = '서버에 오류가 발생했습니다.';
        });
      }
    } catch (e) {
      setState(() {
        _response = '서버에 연결할 수 없습니다.';
      });
    }
  }

  // 모달 페이지 호출 및 반환된 텍스트 업데이트
  Future<void> _openSpeechModal() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ModalPage(), // 음성 인식 모달 페이지
        );
      },
    );

    // 모달에서 텍스트 반환 시 입력 필드 업데이트
    if (result != null && result is String) {
      setState(() {
        _textController.text = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double fontSizeLarge = width * 0.05;
    double fontSizeSmall = width * 0.03;

    return Column(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              // 하단 입력창 위치 설정
              Positioned(
                left: 0,
                top: height - 145,
                child: Container(
                  width: width,
                  height: 145,
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05, vertical: height * 0.02),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.03),
                  ),
                  child: Row(
                    children: [
                      // 음성 인식 모달 버튼
                      GestureDetector(
                        onTap: _openSpeechModal,
                        child: Container(
                          width: 95,
                          height: 95,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/kakao_login.png'),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 2, color: Color(0xFF53B175)),
                              borderRadius: BorderRadius.circular(11),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // 텍스트 입력 필드
                      Expanded(
                        child: Container(
                          height: 95,
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.05,
                              vertical: height * 0.01),
                          decoration: ShapeDecoration(
                            color: Color(0xFF1C293C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _textController,
                                  style: TextStyle(
                                    color: Color(0xFFEFF6FF),
                                    fontSize: fontSizeLarge,
                                  ),
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                    hintText: '하고 싶은 것을 입력해 주세요',
                                    hintStyle: TextStyle(
                                      color: Color(0xFF45566E),
                                      fontSize: fontSizeSmall,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              // 입력 버튼
                              GestureDetector(
                                onTap: () {
                                  // 입력 버튼 클릭 시 서버 요청 보내기
                                  if (_textController.text.isNotEmpty) {
                                    print('입력 버튼 눌렸음');
                                    _sendTextToChatBot(_textController.text);
                                  }
                                },
                                behavior: HitTestBehavior
                                    .translucent, // 터치가 다른 위젯을 통과하게 설정
                                child: Container(
                                  width: 90,
                                  height: 55,
                                  padding: EdgeInsets.all(6),
                                  child: Center(
                                    child: Text(
                                      '입력',
                                      style: TextStyle(
                                        color: Color(0xFFEFF6FF),
                                        fontSize: fontSizeLarge,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // 서버 응답 표시
              Positioned(
                bottom: height * 0.2,
                left: width * 0.05,
                child: Container(
                  width: width * 0.9,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFF1C293C),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _response,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSizeLarge,
                    ),
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

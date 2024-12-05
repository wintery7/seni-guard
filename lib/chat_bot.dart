import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:seniguard/select_page.dart';
import 'package:seniguard/seni_modal.dart';

void main() {
  runApp(const FigmaToCode_3());
}

class FigmaToCode_3 extends StatelessWidget {
  const FigmaToCode_3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const ChatBotPage(),
    );
  }
}

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, String>> _messages = []; // 채팅 메시지 리스트

  // 챗봇에 텍스트 요청 보내는 함수
  Future<void> _sendTextToChatBot(String text) async {
    setState(() {
      _messages.add({'sender': 'user', 'message': text});
    });

    final url = Uri.parse('https://chatbot-iya6loaa4q-du.a.run.app');
    
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'message': text
        }),
      );

      print('Request body: ${json.encode({'message': text})}');  // 요청 바디 출력
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _messages.add({
            'sender': 'bot',
            'message': data['response'] ?? '응답을 받을 수 없습니다.'
          });
        });
      } else {
        print('Error response: ${response.body}');
        setState(() {
          _messages.add({
            'sender': 'bot', 
            'message': '오류가 발생했습니다. (${response.statusCode})'
          });
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _messages.add({
          'sender': 'bot', 
          'message': '네트워크 오류가 발생했습니다.'
        });
      });
    }

    Future.delayed(Duration(milliseconds: 300), () {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  Future<void> _openSpeechModal() async {
    final result = await showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ModalPage(),
      ),
    );

    if (result != null && result is String) {
      setState(() {
        _textController.text = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white,), // 뒤로가기 아이콘
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FigmaToCode_2(), // 원하는 화면으로 변경
              ),
            );
          },
        ),
        title: const Text('시니', style: TextStyle(color: Colors.white),),
        centerTitle: true, // 텍스트 중앙 정렬
        backgroundColor: const Color(0xFF53B175),
      ),
      body: Column(
        children: [
          // 채팅 메시지 표시 영역
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['sender'] == 'user';

                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue : Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      message['message']!,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          _buildInputArea(width, height),
        ],
      ),
    );
  }

  Widget _buildInputArea(double width, double height) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: _openSpeechModal,
            child: Container(
              width: 50,
              height: 50,
              decoration: ShapeDecoration(
                image: const DecorationImage(
                  image: AssetImage('images/speak.png'),
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 2, color: Color(0xFF53B175)),
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 50, // 고정 높이 설정
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: ShapeDecoration(
                color: const Color(0xFF1C293C), // 배경색
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100), // 라운드 처리
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 텍스트 입력 영역
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      style: const TextStyle(
                        color: Colors.white, // 입력 텍스�� 색상
                        fontSize: 18,
                        fontFamily: 'Freesentation', // 원하는 폰트 설정
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: const InputDecoration(
                        hintText: '하고 싶은 것을 입력해 주세요',
                        hintStyle: TextStyle(
                          color: Color(0xFF45566E), // 힌트 텍스트 색상
                          fontSize: 18,
                        ),
                        border: InputBorder.none, // 기본 테두리 제거
                      ),
                    ),
                  ),
                  // 입력 버튼
                  GestureDetector(
                    onTap: () {
                      if (_textController.text.isNotEmpty) {
                        _sendTextToChatBot(_textController.text);
                        _textController.clear();
                      }
                    },
                    child: Container(
                      width: 90,
                      height: 55,
                      alignment: Alignment.center, // 텍스트 중앙 정렬
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50), // 라운드 처리
                        ),
                      ),
                      child: const Text(
                        '입력',
                        style: TextStyle(
                          color: Color(0xFFEFF6FF), // 버튼 텍스트 색상
                          fontSize: 18,
                          fontFamily: 'Freesentation', // 원하는 폰트 설정
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

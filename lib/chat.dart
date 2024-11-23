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
  String _response = '반가워요! 오늘도 건강한 하루 보내요!';
  final List<String> _requests = [];
  final List<String> _responses = [];

  @override
  void initState() {
    super.initState();
    // 초기 메시지를 요청과 응답 리스트에 추가
    _requests.add('챗봇 입장');
    _responses.add(_response);
  }

  Future<void> _sendTextToChatBot(String text) async {
    final url = Uri.parse('https://chatbot-iya6loaa4q-uc.a.run.app'); // 챗봇 서버 URL

    setState(() {
      _requests.add(text); // 요청 추가
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'message': text}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _response = data['response'] ?? '응답을 받을 수 없습니다.';
          _responses.add(_response);
        });
      } else {
        _handleError('서버에 오류가 발생했습니다.');
      }
    } catch (e) {
      _handleError('서버에 연결할 수 없습니다.');
    }
  }

  void _handleError(String errorMessage) {
    setState(() {
      _response = errorMessage;
      _responses.add(_response);
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
      body: Column(
        children: [
          // 상단 바
          Container(
            width: width,
            height: height * 0.04,
            color: const Color(0xFF53B175),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      '시니',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 채팅 내용 표시
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _requests.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildChatBubble(_requests[index], isRequest: true),
                    _buildChatBubble(_responses[index], isRequest: false),
                  ],
                );
              },
            ),
          ),
          // 하단 입력창
          _buildInputArea(width, height),
        ],
      ),
    );
  }

  Widget _buildChatBubble(String text, {required bool isRequest}) {
    return Align(
      alignment: isRequest ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isRequest ? Colors.grey.shade300 : const Color(0xFF53B175),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isRequest ? Colors.black : Colors.white,
            fontSize: 16,
          ),
        ),
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
              width: 95,
              height: 95,
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
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: '하고 싶은 것을 입력해 주세요',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                _sendTextToChatBot(_textController.text);
                _textController.clear();
              }
            },
            child: const Text('전송'),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: SpeechScreen(),
    );
  }
}

// Speech-to-Text 기능을 위한 SpeechToText 객체 생성
final SpeechToText _speechToText = SpeechToText();
bool isTyping = false;

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  final TextEditingController _textController = TextEditingController();

  // STT 관련 변수
  bool _speechEnabled = false; // 음성 인식 활성화 여부
  String _wordSpoken = " "; // 인식된 단어
  double _confidenceLevel = 0; // 인식 정확도

  @override
  void initState() {
    super.initState();
    // 초기화 함수 호출
    initSpeech();
  }

  // STT 초기화 함수
  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize(); // STT 초기화 및 활성화 여부 반환
    setState(() {});
  }

  // STT 리스닝 시작 함수
  void _startListening() async {
    if (!_speechEnabled) {
      bool initialized = await _speechToText.initialize(
        onStatus: (val) => print('onstatus : $val'), // 상태 변화 시 호출되는 콜백 함수
        onError: (val) => print('onError: $val '), // 에러 발생 시 호출되는 콜백 함수
      );
      if (initialized) {
        setState(() {
          _speechEnabled = true; // STT 활성화
        });
        _speechToText.listen(
            onResult: (val) => setState(() {
                  _wordSpoken = val.recognizedWords; // 인식된 단어 설정
                }));
      } else {
        setState(() {
          _speechEnabled = false; // STT 비활성화
          _speechToText.stop(); // STT 중지
        });
      }
    }
    // STT 리스닝 시작
    await _speechToText.listen(
      onResult: _onSpeechResulut, // 결과 반환 시 호출되는 함수
      listenFor: Duration(seconds: 5), // 리스닝 지속 시간
      localeId: 'ko-KR', // 한국어로 설정
    );
    setState(() {
      _confidenceLevel = 0; // 인식 정확도 초기화
      _speechEnabled = true; // STT 활성화
    });
  }

  // STT 리스닝 중지 함수
  void _stopListening() async {
    await _speechToText.stop(); // STT 중지
    setState(() {
      _speechEnabled = false; // STT 비활성화
    });
  }

  // STT 결과 처리 함수
  void _onSpeechResulut(SpeechRecognitionResult result) {
    setState(() {
      _wordSpoken = "${result.recognizedWords}"; // 인식된 단어 설정
      _confidenceLevel = result.confidence; // 인식 정확도 설정
      if (_confidenceLevel > 0.5) {
        // 정확도가 0.5보다 클 때
        _textController.text = _wordSpoken; // 텍스트 컨트롤러에 단어 설정
        isTyping = true; // 타이핑 중으로 설정
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("STT SAMPLE"),
        backgroundColor: Color(0xFF00005B),
      ),
      body: Container(
        color: Color(0xFFDEDEDE),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50.0),
                  border: Border.all(color: Colors.black),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          controller: _textController,
                          onTap: () {
                            setState(() {
                              isTyping = true;
                            });
                          },
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: "메세지를 입력해주세요",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        _speechToText.isListening ? Icons.mic : Icons.mic_none,
                        color: _speechEnabled ? Colors.blue : Colors.grey,
                      ),
                      onPressed: () async {
                        if (_speechToText.isListening) {
                          _stopListening();
                          setState(() {
                            isTyping = true; // 음성 인식이 끝나면 텍스트 입력 모드로 전환
                          });
                        } else {
                          _startListening();
                        }
                      },
                      tooltip: 'Listen',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
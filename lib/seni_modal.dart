import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ModalPage extends StatefulWidget {
  @override
  _ModalPageState createState() => _ModalPageState();
}

class _ModalPageState extends State<ModalPage> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();

    // 모달이 열리자마자 음성 인식 시작
    _startListening();
  }

  // 음성 인식 시작
  void _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        localeId: 'ko_KR',
        onResult: (result) {
          setState(() {
            _text = result.recognizedWords;
          });
        },
      );
    }
  }

  // 음성 인식 중지
  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  // 모달 종료 및 텍스트 반환
  void _closeModal() {
    Navigator.of(context).pop(_text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '음성 인식 중...',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            _text,
            style: TextStyle(fontSize: 16),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // 음성 인식을 중지하거나 시작하는 버튼은 이제 필요 없음
              ElevatedButton(
                onPressed: _stopListening,
                child: Text('중지'),
              ),
              ElevatedButton(
                onPressed: _closeModal,
                child: Text('완료'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
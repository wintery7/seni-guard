import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:seniguard/sample_screen.dart'; // Logger 패키지 추가
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:flutter_tts/flutter_tts.dart';



// void main() {

//   // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
//   WidgetsFlutterBinding.ensureInitialized();

//   // Flutter SDK 초기화
//   KakaoSdk.init(
//     nativeAppKey: '6adea7b512e4a581e9d7ab7d6c26a2a6',
//   );  runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const SampleScreen(),
//     );
//   }
// }


// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(),
//       home: SpeechScreen(),
//     );
//   }
// }

// // Speech-to-Text 기능을 위한 SpeechToText 객체 생성
// final SpeechToText _speechToText = SpeechToText();
// bool isTyping = false;

// class SpeechScreen extends StatefulWidget {
//   @override
//   _SpeechScreenState createState() => _SpeechScreenState();
// }

// class _SpeechScreenState extends State<SpeechScreen> {
//   final TextEditingController _textController = TextEditingController();

//   // STT 관련 변수
//   bool _speechEnabled = false; // 음성 인식 활성화 여부
//   String _wordSpoken = " "; // 인식된 단어
//   double _confidenceLevel = 0; // 인식 정확도

//   @override
//   void initState() {
//     super.initState();
//     // 초기화 함수 호출
//     initSpeech();
//   }

//   // STT 초기화 함수
//   void initSpeech() async {
//     _speechEnabled = await _speechToText.initialize(); // STT 초기화 및 활성화 여부 반환
//     setState(() {});
//   }

//   // STT 리스닝 시작 함수
//   void _startListening() async {
//     if (!_speechEnabled) {
//       bool initialized = await _speechToText.initialize(
//         onStatus: (val) => print('onstatus : $val'), // 상태 변화 시 호출되는 콜백 함수
//         onError: (val) => print('onError: $val '), // 에러 발생 시 호출되는 콜백 함수
//       );
//       if (initialized) {
//         setState(() {
//           _speechEnabled = true; // STT 활성화
//         });
//         _speechToText.listen(
//             onResult: (val) => setState(() {
//                   _wordSpoken = val.recognizedWords; // 인식된 단어 설정
//                 }));
//       } else {
//         setState(() {
//           _speechEnabled = false; // STT 비활성화
//           _speechToText.stop(); // STT 중지
//         });
//       }
//     }
//     // STT 리스닝 시작
//     await _speechToText.listen(
//       onResult: _onSpeechResulut, // 결과 반환 시 호출되는 함수
//       listenFor: Duration(seconds: 5), // 리스닝 지속 시간
//       localeId: 'ko-KR', // 한국어로 설정
//     );
//     setState(() {
//       _confidenceLevel = 0; // 인식 정확도 초기화
//       _speechEnabled = true; // STT 활성화
//     });
//   }

//   // STT 리스닝 중지 함수
//   void _stopListening() async {
//     await _speechToText.stop(); // STT 중지
//     setState(() {
//       _speechEnabled = false; // STT 비활성화
//     });
//   }

//   // STT 결과 처리 함수
//   void _onSpeechResulut(SpeechRecognitionResult result) {
//     setState(() {
//       _wordSpoken = "${result.recognizedWords}"; // 인식된 단어 설정
//       print(_wordSpoken);
//       _confidenceLevel = result.confidence; // 인식 정확도 설정
//       if (_confidenceLevel > 0.5) {
//         // 정확도가 0.5보다 클 때
//         _textController.text = _wordSpoken; // 텍스트 컨트롤러에 단어 설정
//         isTyping = true; // 타이핑 중으로 설정
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         title: Text("STT SAMPLE"),
//         backgroundColor: Color(0xFF00005B),
//       ),
//       body: Container(
//         color: Color(0xFFDEDEDE),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 100,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(50.0),
//                   border: Border.all(color: Colors.black),
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                         child: TextField(
//                           controller: _textController,
//                           onTap: () {
//                             setState(() {
//                               isTyping = true;
//                             });
//                           },
//                           maxLines: null,
//                           decoration: InputDecoration(
//                             hintText: "메세지를 입력해주세요",
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: Icon(
//                         _speechToText.isListening ? Icons.mic : Icons.mic_none,
//                         color: _speechEnabled ? Colors.blue : Colors.grey,
//                       ),
//                       onPressed: () async {
//                         if (_speechToText.isListening) {
//                           _stopListening();
//                           setState(() {
//                             isTyping = true; // 음성 인식이 끝나면 텍스트 입력 모드로 전환
//                           });
//                         } else {
//                           _startListening();
//                         }
//                       },
//                       tooltip: 'Listen',
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


 
void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: SafeArea(child: MyTts()),
    ),
  ));
}
 
class MyTts extends StatefulWidget {
  const MyTts({super.key});
 
  @override
  State<MyTts> createState() => _MyTtsState();
}
 
class _MyTtsState extends State<MyTts> {
  FlutterTts flutterTts = FlutterTts();
  /* 언어 설정
    한국어    =   "ko-KR"
    일본어    =   "ja-JP"
    영어      =   "en-US"
    중국어    =   "zh-CN"
    프랑스어  =   "fr-FR"
  */
  String language = "ko-KR";
 
  /* 음성 설정
    한국어 여성 {"name": "ko-kr-x-ism-local", "locale": "ko-KR"}
	  영어 여성 {"name": "en-us-x-tpf-local", "locale": "en-US"}
    일본어 여성 {"name": "ja-JP-language", "locale": "ja-JP"}
    중국어 여성 {"name": "cmn-cn-x-ccc-local", "locale": "zh-CN"}
    중국어 남성 {"name": "cmn-cn-x-ccd-local", "locale": "zh-CN"}
*/
  Map<String, String> voice = {"name": "ko-kr-x-ism-local", "locale": "ko-KR"};
  String engine = "com.google.android.tts";
  double volume = 0.8;
  double pitch = 1.0;
  double rate = 0.5;
 
  // 사용자의 입력 값을 받을 컨트롤러
  final TextEditingController textEditingController = TextEditingController();
 
  @override
  void initState() {
    super.initState();
 
    // TTS 초기 설정
    initTts();
  }
 
  // TTS 초기 설정
  initTts() async {
    await initTtsIosOnly(); // iOS 설정
 
    flutterTts.setLanguage(language);
    flutterTts.setVoice(voice);
    flutterTts.setEngine(engine);
    flutterTts.setVolume(volume);
    flutterTts.setPitch(pitch);
    flutterTts.setSpeechRate(rate);
  }
 
  // TTS iOS 옵션
  Future<void> initTtsIosOnly() async {
    // iOS 전용 옵션 : 공유 오디오 인스턴스 설정
    await flutterTts.setSharedInstance(true);
 
    // 배경 음악와 인앱 오디오 세션을 동시에 사용
    await flutterTts.setIosAudioCategory(
      IosTextToSpeechAudioCategory.ambient,
      [
        IosTextToSpeechAudioCategoryOptions.allowBluetooth,
        IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
        IosTextToSpeechAudioCategoryOptions.mixWithOthers
      ],
      IosTextToSpeechAudioMode.voicePrompt);
  }
 
  // TTS로 읽어주기
  Future _speak(voiceText) async {
    flutterTts.speak(voiceText);
  }
 
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: textEditingController,
          ),
          ElevatedButton(
            onPressed: () {
              _speak(textEditingController.text);
            },
            child: const Text('내용 읽기')),
        ],
      ),
    );
  }
}
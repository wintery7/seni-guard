import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:seniguard/login_platform.dart';
// import 'package:social_login_app/login_platform.dart';

import 'package:flutter/material.dart';
import 'package:seniguard/select_page.dart';

void main() {
  runApp(const FigmaToCode_1());
}

// Generated by: https://www.figma.com/community/plugin/842128343887142055/
class FigmaToCode_1 extends StatelessWidget {
  const FigmaToCode_1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(children: [
          LoginPage(),
        ]),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  LoginPlatform _loginPlatform = LoginPlatform.none;

  @override
  Widget build(BuildContext context) {
    print('start');
    return Column(
      children: [
        Container(
          width: 414,
          height: 896,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFFFCFCFC)),
          child: Stack(
            children: [
              Positioned(
                left: -97,
                top: -154,
                child: Container(
                  width: 608,
                  height: 1152,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          NetworkImage("https://via.placeholder.com/608x1152"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 32,
                top: 763,
                child: Container(
                  width: 350,
                  height: 52.50,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/350x52"),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 454.03,
                child: Container(
                  width: 414,
                  height: 441.97,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 414,
                          height: 441.97,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.00, -1.00),
                              end: Alignment(0, 1),
                              colors: [
                                Color(0x160D1727),
                                Color(0x7F151D2C),
                                Color(0xFF848484)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 142,
                        top: 228.25,
                        child: Text(
                          '더나은 삶을 위한 한걸음',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFFFF9FF),
                            fontSize: 16,
                            fontFamily: 'Freesentation',
                            fontWeight: FontWeight.w300,
                            height: 0.06,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 72,
                        top: 103.97,
                        child: Text(
                          '환영합니다 !\n만나서 반가워요',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontFamily: 'Freesentation',
                            fontWeight: FontWeight.w800,
                            height: 0.03,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 162,
                        top: 13.97,
                        child: _loginButton(
                          onTap: signInWithKakao, // 카카오 로그인 함수 호출
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _loginButton({required VoidCallback onTap}) {
    return Card(
      elevation: 5.0,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: Ink.image(
        image:
            AssetImage('images/kakao_login_medium_narrow.png'), // 카카오 로그인 이미지
        width: 90, // 버튼 크기
        height: 90,
        child: InkWell(
          borderRadius: const BorderRadius.all(
            Radius.circular(45.0), // 둥근 모서리
          ),
          onTap: onTap, // 클릭 시 onTap 호출
        ),
      ),
    );
  }

  void signInWithKakao() async {
    try {
      print('start login');
      bool isInstalled = await isKakaoTalkInstalled();

      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      final url_for_kakao = Uri.https('kapi.kakao.com', '/v2/user/me');

      final response_for_kakao = await http.get(
        url_for_kakao,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
        },
      );

      final profileInfo = json.decode(response_for_kakao.body);

      print('Kakao_user_data : ' + profileInfo.toString());
      print('Kakao_user_Access_Token : Bearer ' +
          token.accessToken); // 넘겨야 할 토큰 값

      final String accToken = 'Bearer ' + token.accessToken; // 토큰 값을 따로 저장
      const String baseUrl = 'http://34.64.182.238:8100/user/auth/kakao';

      // 요청할 URL 생성
      final Uri url_for_capstone = Uri.parse(baseUrl);

      // 헤더에 포함할 데이터
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'kakaoAccessToken': '$accToken', // 예: 인증 토큰
      };
      final response_for_capstone =
          await http.get(url_for_capstone, headers: headers);

      // 서버 응답이 성공적(200 OK)인지 확인
      if (response_for_capstone.statusCode == 200) {
        // JSON 데이터 파싱
        final data = json.decode(response_for_capstone.body);
        print('Response data: $data');

        final String dataAccToken =
            data['access_token']; // 카카오 토큰을 사용해 발급한 캡스톤 유저 토큰
        print('Capstone_AccessToken : $dataAccToken');
      } else {
        print(
            'Request failed with status: ${response_for_capstone.statusCode}');
      }

      setState(() {
        _loginPlatform = LoginPlatform.kakao;
      });
      print('카카오톡 로그인 성공');

      // 로그인 성공 후 새로운 페이지로 이동
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => FigmaToCode_2()), // HomePage로 이동
    );
    } catch (error) {
      // print(await KakaoSdk.origin); 키 해시 확인용
      print('카카오톡으로 로그인 실패 $error');
    }
  }
}


/* --------------------------------------------------------------------------------------
class SampleScreen extends StatefulWidget {
  const SampleScreen({Key? key}) : super(key: key);

  @override
  State<SampleScreen> createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {
  LoginPlatform _loginPlatform = LoginPlatform.none;


  void signInWithKakao() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();

      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      final url_for_kakao = Uri.https('kapi.kakao.com', '/v2/user/me');

      final response_for_kakao = await http.get(
        url_for_kakao,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
        },
      );

      final profileInfo = json.decode(response_for_kakao.body);

      print('Kakao_user_data : ' + profileInfo.toString());
      print('Kakao_user_Access_Token : Bearer ' +
          token.accessToken); // 넘겨야 할 토큰 값

      final String accToken = 'Bearer ' + token.accessToken; // 토큰 값을 따로 저장
      const String baseUrl = 'http://34.64.182.238:8100/user/auth/kakao';

      // 요청할 URL 생성
      final Uri url_for_capstone = Uri.parse(baseUrl);

      // 헤더에 포함할 데이터
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'kakaoAccessToken': '$accToken', // 예: 인증 토큰
      };
      final response_for_capstone =
          await http.get(url_for_capstone, headers: headers);

      // 서버 응답이 성공적(200 OK)인지 확인
      if (response_for_capstone.statusCode == 200) {
        // JSON 데이터 파싱
        final data = json.decode(response_for_capstone.body);
        print('Response data: $data');

        final String dataAccToken =
            data['access_token']; // 카카오 토큰을 사용해 발급한 캡스톤 유저 토큰
        print('Capstone_AccessToken : $dataAccToken');
      } else {
        print(
            'Request failed with status: ${response_for_capstone.statusCode}');
      }

      setState(() {
        _loginPlatform = LoginPlatform.kakao;
      });
      
    } catch (error) {
      // print(await KakaoSdk.origin); 키 해시 확인용
      print('카카오톡으로 로그인 실패 $error');
    }
  }

  void signOut() async {
    switch (_loginPlatform) {
      case LoginPlatform.facebook:
        break;
      case LoginPlatform.google:
        break;
      case LoginPlatform.kakao:
        await UserApi.instance.logout();
        break;
      case LoginPlatform.naver:
        break;
      case LoginPlatform.apple:
        break;
      case LoginPlatform.none:
        break;
    }

    setState(() {
      _loginPlatform = LoginPlatform.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter GET with Headers Example'),
      ),
      body: Center(
          child: _loginPlatform != LoginPlatform.none
              ? _logoutButton()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _loginButton(
                      'kakao_logo',
                      signInWithKakao,
                    )
                  ],
                )),
    );
  }

  Widget _loginButton(String path, VoidCallback onTap) {
    return Card(
      elevation: 5.0,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: Ink.image(
        image: AssetImage('images/kakao_login.png'),
        width: 60,
        height: 60,
        child: InkWell(
          borderRadius: const BorderRadius.all(
            Radius.circular(35.0),
          ),
          onTap: onTap,
        ),
      ),
    );
  }

  Widget _logoutButton() {
    return ElevatedButton(
      onPressed: signOut,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          const Color(0xff0165E1),
        ),
      ),
      child: const Text('로그아웃'),
    );
  }
}
*/
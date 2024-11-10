import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:seniguard/login_platform.dart';
// import 'package:social_login_app/login_platform.dart';


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
      print('Kakao_user_Access_Token : Bearer ' + token.accessToken); // 넘겨야 할 토큰 값
      
      
      final String accToken = 'Bearer ' +token.accessToken; // 토큰 값을 따로 저장
      const String baseUrl = 'http://34.64.182.238:8100/user/auth/kakao';

      // 요청할 URL 생성
      final Uri url_for_capstone = Uri.parse(baseUrl);

      // 헤더에 포함할 데이터
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'kakaoAccessToken': '$accToken', // 예: 인증 토큰
      };
        final response_for_capstone = await http.get(url_for_capstone, headers: headers);

        // 서버 응답이 성공적(200 OK)인지 확인
        if (response_for_capstone.statusCode == 200) {
          // JSON 데이터 파싱
          final data = json.decode(response_for_capstone.body);
          print('Response data: $data');

          final String dataAccToken = data['access_token']; // 카카오 토큰을 사용해 발급한 캡스톤 유저 토큰
          print('Capstone_AccessToken : $dataAccToken');
        } else {
          print('Request failed with status: ${response_for_capstone.statusCode}');
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
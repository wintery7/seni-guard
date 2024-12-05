import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:seniguard/select_page.dart';

void main() {
  KakaoSdk.init(nativeAppKey: 'YOUR_NATIVE_APP_KEY'); // 카카오 앱 키 초기화
  runApp(const Page_Setting());
}

class Page_Setting extends StatelessWidget {
  const Page_Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: const ResponsiveUI(),
    );
  }
}

class ResponsiveUI extends StatefulWidget {
  const ResponsiveUI({super.key});

  @override
  State<ResponsiveUI> createState() => _ResponsiveUIState();
}

class _ResponsiveUIState extends State<ResponsiveUI> {
  String? profileImageUrl;
  String? nickname;
  String? email;

  @override
  void initState() {
    super.initState();
    _fetchKakaoUserInfo();
  }

  Future<void> _fetchKakaoUserInfo() async {
    try {
      User user = await UserApi.instance.me(); // 카카오 사용자 정보 가져오기
      setState(() {
        profileImageUrl = user.kakaoAccount?.profile?.profileImageUrl;
        nickname = user.kakaoAccount?.profile?.nickname;
        email = user.kakaoAccount?.email;
      });
    } catch (error) {
      print('카카오 사용자 정보 가져오기 실패: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // 뒤로가기 아이콘
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FigmaToCode_2(), // 원하는 화면으로 변경
              ),
            );
          },
        ),
        title: const Text('개인 설정'),
        centerTitle: true, // 텍스트 중앙 정렬
        backgroundColor: const Color(0xFF53B175),
      ),
      body: ListView(
        children: [
          Container(
            width: screenSize.width,
            height: screenSize.height,
            decoration: const BoxDecoration(color: Colors.white),
            child: Stack(
              children: [
                // Centered Content
                Positioned(
                  left: screenSize.width * 0.1,
                  top: screenSize.height * 0.1,
                  child: Container(
                    width: screenSize.width * 0.8,
                    height: screenSize.height * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black, width: 2),
                      image: profileImageUrl != null
                          ? DecorationImage(
                              image: NetworkImage(profileImageUrl!),
                              fit: BoxFit.cover, // 이미지를 컨테이너에 맞게 조정
                            )
                          : null,
                    ),
                    child: profileImageUrl == null
                        ? const Center(
                            child: CircularProgressIndicator()) // 로딩 상태 표시
                        : null,
                  ),
                ),

                // Name Section
                Positioned(
                  left: screenSize.width * 0.1,
                  top: screenSize.height * 0.6,
                  child: Container(
                    width: screenSize.width * 0.8,
                    height: screenSize.height * 0.08,
                    decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '성  명 :',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenSize.width * 0.05,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          // 카톡 이름
                          Text(
                            nickname ?? '홍 길 동', // 닉네임이 없을 경우 기본값 설정
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenSize.width * 0.05,
                              fontWeight: FontWeight.w800,
                              
                            ),
                          ),
                          // 카톡 이름
                        ],
                      ),
                    ),
                  ),
                ),

                // Address Section
                Positioned(
                  left: screenSize.width * 0.1,
                  top: screenSize.height * 0.7,
                  child: Container(
                    width: screenSize.width * 0.8,
                    height: screenSize.height * 0.08,
                    decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '주  소 :',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenSize.width * 0.05,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          // 카톡 주소
                          Text(
                            '대구광역시 달구벌대로 1095',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenSize.width * 0.04,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          // 카톡 주소
                        ],
                      ),
                    ),
                  ),
                ),

                // 이메일 주소
                Positioned(
                  left: screenSize.width * 0.1,
                  top: screenSize.height * 0.8,
                  child: Container(
                    width: screenSize.width * 0.8,
                    height: screenSize.height * 0.08,
                    decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '이메일 :',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenSize.width * 0.05,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          // 카톡 주소
                          Text(
                            email ?? '홍 길 동', // 닉네임이 없을 경우 기본값 설정
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenSize.width * 0.05,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // 카카오톡 이메일

                // 질환 섹션
                Positioned(
                  left: screenSize.width * 0.1,
                  top: screenSize.height * 0.9,
                  child: Container(
                    width: screenSize.width * 0.8,
                    height: screenSize.height * 0.08,
                    decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '지  병 :',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenSize.width * 0.05,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          // 질환 명
                          Text(
                            '호흡기 질환, 관절염, 간 질환',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenSize.width * 0.04,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // 질환 섹션
              ],
            ),
          ),
        ],
      ),
    );
  }
}

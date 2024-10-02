import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/login", // 앱이 시작될 때 처음 보여줄 화면 경로를 "/login"으로 설정합니다.
      routes: {
        // Dart에서는 BuildContext context의 타입을 명시하지 않아도 됩니다. 자동으로 추론됩니다.
        "/login": (context) => LoginPage(),
        "/home": (context) => HomePage(),
      },
    );
  }
}

// 로그인 페이지
class LoginPage extends StatelessWidget {
  // 전역변수 필요함: TextEditingController는 사용자가 입력한 값을 바인딩 해줍니다.
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Hot reload는 Scaffold만 가능하다는 점 참고
    return Scaffold(
      body: ListView(
        // 화면을 스크롤할 수 있도록 리스트뷰 사용
        padding: EdgeInsets.all(16.0), // 여백 추가
        children: [
          Container(
            height: 200,
            color: Colors.yellow,
            child: Center(
              child: Text(
                "Welcome",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 20),
          // Username 입력 필드
          TextFormField(
            controller: username,
            decoration: InputDecoration(
              hintText: "Username",
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          SizedBox(height: 20),
          // Password 입력 필드
          TextFormField(
            controller: password,
            obscureText: true, // 비밀번호는 안 보이도록 설정
            decoration: InputDecoration(
              hintText: "Password", //입력 필드 안에 표시할 힌트 텍스트
              prefixIcon: Icon(Icons.password),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          SizedBox(height: 30),
          // 로그인 버튼: 리턴이 없는 것은 익명함수를 사용함
          ElevatedButton(
            onPressed: () {
              // 동기적으로 실행하기 위해 await와 async를 사용할 수 있습니다.
              // 1. 값 가져오기
              String un = username.text;
              String pw = password.text;
              print(un);
              print(pw);
              print("버튼 클릭됨");
              // 2. 통신하기 (여기에 API 호출 로직 추가 가능)

              // 3. 화면 이동 (A -> B)
              // 화면 이동 방법 3가지:
              // 1. Navigator.pushNamed: [A, B] 쌓임, 즉 현재 페이지에 이어서 새로운 페이지가 스택에 쌓임
              // 2. Navigator.pushReplacementNamed: [B]만 쌓임, 즉 현재 페이지를 대체하고 새로운 페이지가 쌓임
              // 3. Navigator.pushNamedAndRemoveUntil: 특정 조건에 따라 기존 스택을 비우고 새로운 페이지가 쌓임
              Navigator.pushNamed(context, "/home"); // "/home" 경로로 이동
            },
            child: Text("로그인"),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              textStyle: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

// 홈 페이지
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar를 만들면 자동으로 뒤로가기 아이콘이 생성됩니다.
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // 화면 이동 방법 예시:
            // 1. [A -> B -> A]
            // Navigator.pushNamed(context, "/login");

            // 2. [A -> A]
            // Navigator.pushReplacementNamed(context, "/login");

            // 3. [A], 새 객체 생성 필요
            // Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);

            // 4. [A] 이거는 history.back과 같습니다. 객체가 남아있습니다.
            Navigator.pop(context);
          },
          child: Text("뒤로가기"),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            textStyle: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

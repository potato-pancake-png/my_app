import 'package:flutter/material.dart';
import 'fridge_main_view.dart';
import 'login_view.dart'; // 로그인 페이지 import

class AccountSelectPage extends StatelessWidget {
  const AccountSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '계정 선택',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Divider(height: 1, thickness: 1, color: Colors.black12),
              const SizedBox(height: 48),
              const Text(
                '개인용 계정',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // 개인용 계정 로직: 냉장 창고 메인 페이지로 이동
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FridgeMainPage(),
                      ),
                    );
                  },
                  child: const Text(
                    '로그인 없이 이용',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 70),
              // 여기 아래에 구분선 추가
              Divider(height: 1, thickness: 1, color: Colors.black12),
              const SizedBox(height: 70), // 구분선 아래 추가 간격
              const Text(
                '가족 냉장고',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const Text(
                '다른 사람들과 함께 냉장고를 관리 할 수 있어요.',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // 가족 냉장고 로그인 로직: 로그인 페이지로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: const Text(
                    '로그인',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

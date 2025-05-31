import 'package:flutter/material.dart';
import '../widgets/common_bottom_nav.dart';
import 'fridge_main_view.dart';
import 'list_view.dart'; // 실제 파일명에 맞게 import

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          '설정',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // 가족 냉장고 전환 기능
                },
                child: const Text('가족 냉장고로 전환'),
              ),
            ),
            const SizedBox(height: 48),
            // 좌측 정렬: Center 제거, crossAxisAlignment로 제어
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('알림 설정', style: TextStyle(fontSize: 16)),
                SizedBox(height: 16),
                Text('공지', style: TextStyle(fontSize: 16)),
                SizedBox(height: 16),
                Text('문의', style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: CommonBottomNav(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const FridgeMainPage(),
                settings: const RouteSettings(name: '/fridge_main'),
              ),
              (route) => false,
            );
          } else if (index == 1) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const ListPage(),
                settings: const RouteSettings(name: '/list_page'),
              ),
              (route) => false,
            );
          }
        },
      ),
    );
  }
}

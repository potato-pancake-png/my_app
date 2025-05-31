import 'package:flutter/material.dart';

class CommonBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CommonBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF5C6BC0),
      unselectedItemColor: Colors.black38,
      currentIndex: currentIndex,
      onTap: onTap, // 페이지 이동은 외부에서 처리
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: '목록'),
      ],
    );
  }
}

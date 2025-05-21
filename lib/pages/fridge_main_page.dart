import 'package:flutter/material.dart';

class FridgeMainPage extends StatefulWidget {
  const FridgeMainPage({super.key});

  @override
  State<FridgeMainPage> createState() => _FridgeMainPageState();
}

class _FridgeMainPageState extends State<FridgeMainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // 하단 네비게이션 바
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF5C6BC0),
      unselectedItemColor: Colors.black38,
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: '목록'),
      ],
    );
  }

  // 상단 AppBar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: const Text(
        '냉장 창고',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 28,
          fontFamily: 'Pretendard',
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings, color: Colors.black),
          onPressed: () {
            // 설정 버튼 동작
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Container(
          color: Colors.white,
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black38,
            indicatorColor: const Color(0xFF5C6BC0),
            indicatorWeight: 3,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'Pretendard',
            ),
            tabs: const [Tab(text: '냉장실'), Tab(text: '냉동실'), Tab(text: '실온')],
          ),
        ),
      ),
    );
  }

  // 탭별 내용
  Widget _buildTabContent() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildEmptyContent('냉장실'),
        _buildEmptyContent('냉동실'),
        _buildEmptyContent('실온'),
      ],
    );
  }

  // 비어있는 내용 위젯
  Widget _buildEmptyContent(String tabName) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          SizedBox(height: 80),
          Icon(Icons.shopping_cart_outlined, color: Colors.black26, size: 40),
          SizedBox(height: 16),
          Text(
            '현재는 아무 상품도 담겨 있지 않아요.',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildTabContent(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF222222),
        onPressed: () {
          // 추가 버튼 동작
        },
        child: const Icon(Icons.add, color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // backgroundColor 속성 제거 (기본 흰색)
    );
  }
}

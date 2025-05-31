import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/common_bottom_nav.dart';
import '../ViewModel/auth_viewmodel.dart';
import '../ViewModel/refrigerator_viewmodel.dart';
import '../Model/refrigerator_model.dart';
import 'item_add_view.dart';
import 'settings_view.dart';
import 'list_view.dart';

class FridgeMainPage extends StatefulWidget {
  const FridgeMainPage({super.key});

  @override
  State<FridgeMainPage> createState() => _FridgeMainPageState();
}

class _FridgeMainPageState extends State<FridgeMainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  int _sortIndex = 0; // 0: 소비기한, 1: 등록일

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      final refrigeratorViewModel = Provider.of<RefrigeratorViewModel>(
        context,
        listen: false,
      );
      // 로그인 상태일 때만 식자재 요청
      if (authViewModel.isLoggedIn) {
        refrigeratorViewModel.fetchItems(authViewModel.token);
      }
    });
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _showSortDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFF6F2FB),
          title: const Text(
            '정렬',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CheckboxListTile(
                value: _sortIndex == 0,
                onChanged: (v) {
                  setState(() {
                    _sortIndex = 0;
                  });
                  Navigator.pop(context);
                },
                title: const Text('소비기한 임박순'),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Colors.black,
              ),
              CheckboxListTile(
                value: _sortIndex == 1,
                onChanged: (v) {
                  setState(() {
                    _sortIndex = 1;
                  });
                  Navigator.pop(context);
                },
                title: const Text('등록일순'),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Colors.black,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return CommonBottomNav(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ListPage()),
          );
        }
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const Text(
            '냉장 창고',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 28,
              fontFamily: 'Pretendard',
            ),
          ),
          const Spacer(),
          Consumer<AuthViewModel>(
            builder: (context, authViewModel, child) {
              if (authViewModel.nickname != null &&
                  authViewModel.nickname!.isNotEmpty) {
                return Text(
                  '${authViewModel.nickname}님',
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Pretendard',
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
      actions: [
        Builder(
          builder:
              (buttonContext) => IconButton(
                icon: const Icon(Icons.settings, color: Colors.black),
                onPressed: () async {
                  final RenderBox button =
                      buttonContext.findRenderObject() as RenderBox;
                  final RenderBox overlay =
                      Overlay.of(context).context.findRenderObject()
                          as RenderBox;
                  final Offset position = button.localToGlobal(
                    Offset.zero,
                    ancestor: overlay,
                  );

                  final selected = await showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(
                      position.dx,
                      position.dy + button.size.height,
                      position.dx + 1,
                      0,
                    ),
                    color: const Color(0xFFF6F2FB),
                    items: const [
                      PopupMenuItem(
                        value: 'sort',
                        child: Text(
                          '정렬',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      PopupMenuItem(
                        value: 'settings',
                        child: Text(
                          '설정',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  );
                  if (selected == 'sort') {
                    _showSortDialog();
                  } else if (selected == 'settings') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SettingsPage()),
                    );
                  }
                },
              ),
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

  Widget _buildTabContent() {
    return Consumer<RefrigeratorViewModel>(
      builder: (context, refrigeratorViewModel, child) {
        return TabBarView(
          controller: _tabController,
          children: [
            _buildLocationContent('냉장실', refrigeratorViewModel.items),
            _buildLocationContent('냉동실', refrigeratorViewModel.items),
            _buildLocationContent('실온', refrigeratorViewModel.items),
          ],
        );
      },
    );
  }

  Widget _buildLocationContent(
    String location,
    List<RefrigeratorItem> allItems,
  ) {
    final locationItems =
        allItems.where((item) => item.location == location).toList();

    if (locationItems.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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

    // 카테고리별로 그룹핑
    final Map<int, List<RefrigeratorItem>> categoryMap = {};
    for (var item in locationItems) {
      categoryMap.putIfAbsent(item.category, () => []).add(item);
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final entry in categoryMap.entries) ...[
            // 카테고리명
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 8,
              ),
              child: Text(
                getCategoryName(entry.key),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            // 아이템 카드들
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    entry.value
                        .map(
                          (item) =>
                              SizedBox(width: 100, child: _buildItemCard(item)),
                        )
                        .toList(),
              ),
            ),
            // 구분선(카테고리별 아이템 아래)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(thickness: 2),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildItemCard(RefrigeratorItem item) {
    // D-day 계산
    final now = DateTime.now();
    final expiredDate = DateTime.parse(item.expired);
    final dDay = expiredDate.difference(now).inDays;

    // D-day에 따른 색상 결정
    Color dDayColor;
    if (dDay <= 3) {
      dDayColor = Colors.red;
    } else if (dDay <= 7) {
      dDayColor = Colors.orange;
    } else {
      dDayColor = Colors.green;
    }

    // 하단 바 색상 결정
    Color bottomBarColor;
    if (dDay <= 3) {
      bottomBarColor = Colors.red;
    } else if (dDay <= 7) {
      bottomBarColor = Colors.orange;
    } else {
      bottomBarColor = Colors.green;
    }

    // 하단 색상 바 (체력바 스타일)
    double percent = 1.0;
    if (item.established.isNotEmpty && item.expired.isNotEmpty) {
      try {
        final establishedDate = DateTime.parse(item.established);
        final expiredDate = DateTime.parse(item.expired);
        final total = expiredDate.difference(establishedDate).inDays;
        final remain = expiredDate.difference(now).inDays;
        if (total > 0) {
          percent = remain / total;
          if (percent < 0) percent = 0;
          if (percent > 1) percent = 1;
        }
      } catch (_) {}
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFBDBDBD), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // D-day 뱃지
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: dDayColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              dDay >= 0 ? 'D-$dDay' : 'D+${-dDay}',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          const SizedBox(height: 4),
          // 이미지 (기본 아이콘으로 대체)
          Icon(Icons.inventory_2_outlined, size: 16, color: Colors.grey[600]),
          const SizedBox(height: 4),
          // 이름
          Text(
            item.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            '${item.quantity}개',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          const SizedBox(height: 3),
          // 체력바
          SizedBox(
            height: 8,
            child: Stack(
              children: [
                // 전체 바(흰색 테두리)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!, width: 1),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                // 남은 기간 비율만큼 색상 바
                FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: percent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: bottomBarColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyContent(String tabName) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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

  String getCategoryName(int category) {
    switch (category) {
      case 1:
        return '고기';
      case 2:
        return '수산물';
      case 3:
        return '과일';
      case 4:
        return '채소';
      default:
        return '기타';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Provider가 올바르게 연결되었는지 확인
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildTabContent(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF222222),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ItemAddPage()),
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: Colors.white,
    );
  }
}

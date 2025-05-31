import 'package:flutter/material.dart';
import '../widgets/common_bottom_nav.dart';
import 'fridge_main_view.dart'; // FridgeMainPage import

// 예시 데이터 (실제 데이터로 교체 필요)
final List<Map<String, String>> _recipes = [
  {
    'image':
        'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8Zm9vZHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60', // 실제 이미지 URL로 교체
    'title': 'Quick Chicken Stir-Fry',
    'subtitle': 'Ready in 20 minutes',
  },
  {
    'image':
        'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8Zm9vZHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60', // 실제 이미지 URL로 교체
    'title': 'Vegetable Curry',
    'subtitle': 'Spicy and flavorful',
  },
  {
    'image':
        'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60', // 실제 이미지 URL로 교체
    'title': 'Pancake Delight',
    'subtitle': 'Sweet and fluffy',
  },
];

final List<Map<String, String>> _ingredients = [
  {
    'image':
        'https://images.unsplash.com/photo-1580959375944-abd7591f73b7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y2hpY2tlbiUyMGJyZWFzdHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60', // 실제 이미지 URL로 교체
    'name': 'Chicken Breast',
    'expiry': 'Expires in 2 days',
  },
  {
    'image':
        'https://images.unsplash.com/photo-1587351177733-0f028088b334?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YnJvY2NvbGl8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60', // 실제 이미지 URL로 교체
    'name': 'Broccoli',
    'expiry': 'Expires in 1 day',
  },
  {
    'image':
        'https://images.unsplash.com/photo-1555949258-c5d3c58dd856?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8cGFzdGF8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60', // 실제 이미지 URL로 교체
    'name': 'Pasta',
    'expiry': 'Expires in 3 days',
  },
];

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final int _selectedIndex = 1; // 목록 탭이 선택된 상태

  Widget _buildRecipeCard(Map<String, String> recipe) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              recipe['image']!,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => Container(
                    height: 120,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: Icon(Icons.fastfood, color: Colors.grey[600]),
                  ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            recipe['title']!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            recipe['subtitle']!,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientTile(Map<String, String> ingredient) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              ingredient['image']!,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey[300],
                    child: Icon(Icons.kitchen, color: Colors.grey[600]),
                  ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ingredient['name']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  ingredient['expiry']!,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        title: const Text(
          'Recipes & Ingredients', // AppBar 타이틀 변경
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Recipes',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200, // 레시피 카드 리스트 높이
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _recipes.length,
                  itemBuilder: (context, index) {
                    return _buildRecipeCard(_recipes[index]);
                  },
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Ingredients',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8), // Ingredients 타이틀과 목록 사이 간격
              ListView.builder(
                shrinkWrap: true, // SingleChildScrollView 내부에 ListView 사용 시 필요
                physics:
                    const NeverScrollableScrollPhysics(), // SingleChildScrollView 내부에 ListView 사용 시 필요
                itemCount: _ingredients.length,
                itemBuilder: (context, index) {
                  return _buildIngredientTile(_ingredients[index]);
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: CommonBottomNav(
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const FridgeMainPage(),
                settings: const RouteSettings(name: '/fridge_main'),
              ),
              (route) => false,
            );
          }
          // index == 1(목록)은 현재 페이지이므로 아무 동작 없음
        },
      ),
    );
  }
}

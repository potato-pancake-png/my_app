import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../Model/refrigerator_model.dart';

class RefrigeratorViewModel extends ChangeNotifier {
  List<RefrigeratorItem> _items = [];
  bool _isLoading = false;

  List<RefrigeratorItem> get items => _items;
  bool get isLoading => _isLoading;

  Future<void> fetchItems(String? token) async {
    if (token == null) return;
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/ref/ingredients'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final dynamic responseBody = jsonDecode(response.body);
        List<dynamic> ingredientsData;

        if (responseBody is Map<String, dynamic>) {
          if (responseBody.containsKey('ingredients')) {
            ingredientsData = responseBody['ingredients'] as List<dynamic>;
          } else if (responseBody.containsKey('data')) {
            ingredientsData = responseBody['data'] as List<dynamic>;
          } else if (responseBody.containsKey('items')) {
            ingredientsData = responseBody['items'] as List<dynamic>;
          } else {
            ingredientsData = [];
          }
        } else if (responseBody is List<dynamic>) {
          ingredientsData = responseBody;
        } else {
          ingredientsData = [];
        }

        _items =
            ingredientsData
                .map(
                  (item) =>
                      RefrigeratorItem.fromJson(item as Map<String, dynamic>),
                )
                .toList();
      } else {
        _items = [];
      }
    } catch (e) {
      _items = [];
    }
    _isLoading = false;
    notifyListeners();
  }
}

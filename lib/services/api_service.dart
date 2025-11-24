import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://www.themealdb.com/api/json/v1/1/";

  static Future<List<dynamic>> getCategories() async {
    final response = await http.get(Uri.parse("${baseUrl}categories.php"));
    return jsonDecode(response.body)["categories"];
  }

  static Future<List<dynamic>> getMealsByCategory(String category) async {
    final response = await http.get(
      Uri.parse("${baseUrl}filter.php?c=$category"),
    );
    return jsonDecode(response.body)["meals"];
  }

  static Future<List<dynamic>> searchMeals(String query) async {
    final response = await http.get(Uri.parse("${baseUrl}search.php?s=$query"));
    return jsonDecode(response.body)["meals"];
  }

  static Future<Map<String, dynamic>> getMealDetail(String id) async {
    final response = await http.get(Uri.parse("${baseUrl}lookup.php?i=$id"));
    return jsonDecode(response.body)["meals"][0];
  }

  static Future<Map<String, dynamic>> getRandomMeal() async {
    final response = await http.get(Uri.parse("${baseUrl}random.php"));
    return jsonDecode(response.body)["meals"][0];
  }
}

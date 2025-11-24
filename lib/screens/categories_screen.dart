import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/category.dart';
import '../widgets/category_card.dart';
import 'meals_screen.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Category> categories = [];
  List<Category> filtered = [];

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  void loadCategories() async {
    final data = await ApiService.getCategories();
    setState(() {
      categories = data.map((json) => Category.fromJson(json)).toList();
      filtered = categories;
    });
  }

  void searchCategory(String query) {
    setState(() {
      filtered = categories
          .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        actions: [
          IconButton(
            icon: Icon(Icons.shuffle),
            onPressed: () async {
              final data = await ApiService.getRandomMeal();
              Navigator.pushNamed(context, "/mealDetail", arguments: data);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              onChanged: searchCategory,
              decoration: InputDecoration(
                hintText: "Search categories...",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                return CategoryCard(
                  category: filtered[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            MealsScreen(category: filtered[index].name),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

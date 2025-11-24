import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/meal.dart';
import '../widgets/meal_card.dart';
import 'meal_detail_screen.dart';

class MealsScreen extends StatefulWidget {
  final String category;
  MealsScreen({required this.category});

  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  List<Meal> meals = [];
  List<Meal> filtered = [];

  @override
  void initState() {
    super.initState();
    loadMeals();
  }

  void loadMeals() async {
    final data = await ApiService.getMealsByCategory(widget.category);
    setState(() {
      meals = data.map((json) => Meal.fromJson(json)).toList();
      filtered = meals;
    });
  }

  void searchMeal(String query) {
    setState(() {
      filtered = meals
          .where((m) => m.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              onChanged: searchMeal,
              decoration: InputDecoration(
                hintText: "Search meals...",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: filtered.map((meal) {
                return MealCard(
                  meal: meal,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MealDetailScreen(id: meal.id),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

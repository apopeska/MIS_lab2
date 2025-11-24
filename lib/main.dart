import 'package:flutter/material.dart';
import 'screens/categories_screen.dart';
import 'screens/meal_detail_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (_) => CategoriesScreen(),
        "/mealDetail": (context) {
          final data =
              ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>;
          return MealDetailScreen(id: data["idMeal"]);
        },
      },
    ),
  );
}

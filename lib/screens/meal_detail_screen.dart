import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/meal_detail.dart';

class MealDetailScreen extends StatefulWidget {
  final String id;

  MealDetailScreen({required this.id});

  @override
  _MealDetailScreenState createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  MealDetail? meal;

  @override
  void initState() {
    super.initState();
    loadMeal();
  }

  void loadMeal() async {
    final data = await ApiService.getMealDetail(widget.id);
    setState(() {
      meal = MealDetail.fromJson(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (meal == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: Text(meal!.name)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(meal!.thumbnail),
            SizedBox(height: 16),
            Text(
              "Ingredients",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ...meal!.ingredients.map((i) => Text("• $i")),
            SizedBox(height: 16),
            Text(
              "Instructions",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(meal!.instructions),
            SizedBox(height: 16),
            if (meal!.youtube.isNotEmpty)
              ElevatedButton(onPressed: () {}, child: Text("Watch on YouTube")),
          ],
        ),
      ),
    );
  }
}

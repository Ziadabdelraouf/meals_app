import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
   CategoriesScreen({super.key,required this.onToggle,required this.availableMeals});
  List<Meal> availableMeals;
final void Function(Meal meal) onToggle ;
  void _selectcategory(BuildContext context, Category category) {
    final filtered = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => MealsScreen(
            onToggle: onToggle,
            title: category.title,
            meals: filtered,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            tap: () {
              _selectcategory(context, category);
            },
          )
      ],
    );
  }
}

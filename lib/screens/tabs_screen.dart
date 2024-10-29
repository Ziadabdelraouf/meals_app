import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedindex = 0;
  String activeScreenTitle = 'Categories';

  final List<Meal> _favoriteMeal = [];
  void _toggleMealStatus(Meal meal) {
    _favoriteMeal.contains(meal)
        ? _favoriteMeal.remove(meal)
        : _favoriteMeal.add(meal);
  }

  void _selectPage(index) {
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen =  CategoriesScreen(onToggle: _toggleMealStatus);

    if (_selectedindex == 1) {
      activeScreen = MealsScreen(onToggle: _toggleMealStatus, meals: _favoriteMeal);
      activeScreenTitle = 'Favourites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activeScreenTitle),
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _selectPage(index);
        },
        currentIndex: _selectedindex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }
}

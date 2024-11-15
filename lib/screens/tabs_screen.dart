import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

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
  void _showinfo(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleMealStatus(Meal meal) {
    _favoriteMeal.contains(meal)
        ? setState(() {
            _favoriteMeal.remove(meal);
            _showinfo('Meal removed');
          })
        : setState(() {
            _favoriteMeal.add(meal);
            _showinfo('Meal added');
          });
  }

  void _selectPage(index) {
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = CategoriesScreen(onToggle: _toggleMealStatus);

    if (_selectedindex == 1) {
      activeScreen =
          MealsScreen(onToggle: _toggleMealStatus, meals: _favoriteMeal);
      activeScreenTitle = 'Favourites';
    }
    void _selecteddrawer(String identifer){
      if(identifer=='filter'){

      }else{
        Navigator.of(context).pop();
      }
    }
    return Scaffold(
      drawer:  MainDrawer(selected: _selecteddrawer,),
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

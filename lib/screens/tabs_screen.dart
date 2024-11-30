import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kintialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

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

  Map<Filter, bool> _Selectedfilters = kintialFilters;

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
    final availableMeals = dummyMeals.where((meal) {
      if (_Selectedfilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_Selectedfilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_Selectedfilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_Selectedfilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    Widget activeScreen = CategoriesScreen(onToggle: _toggleMealStatus,availableMeals: availableMeals,);
    if (_selectedindex == 1) {
      activeScreen =
          MealsScreen(onToggle: _toggleMealStatus, meals: _favoriteMeal);
      activeScreenTitle = 'Favourites';
    }
    void _selecteddrawer(String identifer) async {
      Navigator.of(context).pop();
      if (identifer == 'filters') {
        //we could use pushReplacment instead of push to replace the current screen instead of pushing another one on top
        final result = await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(
            builder: (context) =>  FiltersScreen(currentFilter: _Selectedfilters,),
          ),
        );
        setState(() {
          _Selectedfilters = result ?? kintialFilters;
        });
      }
    }

    return Scaffold(
      drawer: MainDrawer(
        selected: _selecteddrawer,
      ),
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

import 'package:flutter/material.dart';
import 'package:meals_app/Provider/favourite_provider.dart';
import 'package:meals_app/Provider/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/Provider/filter_provider.dart';

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

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedindex = 0;
  String activeScreenTitle = 'Categories';
  

  Map<Filter, bool> _Selectedfilters = kintialFilters;

  void _showinfo(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

 

  void _selectPage(index) {
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
   
   final availableMeals = ref.watch(filteredMealsProvider); 
    Widget activeScreen = CategoriesScreen(
      availableMeals: availableMeals,
    );
    if (_selectedindex == 1) {
final favouriteMeals = ref.watch(FavouriteMealProvider);
      activeScreen =
          MealsScreen( meals: favouriteMeals);
      activeScreenTitle = 'Favourites';
    }
    void _selecteddrawer(String identifer) async {
      Navigator.of(context).pop();
      if (identifer == 'filters') {
        //we could use pushReplacment instead of push to replace the current screen instead of pushing another one on top
        await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(
            builder: (context) => const FiltersScreen(
              
            ),
          ),
        );
  
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

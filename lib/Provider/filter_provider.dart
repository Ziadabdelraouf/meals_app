import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/Provider/meals_provider.dart';
import 'package:meals_app/screens/tabs_screen.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class filtersnotifier extends StateNotifier<Map<Filter, bool>> {
  filtersnotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });
  void togglefilters(Map<Filter, bool> filters) {
    state = filters;
  }

  void togglefilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filterprovider =
    StateNotifierProvider<filtersnotifier, Map<Filter, bool>>(
  (ref) => filtersnotifier(),
);

final filteredMealsProvider = Provider((ref) {
  final activeFilters = ref.watch(filterprovider);
  final meals = ref.watch(mealsProvider);
  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});

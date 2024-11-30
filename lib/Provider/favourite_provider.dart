import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class Favouritenotifier extends StateNotifier<List<Meal>> {
  Favouritenotifier() : super([]);
  bool toggleFavourite(Meal meal) {
    if (state.contains(meal)) {
      state = state.where((element) => element.id != meal.id).toList();
      return true;
    } else {
      state = [...state, meal];
 return false;
    }
  }
}

final FavouriteMealProvider =
    StateNotifierProvider<Favouritenotifier, List<Meal>>(
  (ref) {
    return Favouritenotifier();
  },
);

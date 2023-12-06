import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  //constructor
  //with super we refer to the parent class(StateNotifier class)
  //to super we pass initial data ..here we pass an empty list of meals
  FavoriteMealsNotifier() : super([]);

  //Function to edit data:
  bool toggleMealFavoriteStatus(Meal meal) {
    // //state is a globally available property that holds the data(here meals)
    final mealIsFavorite =
        state.contains(meal); //shows if a meal is already in fav list or not

    //removing a meal:
    if (mealIsFavorite) {
      //where is used because it filters and creates a new list
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      //adding a meal:
      //using spread operator to add existing meals and also adding an new meal to the list
      state = [...state, meal];
      return true;
    }
  }
}

//using statenotifierprovider for dynamic data
final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier(); //returns an instance of the above class
});

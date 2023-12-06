import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/provider/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          //Filters ae set to false initially
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegan: false,
          Filter.vegetarian: false,
        });

  //CAUTION:check func name
  void setFiltersss(Map<Filter, bool> choosenFilters) {
    state = choosenFilters;
  }

//we have to manipulate the state in an immutable way
//func for Updation of a filter in the map
  void setFilter(Filter filter, bool isActive) {
    // state[filter] = isActive;//is not allowed as we are mutating the state in the memory
    //creating a new map that has existing key value pair of original map and a filter
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>((ref) {
  return FiltersNotifier();
});

//DEPENDENT PROVIDERS
final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(
      mealsProvider); //ref re-executes the entire function written below whenever the watched value  changes
  //so in the end here we can then return an updated data and any widget that would be listening to this provider(filteredMealsProvider) would then also be updated

//SAME logic for filtersProvider:whenver filtersProvider changes the function re executes and the filtered meals are calculated again
  final activeFilters = ref.watch(filtersProvider);

//just for debugging:
  print("Meals length: ${meals.length}");
  print("Active Filters: $activeFilters");

  return //will include only those meals that meet the filter condition
      meals.where((meal) {
    // if (_selectedFilters[Filter.glutenFree]! &&
    //     !meal.isGlutenFree) //checking if gluten free filter is set
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    return true;
  }).toList(); //returns a list not an iterable
});

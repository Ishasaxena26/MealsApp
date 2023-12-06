import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/provider/favorites_provider.dart';
import 'package:meals/provider/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.vegan: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false
};

//class TabsScreen extends StatefulWidget
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

//class _TabsScreenState extends State<TabsScreen>
class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  // Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    //   if (identifier == 'filters') {
    //     Navigator.pop(context); //with this line the drawer will get closed
    //     //the below statement will execute only when the user did navigate back so we wait with the help of await keyword
    //     final result = await Navigator.of(context).push<Map<Filter, bool>>(
    //       //return type of push will be of map type in which keys will be of filters type and values will be of boolean type

    //       MaterialPageRoute(
    //         builder: (ctx) =>const  FiltersScreen(
    //          // currentFilters: _selectedFilters,
    //         ),
    //       ),
    //     );
    //     // print( result); //prints true or false for each key whenver user taps on various button in filters
    //    // setState(() {
    //       _selectedFilters = result ?? kInitialFilters;
    //       /*?? checks whether the value in front of it is null, and if it is null, the fallback value defined
    //     after the double question marks will be used.
    //     So this operator allows you to set up
    //     a conditional fallback value in case this value should be null.
    //     */
    //     });
    //   } else {
    //     Navigator.of(context)
    //         .pop(); //if we are already on the categories screen then drawer will close automatically
    //   }
    // }
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    print("Available Meals length: ${availableMeals.length}");
    // Print names of filtered meals
    availableMeals.forEach((meal) {
      print("Filtered Meal Name: ${meal.title}");
    });

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Your Favorite Meals';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        //onTap takes the index which is an integer to grab the position
        onTap: _selectPage,
        currentIndex: _selectedPageIndex, //highlights which is tapped
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
      ),
    );
  }
}

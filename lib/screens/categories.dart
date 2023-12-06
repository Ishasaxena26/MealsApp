//Category screen ..where u can select a category and see al the food inside it

import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_items.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

//to initialize animation controller:
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0, //these values are set by default
      upperBound: 1,
    );
    _animationController.forward(); //explicitly starting animation
  }

//to remove animationcontroller from device's memory once the widget is removed,To make sure not causing any memory overflows
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

//context is not available in stateless class as it is available in stateful so we have to pass builderContext
  void _selectCategory(BuildContext context, Category category) {
    //where iterates on every item in that list
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    //Syntax is Navigator.push(context,place_route)
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => MealsScreen(
            title: category.title,
            meals: filteredMeals,
          ),
        ));

//METHoD 2 :
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (ctx) => MealsScreen(
    //       title: 'Some title ',
    //       meals: [],
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(24),
        //gridDelegate controls the layout of the GridView items
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        //crossAxisCount helps to set the number of columns horizontally
        //childAspectRatio impacts the sizing of the those grid views
        //crossAxisSpacing is the spacing between cols and mainAxis Spacing is for vertical spacing

        children: [
          //ALTERNATIVE TO FOR LOOP:availableCategories.map((category)=>CategoryGridItem(category:category))
          for (final i in availableCategories)
            CategoryGridItem(
              category:
                  i, //replace i with category....it is just a variable dont get confused
              onSelectCategory: () {
                _selectCategory(context, i);
              },
            )
        ],
      ),
      // //the child parameter is the above child mentioned (Grid View)
      // //Padding widget will be animated...not the grid view
      // builder: (context, child) => Padding(
      //     padding: EdgeInsets.only(
      //       top: 100 -
      //           _animationController.value *
      //               100, //initially value is 0 so padding will be 100 then after 300 msec padding will be 0 from top  as value will be 1
      //     ),
      //     child: child),

      //2nd METHOD :explicit animation
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3), //vales are on x and y axis
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
              parent: _animationController, curve: Curves.easeInOut),
        ),
        child: child,
      ),
    );
  }
}

//For outputing the list of meals when u tap on a category
import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });

  final Meal meal;

  final void Function(Meal meal) onSelectMeal;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8), //helps to add space between images
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip
          .hardEdge, //removes any content that goes out of the card widegt size
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectMeal(meal);
        },
        child: Stack(
          //the Stack widget is used to position multiple widgets above each other
          children: [
            //this fadeinimage helps to provide a subtle look till the time image is loaded from the network...kind of animation
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit
                    .cover, //image is large then cut it and zoom it to be able to fit in the box
                height: 200, //fit uses this height
                width: double.infinity, //fit uses this width
              ),
            ),
            //now after image the next widget on top of it comes using postioned:
            Positioned(
              //left ,right,bottom tells how the child will be placed on the lowest levelm widget that is image over here
              left:
                  0, //starts at left border of image..without leaving any space
              right: 0, //ends at right border of image
              bottom: 0,
              child: Container(
                color:
                    Colors.black54, //very transparent kind of black for the bg
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis, //very long text
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(icon: Icons.work, label: complexityText),
                        const SizedBox(width: 12),
                        MealItemTrait(
                            icon: Icons.currency_rupee_sharp,
                            label: affordabilityText),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

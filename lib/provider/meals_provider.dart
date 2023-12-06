import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';

//instantiating the Provider class which is provided by flutter_riverpod
final mealsProvider = Provider((ref) {
  return dummyMeals;
});

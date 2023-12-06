//model
import 'package:flutter/material.dart';

class Category {
//constructor
  const Category(
      {required this.id, required this.title, this.color = Colors.orange});

  final String id;
  final String title;
  final Color
      color; //this 'Color' is flutter specific type so import the material.dart
}

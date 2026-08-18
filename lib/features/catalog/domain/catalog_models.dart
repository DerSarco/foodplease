import 'package:flutter/material.dart';

class Food {
  const Food(this.name, this.desc, this.price, this.icon);
  final String name, desc;
  final int price;
  final IconData icon;
}

class Restaurant {
  const Restaurant(
    this.name,
    this.kind,
    this.rating,
    this.minutes,
    this.fee,
    this.colors,
    this.foods,
  );
  final String name, kind;
  final double rating;
  final int minutes, fee;
  final List<Color> colors;
  final List<Food> foods;
}

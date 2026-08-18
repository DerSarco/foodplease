import 'package:flutter/material.dart';

import '../domain/catalog_models.dart';

const restaurants = <Restaurant>[
  Restaurant(
    'Burger Lab',
    'Hamburguesas',
    4.8,
    25,
    990,
    [Color(0xFFFF8A65), Color(0xFFBF360C)],
    [
      Food(
        'Burger clásica',
        'Carne, cheddar, tomate y salsa de la casa',
        6490,
        Icons.lunch_dining,
      ),
      Food(
        'Doble smash',
        'Doble carne, cheddar, cebolla y pepinillos',
        7990,
        Icons.lunch_dining,
      ),
      Food(
        'Papas rústicas',
        'Papas sazonadas con salsa ahumada',
        3290,
        Icons.fastfood,
      ),
    ],
  ),
  Restaurant(
    'Sushi Nori',
    'Sushi',
    4.7,
    35,
    1490,
    [Color(0xFF80CBC4), Color(0xFF00695C)],
    [
      Food(
        'Nori mix 20',
        'Salmón, palta, camarón y queso crema',
        10990,
        Icons.set_meal,
      ),
      Food(
        'Veggie rolls 10',
        'Palta, pepino y pimentón asado',
        5990,
        Icons.eco,
      ),
      Food(
        'Gyozas',
        'Seis unidades de pollo y verduras',
        4490,
        Icons.rice_bowl,
      ),
    ],
  ),
  Restaurant(
    'Casa Pasta',
    'Italiana',
    4.6,
    30,
    1190,
    [Color(0xFFFFCC80), Color(0xFFEF6C00)],
    [
      Food(
        'Fettuccine pesto',
        'Pesto de albahaca, parmesano y nueces',
        8490,
        Icons.dinner_dining,
      ),
      Food(
        'Penne al ragú',
        'Salsa de tomate, carne y hierbas',
        8990,
        Icons.dinner_dining,
      ),
      Food('Tiramisú', 'Café, mascarpone y cacao', 4290, Icons.cake),
    ],
  ),
];

import 'package:flutter/foundation.dart';

import '../features/catalog/domain/catalog_models.dart';

class Line {
  Line(this.restaurant, this.food, [this.qty = 1]);
  final Restaurant restaurant;
  final Food food;
  int qty;
}

class AppState extends ChangeNotifier {
  bool logged = false, ordered = false;
  int stage = 0;
  final cart = <Line>[];
  int get count => cart.fold(0, (s, x) => s + x.qty);
  int get subtotal => cart.fold(0, (s, x) => s + x.food.price * x.qty);
  int get fee => cart.isEmpty ? 0 : cart.first.restaurant.fee;
  int get total => subtotal + fee;
  void login() {
    logged = true;
    notifyListeners();
  }

  void logout() {
    logged = false;
    ordered = false;
    cart.clear();
    notifyListeners();
  }

  void add(Restaurant r, Food f) {
    final found = cart.where((x) => identical(x.food, f));
    found.isEmpty ? cart.add(Line(r, f)) : found.first.qty++;
    notifyListeners();
  }

  void change(Line x, int d) {
    x.qty += d;
    if (x.qty < 1) cart.remove(x);
    notifyListeners();
  }

  void order() {
    ordered = true;
    stage = 0;
    notifyListeners();
  }

  void next() {
    if (stage < 4) stage++;
    notifyListeners();
  }
}

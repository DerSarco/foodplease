import 'package:flutter_test/flutter_test.dart';
import 'package:foodplease/main.dart';

void main() {
  testWidgets('permite ingresar y muestra restaurantes', (t) async {
    await t.pumpWidget(const FoodPleaseApp());
    expect(find.text('Qué bueno verte'), findsOneWidget);
    await t.tap(find.text('Ingresar'));
    await t.pumpAndSettle();
    expect(find.text('¿Qué se te antoja hoy?'), findsOneWidget);
    expect(find.text('Burger Lab'), findsOneWidget);
  });
  testWidgets('agrega un producto', (t) async {
    await t.pumpWidget(const FoodPleaseApp());
    await t.tap(find.text('Ingresar'));
    await t.pumpAndSettle();
    final card = find.byType(RestaurantCard).first;
    await t.ensureVisible(card);
    await t.tapAt(t.getTopLeft(card) + const Offset(24, 24));
    await t.pumpAndSettle();
    await t.tap(find.text('Agregar').first);
    await t.pump();
    expect(find.text('Burger clásica agregado'), findsOneWidget);
  });
  test('total incluye cantidades y despacho', () {
    final s = AppState();
    s.add(restaurants.first, restaurants.first.foods.first);
    s.add(restaurants.first, restaurants.first.foods.first);
    expect(s.count, 2);
    expect(s.total, 13970);
  });
}

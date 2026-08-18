import 'package:flutter/material.dart';

import '../../../app/app_scope.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/currency.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../checkout/presentation/checkout_screens.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});
  @override
  Widget build(BuildContext c) {
    final s = Scope.of(c);
    return Scaffold(
      appBar: AppBar(title: const Text('Tu carrito'), backgroundColor: canvas),
      body: s.cart.isEmpty
          ? const Empty(
              icon: Icons.shopping_bag_outlined,
              title: 'Tu carrito está vacío',
              message: 'Explora restaurantes y agrega algo delicioso.',
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  s.cart.first.restaurant.name,
                  style: Theme.of(c).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                ...s.cart.map(
                  (x) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Container(
                            width: 54,
                            height: 54,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFE0D6),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(x.food.icon, color: orange),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  x.food.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  money(x.food.price),
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => s.change(x, -1),
                            icon: const Icon(Icons.remove_circle_outline),
                          ),
                          Text(
                            '${x.qty}',
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                          IconButton(
                            onPressed: () => s.change(x, 1),
                            icon: const Icon(Icons.add_circle, color: orange),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Summary('Subtotal', money(s.subtotal)),
                Summary('Envío', money(s.fee)),
                const Divider(height: 28),
                Summary('Total', money(s.total), bold: true),
                const SizedBox(height: 18),
                ElevatedButton.icon(
                  onPressed: () => Navigator.push(
                    c,
                    MaterialPageRoute(builder: (_) => const Checkout()),
                  ),
                  icon: const Icon(Icons.lock_outline),
                  label: const Text('Continuar al pago'),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Pago simulado para fines académicos.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.black45),
                ),
              ],
            ),
    );
  }
}

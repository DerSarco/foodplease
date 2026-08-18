import 'package:flutter/material.dart';

import '../../../app/app_scope.dart';
import '../../cart/presentation/cart_screen.dart';
import '../../catalog/presentation/catalog_screens.dart';
import '../../orders/presentation/orders_screen.dart';
import '../../profile/presentation/profile_screen.dart';

class Shell extends StatefulWidget {
  const Shell({super.key});
  @override
  State<Shell> createState() => _Shell();
}

class _Shell extends State<Shell> {
  int i = 0;
  @override
  Widget build(BuildContext c) {
    final s = Scope.of(c);
    final pages = [
      Home(openCart: () => setState(() => i = 1)),
      const Cart(),
      const Orders(),
      const Profile(),
    ];
    return Scaffold(
      body: IndexedStack(index: i, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: i,
        onDestinationSelected: (v) => setState(() => i = v),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: s.count > 0,
              label: Text('${s.count}'),
              child: const Icon(Icons.shopping_bag_outlined),
            ),
            selectedIcon: const Icon(Icons.shopping_bag),
            label: 'Carrito',
          ),
          const NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Pedidos',
          ),
          const NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../app/app_scope.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/currency.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../tracking/presentation/tracking_screen.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});
  @override
  Widget build(BuildContext c) {
    final s = Scope.of(c);
    return Scaffold(
      appBar: AppBar(title: const Text('Mis pedidos'), backgroundColor: canvas),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (s.ordered)
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: CircleAvatar(
                  backgroundColor: stageColors[s.stage].withValues(alpha: .15),
                  child: Icon(stageIcons[s.stage], color: stageColors[s.stage]),
                ),
                title: Text(
                  '#FP-2408 · ${s.cart.first.restaurant.name}',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text('${stages[s.stage]} · ${money(s.total)}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.push(
                  c,
                  MaterialPageRoute(builder: (_) => const Tracking()),
                ),
              ),
            )
          else
            const Empty(
              icon: Icons.receipt_long_outlined,
              title: 'Aún no hay pedidos',
              message: 'Cuando confirmes uno, aparecerá aquí.',
            ),
          const SizedBox(height: 22),
          Text('Historial', style: Theme.of(c).textTheme.titleLarge),
          const SizedBox(height: 10),
          const History('Sushi Nori', '12 ago 2026', '\$16.470'),
          const History('Casa Pasta', '2 ago 2026', '\$13.970'),
        ],
      ),
    );
  }
}

class History extends StatelessWidget {
  const History(this.name, this.date, this.total, {super.key});
  final String name, date, total;
  @override
  Widget build(BuildContext c) => Card(
    child: ListTile(
      leading: const CircleAvatar(
        backgroundColor: Color(0xFFE8F5E9),
        child: Icon(Icons.check, color: Color(0xFF2E7D32)),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.w700)),
      subtitle: Text('$date · Entregado'),
      trailing: Text(
        total,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
  );
}

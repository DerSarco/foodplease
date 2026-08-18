import 'package:flutter/material.dart';

import '../../../app/app_scope.dart';
import '../../../core/maps/delivery_map.dart';
import '../../../core/theme/app_theme.dart';

class CourierDeliveryScreen extends StatelessWidget {
  const CourierDeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Scope.of(context);
    final delivered = state.stage == 4;
    final routeIndex = delivered ? 5 : 3;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: DeliveryMap(progressIndex: routeIndex)),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  _CourierHeader(delivered: delivered),
                  const SizedBox(height: 10),
                  const _AssignmentAlert(),
                  const Spacer(),
                  _DeliveryPanel(
                    delivered: delivered,
                    onPrimary: () {
                      if (!delivered) {
                        while (state.stage < 4) {
                          state.next();
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CourierHeader extends StatelessWidget {
  const _CourierHeader({required this.delivered});
  final bool delivered;

  @override
  Widget build(BuildContext context) => Container(
    height: 54,
    padding: const EdgeInsets.symmetric(horizontal: 6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 12)],
    ),
    child: Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.menu),
        ),
        const Expanded(
          child: Text(
            'FoodPlease',
            style: TextStyle(
              color: orange,
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
          ),
        ),
        Badge(
          isLabelVisible: !delivered,
          smallSize: 9,
          child: const Icon(Icons.notifications_outlined),
        ),
        const SizedBox(width: 12),
      ],
    ),
  );
}

class _AssignmentAlert extends StatelessWidget {
  const _AssignmentAlert();

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 12)],
    ),
    child: const Row(
      children: [
        CircleAvatar(
          backgroundColor: orange,
          child: Icon(Icons.shopping_bag_outlined, color: Colors.white),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nuevo pedido asignado',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              Text(
                'Burger Lab · 2,5 km',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
        Icon(Icons.chevron_right),
      ],
    ),
  );
}

class _DeliveryPanel extends StatelessWidget {
  const _DeliveryPanel({required this.delivered, required this.onPrimary});
  final bool delivered;
  final VoidCallback onPrimary;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20)],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 42,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: delivered
                    ? const Color(0xFFE8F5E9)
                    : const Color(0xFFFFE0D6),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                delivered ? 'ENTREGADO' : 'EN CAMINO',
                style: TextStyle(
                  color: delivered ? const Color(0xFF2E7D32) : orange,
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                ),
              ),
            ),
            const Spacer(),
            CircleAvatar(
              backgroundColor: const Color(0xFFECEFF1),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.phone_outlined, size: 20),
              ),
            ),
          ],
        ),
        const Text(
          'Av. Providencia 1234, Depto. 56',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        const Text(
          'Cliente: Cliente Demo',
          style: TextStyle(color: Colors.black54),
        ),
        const Divider(height: 26),
        const Row(
          children: [
            Icon(Icons.receipt_long_outlined, size: 18),
            SizedBox(width: 8),
            Expanded(child: Text('Orden #FP-2408 · 2 productos')),
            Text('\$7.480', style: TextStyle(fontWeight: FontWeight.w800)),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.navigation_outlined),
                label: const Text('Navegar'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: charcoal,
                  minimumSize: const Size.fromHeight(48),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.outlined(
              onPressed: () {},
              icon: const Icon(Icons.info_outline),
              style: IconButton.styleFrom(minimumSize: const Size(48, 48)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: delivered ? null : onPrimary,
          icon: Icon(delivered ? Icons.check_circle : Icons.swipe_right),
          label: Text(delivered ? 'Entrega completada' : 'Confirmar entrega'),
          style: ElevatedButton.styleFrom(backgroundColor: charcoal),
        ),
      ],
    ),
  );
}

import 'package:flutter/material.dart';

import '../../../app/app_scope.dart';
import '../../../core/maps/delivery_map.dart';
import '../../../core/theme/app_theme.dart';

const stages = ['Recibido', 'Preparación', 'Listo', 'En camino', 'Entregado'];
const stageIcons = [
  Icons.receipt_long,
  Icons.soup_kitchen,
  Icons.shopping_bag,
  Icons.delivery_dining,
  Icons.home_filled,
];
const stageColors = [
  Color(0xFFFFA000),
  Color(0xFF039BE5),
  orange,
  Color(0xFF673AB7),
  Color(0xFF2E7D32),
];

class Tracking extends StatelessWidget {
  const Tracking({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Scope.of(context);
    final active = state.stage;
    final routeIndex = [0, 0, 0, 3, 5][active];
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: DeliveryMap(progressIndex: routeIndex)),
          SafeArea(
            child: Column(
              children: [
                _TrackingHeader(onBack: () => Navigator.pop(context)),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: _TrackingPanel(active: active, onNext: state.next),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TrackingHeader extends StatelessWidget {
  const _TrackingHeader({required this.onBack});
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) => Container(
    height: 58,
    margin: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 12)],
    ),
    child: Row(
      children: [
        IconButton(onPressed: onBack, icon: const Icon(Icons.arrow_back)),
        const Expanded(
          child: Text(
            'FoodPlease',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: orange,
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
          ),
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.help_outline)),
      ],
    ),
  );
}

class _TrackingPanel extends StatelessWidget {
  const _TrackingPanel({required this.active, required this.onNext});
  final int active;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 22)],
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    active == 4 ? 'Pedido entregado' : '15–20 min',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    active == 4 ? '¡Que lo disfrutes!' : _message(active),
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(
                color: const Color(0xFFECEFF1),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Icon(
                    active == 4 ? Icons.check_circle : Icons.schedule,
                    size: 16,
                    color: active == 4 ? const Color(0xFF2E7D32) : charcoal,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    active == 4 ? 'Listo' : '14:30',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _HorizontalProgress(active: active),
        const Divider(height: 26),
        const Row(
          children: [
            CircleAvatar(
              radius: 23,
              backgroundColor: Color(0xFFFFE0D6),
              child: Icon(Icons.person, color: orange),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Martín R.',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  Text(
                    '★ 4,9 · 120+ entregas',
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              ),
            ),
            _ContactButton(icon: Icons.chat_bubble_outline),
            SizedBox(width: 7),
            _ContactButton(icon: Icons.phone_outlined),
          ],
        ),
        if (active < 4) ...[
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              onPressed: onNext,
              icon: const Icon(Icons.play_arrow, size: 18),
              label: const Text('Simular siguiente estado'),
              style: TextButton.styleFrom(foregroundColor: charcoal),
            ),
          ),
        ],
        const Center(
          child: Text(
            'Mapa real; ruta, ubicación y comunicaciones simuladas.',
            style: TextStyle(fontSize: 10, color: Colors.black45),
          ),
        ),
      ],
    ),
  );

  static String _message(int stage) => [
    'Pedido confirmado',
    'Preparando tu pedido',
    'Esperando al repartidor',
    'Tu pedido va en camino',
    'Entrega finalizada',
  ][stage];
}

class _HorizontalProgress extends StatelessWidget {
  const _HorizontalProgress({required this.active});
  final int active;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Row(
        children: List.generate(9, (index) {
          if (index.isOdd) {
            return Expanded(
              child: Container(
                height: 3,
                color: index ~/ 2 < active ? orange : Colors.black12,
              ),
            );
          }
          final step = index ~/ 2;
          final done = step <= active;
          return Container(
            width: step == active ? 14 : 10,
            height: step == active ? 14 : 10,
            decoration: BoxDecoration(
              color: done ? stageColors[step] : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: done ? stageColors[step] : Colors.black26,
                width: 2,
              ),
            ),
          );
        }),
      ),
      const SizedBox(height: 6),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          stages.length,
          (i) => SizedBox(
            width: 58,
            child: Text(
              stages[i],
              textAlign: i == 0
                  ? TextAlign.left
                  : i == 4
                  ? TextAlign.right
                  : TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                fontSize: 9,
                fontWeight: i == active ? FontWeight.w800 : FontWeight.w500,
                color: i <= active ? charcoal : Colors.black38,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

class _ContactButton extends StatelessWidget {
  const _ContactButton({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) => Container(
    width: 38,
    height: 38,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black12),
      shape: BoxShape.circle,
    ),
    child: Icon(icon, size: 19),
  );
}

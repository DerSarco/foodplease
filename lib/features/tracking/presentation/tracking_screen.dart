import 'package:flutter/material.dart';

import '../../../app/app_scope.dart';
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
  Widget build(BuildContext c) {
    final s = Scope.of(c), a = s.stage;
    final messages = [
      'El restaurante recibió tu pedido.',
      'Tu comida se está preparando.',
      'El pedido espera a su repartidor.',
      'Martín va rumbo a tu dirección.',
      'El pedido fue entregado correctamente.',
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedido #FP-2408'),
        backgroundColor: canvas,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                CustomPaint(
                  size: const Size(double.infinity, 250),
                  painter: RoutePainter(),
                ),
                const Positioned(
                  left: 30,
                  bottom: 32,
                  child: MapDot(Icons.home, Color(0xFF1976D2)),
                ),
                Positioned(
                  right: 38,
                  top: 32,
                  child: MapDot(
                    a >= 3 ? Icons.delivery_dining : Icons.restaurant,
                    a >= 4 ? stageColors[4] : charcoal,
                  ),
                ),
                Positioned(
                  left: 115 + a * 22,
                  top: 105,
                  child: const MapDot(Icons.delivery_dining, orange),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Text(
            a == 4 ? '¡Que lo disfrutes!' : stages[a],
            style: Theme.of(c).textTheme.headlineMedium,
          ),
          const SizedBox(height: 6),
          Text(
            messages[a],
            style: const TextStyle(color: Colors.black54, fontSize: 16),
          ),
          const SizedBox(height: 24),
          ...List.generate(5, (i) => Stage(i, a)),
          const SizedBox(height: 18),
          if (a < 4)
            OutlinedButton.icon(
              onPressed: s.next,
              icon: const Icon(Icons.play_arrow),
              label: const Text('Simular siguiente estado'),
              style: OutlinedButton.styleFrom(
                foregroundColor: charcoal,
                minimumSize: const Size.fromHeight(52),
              ),
            ),
          const SizedBox(height: 10),
          const Text(
            'Mapa, GPS, notificaciones y avance simulados.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black45, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class Stage extends StatelessWidget {
  const Stage(this.i, this.active, {super.key});
  final int i, active;
  @override
  Widget build(BuildContext c) {
    final done = i <= active;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: done ? stageColors[i] : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: done ? stageColors[i] : Colors.black26,
                  width: 2,
                ),
              ),
              child: Icon(
                stageIcons[i],
                size: 20,
                color: done ? Colors.white : Colors.black38,
              ),
            ),
            if (i < 4)
              Container(
                width: 3,
                height: 32,
                color: i < active ? stageColors[i + 1] : Colors.black12,
              ),
          ],
        ),
        const SizedBox(width: 14),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            stages[i],
            style: TextStyle(
              fontWeight: done ? FontWeight.w800 : FontWeight.w500,
              color: done ? charcoal : Colors.black38,
            ),
          ),
        ),
      ],
    );
  }
}

class MapDot extends StatelessWidget {
  const MapDot(this.icon, this.color, {super.key});
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext c) => Container(
    width: 46,
    height: 46,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white, width: 4),
      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
    ),
    child: Icon(icon, color: Colors.white, size: 23),
  );
}

class RoutePainter extends CustomPainter {
  @override
  void paint(Canvas c, Size s) {
    final p = Paint()
      ..color = const Color(0xFF90A4AE)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final path = Path()
      ..moveTo(52, s.height - 55)
      ..cubicTo(90, 150, 170, 190, 205, 115)
      ..cubicTo(240, 45, 300, 150, s.width - 60, 55);
    c.drawPath(path, p);
  }

  @override
  bool shouldRepaint(CustomPainter o) => false;
}

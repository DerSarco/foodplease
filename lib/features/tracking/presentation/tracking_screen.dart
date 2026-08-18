import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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

const deliveryRoute = <LatLng>[
  LatLng(-33.42385, -70.60840),
  LatLng(-33.42445, -70.61075),
  LatLng(-33.42595, -70.61220),
  LatLng(-33.42755, -70.61485),
  LatLng(-33.42915, -70.61735),
  LatLng(-33.43070, -70.62000),
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
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              height: 250,
              child: FlutterMap(
                options: const MapOptions(
                  initialCenter: LatLng(-33.42725, -70.61420),
                  initialZoom: 14.8,
                  minZoom: 12,
                  maxZoom: 18,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'cl.foodplease.foodplease',
                  ),
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: deliveryRoute,
                        color: orange,
                        strokeWidth: 5,
                        borderColor: Colors.white,
                        borderStrokeWidth: 2,
                      ),
                    ],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: deliveryRoute.first,
                        width: 48,
                        height: 48,
                        child: MapPin(
                          label: 'A',
                          icon: Icons.restaurant,
                          color: charcoal,
                        ),
                      ),
                      Marker(
                        point: deliveryRoute.last,
                        width: 48,
                        height: 48,
                        child: MapPin(
                          label: 'B',
                          icon: Icons.home,
                          color: Color(0xFF1976D2),
                        ),
                      ),
                      Marker(
                        point: deliveryRoute[[0, 0, 0, 3, 5][a]],
                        width: 46,
                        height: 46,
                        child: MapPin(
                          icon: Icons.delivery_dining,
                          color: a == 4 ? stageColors[4] : orange,
                        ),
                      ),
                    ],
                  ),
                  const SimpleAttributionWidget(
                    source: Text('© OpenStreetMap contributors'),
                    backgroundColor: Color(0xDDFFFFFF),
                  ),
                ],
              ),
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
            'Mapa real de OpenStreetMap; ruta, GPS y avance simulados.',
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

class MapPin extends StatelessWidget {
  const MapPin({
    super.key,
    required this.icon,
    required this.color,
    this.label,
  });
  final IconData icon;
  final Color color;
  final String? label;

  @override
  Widget build(BuildContext context) => Stack(
    alignment: Alignment.center,
    children: [
      Container(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 7)],
        ),
        child: Icon(icon, color: Colors.white, size: 21),
      ),
      if (label != null)
        Positioned(
          right: 0,
          top: 0,
          child: CircleAvatar(
            radius: 9,
            backgroundColor: Colors.white,
            child: Text(
              label!,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
    ],
  );
}

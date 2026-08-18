import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../theme/app_theme.dart';

const deliveryRoute = <LatLng>[
  LatLng(-33.42385, -70.60840),
  LatLng(-33.42445, -70.61075),
  LatLng(-33.42595, -70.61220),
  LatLng(-33.42755, -70.61485),
  LatLng(-33.42915, -70.61735),
  LatLng(-33.43070, -70.62000),
];

class DeliveryMap extends StatelessWidget {
  const DeliveryMap({super.key, required this.progressIndex});

  final int progressIndex;

  @override
  Widget build(BuildContext context) => FlutterMap(
    options: const MapOptions(
      initialCenter: LatLng(-33.42725, -70.61420),
      initialZoom: 14.8,
      minZoom: 12,
      maxZoom: 18,
    ),
    children: [
      TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
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
            child: const MapPin(
              label: 'A',
              icon: Icons.restaurant,
              color: charcoal,
            ),
          ),
          Marker(
            point: deliveryRoute.last,
            width: 48,
            height: 48,
            child: const MapPin(
              label: 'B',
              icon: Icons.home,
              color: Color(0xFF1976D2),
            ),
          ),
          Marker(
            point:
                deliveryRoute[progressIndex.clamp(0, deliveryRoute.length - 1)],
            width: 46,
            height: 46,
            child: MapPin(
              icon: Icons.delivery_dining,
              color: progressIndex == deliveryRoute.length - 1
                  ? const Color(0xFF2E7D32)
                  : orange,
            ),
          ),
        ],
      ),
      const SimpleAttributionWidget(
        source: Text('© OpenStreetMap contributors'),
        backgroundColor: Color(0xDDFFFFFF),
      ),
    ],
  );
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

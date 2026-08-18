import 'package:flutter/material.dart';

import '../../../app/app_scope.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../courier/presentation/courier_delivery_screen.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: const Text('Perfil'), backgroundColor: canvas),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Card(
          child: Padding(
            padding: EdgeInsets.all(18),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: orange,
                  child: Text(
                    'CM',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cliente Demo',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'cliente@foodplease.cl',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        const Info(
          Icons.location_on_outlined,
          'Direcciones',
          '1 dirección guardada',
        ),
        const Info(Icons.credit_card, 'Métodos de pago', 'Datos simulados'),
        const Info(
          Icons.notifications_outlined,
          'Notificaciones',
          'Preferencias de demostración',
        ),
        const SizedBox(height: 18),
        Text('Ecosistema integrado', style: Theme.of(c).textTheme.titleLarge),
        const SizedBox(height: 10),
        Card(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.storefront, color: orange),
                title: const Text('Vista restaurante'),
                subtitle: const Text('Recibe pedidos y actualiza preparación'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.push(
                  c,
                  MaterialPageRoute(
                    builder: (_) => const Partner('Restaurante'),
                  ),
                ),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.delivery_dining, color: orange),
                title: const Text('Vista repartidor'),
                subtitle: const Text('Acepta entrega y consulta ruta'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.push(
                  c,
                  MaterialPageRoute(
                    builder: (_) => const CourierDeliveryScreen(),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        OutlinedButton.icon(
          onPressed: () => Scope.of(c).logout(),
          icon: const Icon(Icons.logout),
          label: const Text('Cerrar sesión'),
          style: OutlinedButton.styleFrom(
            foregroundColor: charcoal,
            minimumSize: const Size.fromHeight(52),
          ),
        ),
      ],
    ),
  );
}

class Partner extends StatefulWidget {
  const Partner(this.role, {super.key});
  final String role;
  @override
  State<Partner> createState() => _Partner();
}

class _Partner extends State<Partner> {
  bool accepted = false;
  @override
  Widget build(BuildContext c) {
    final rest = widget.role == 'Restaurante';
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.role} · Demo'),
        backgroundColor: canvas,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: charcoal,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Icon(
                  rest ? Icons.storefront : Icons.delivery_dining,
                  color: orange,
                  size: 42,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rest ? 'Panel operativo' : 'Ruta asignada',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        rest
                            ? '1 pedido requiere atención'
                            : 'Pedido #FP-2408 · 2,4 km',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Pill('NUEVO', orange),
                      Spacer(),
                      Text(
                        '#FP-2408',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    rest ? '2 productos · Burger Lab' : 'Retiro en Burger Lab',
                    style: Theme.of(c).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    rest
                        ? 'Doble smash × 1 · Papas × 1'
                        : 'Entrega: Av. Providencia 1234',
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 18),
                  ElevatedButton(
                    onPressed: () => setState(() => accepted = true),
                    child: Text(
                      accepted
                          ? (rest
                                ? 'Pedido en preparación'
                                : 'Entrega aceptada')
                          : (rest ? 'Aceptar pedido' : 'Aceptar entrega'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Icon(
                rest ? Icons.analytics_outlined : Icons.route,
                size: 80,
                color: charcoal,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Vista mínima demostrativa. REST, GPS y asignación automática se representan con datos locales.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.black45),
          ),
        ],
      ),
    );
  }
}

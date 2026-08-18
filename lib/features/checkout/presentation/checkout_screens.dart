import 'package:flutter/material.dart';

import '../../../app/app_scope.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/currency.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../tracking/presentation/tracking_screen.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});
  @override
  State<Checkout> createState() => _Checkout();
}

class _Checkout extends State<Checkout> {
  String method = 'Tarjeta •••• 4242';
  @override
  Widget build(BuildContext c) {
    final s = Scope.of(c);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmar pedido'),
        backgroundColor: canvas,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Info(
            Icons.location_on_outlined,
            'Dirección de entrega',
            'Av. Providencia 1234, Depto. 56',
          ),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: ['Tarjeta •••• 4242', 'Efectivo al recibir']
                  .map(
                    (x) => ListTile(
                      onTap: () => setState(() => method = x),
                      leading: Icon(
                        method == x
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        color: method == x ? orange : Colors.black45,
                      ),
                      title: Text(x),
                      trailing: Icon(
                        x.startsWith('Tarjeta')
                            ? Icons.credit_card
                            : Icons.payments_outlined,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 12),
          const Info(Icons.schedule, 'Tiempo estimado', '30–40 minutos'),
          const SizedBox(height: 22),
          Summary('Total', money(s.total), bold: true),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: () {
              s.order();
              Navigator.pushReplacement(
                c,
                MaterialPageRoute(builder: (_) => const Success()),
              );
            },
            child: Text('Confirmar y pagar ${money(s.total)}'),
          ),
          const SizedBox(height: 10),
          const Text(
            'Esta acción simula el pago y la creación del pedido.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.black45),
          ),
        ],
      ),
    );
  }
}

class Success extends StatelessWidget {
  const Success({super.key});
  @override
  Widget build(BuildContext c) => Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 108,
              height: 108,
              decoration: const BoxDecoration(
                color: Color(0xFFE8F5E9),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                size: 68,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 28),
            Text(
              '¡Pedido confirmado!',
              style: Theme.of(c).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              '#FP-2408 ya fue recibido por el restaurante.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushReplacement(
                c,
                MaterialPageRoute(builder: (_) => const Tracking()),
              ),
              icon: const Icon(Icons.delivery_dining),
              label: const Text('Seguir pedido'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => Navigator.popUntil(c, (r) => r.isFirst),
              child: const Text('Volver al inicio'),
            ),
          ],
        ),
      ),
    ),
  );
}

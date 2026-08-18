import 'package:flutter/material.dart';

import '../../../app/app_scope.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/brand.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  final form = GlobalKey<FormState>();
  bool hide = true;
  @override
  Widget build(BuildContext c) => Scaffold(
    body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Form(
              key: form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Brand(),
                  const SizedBox(height: 48),
                  Text(
                    'Qué bueno verte',
                    style: Theme.of(c).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Ingresa para pedir tus favoritos y seguir cada entrega.',
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    initialValue: 'cliente@foodplease.cl',
                    decoration: const InputDecoration(
                      labelText: 'Correo',
                      prefixIcon: Icon(Icons.mail_outline),
                    ),
                    validator: (v) => v != null && v.contains('@')
                        ? null
                        : 'Ingresa un correo válido',
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    initialValue: 'demo1234',
                    obscureText: hide,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        onPressed: () => setState(() => hide = !hide),
                        icon: Icon(
                          hide
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                    validator: (v) => (v?.length ?? 0) >= 6
                        ? null
                        : 'Usa al menos 6 caracteres',
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (form.currentState!.validate()) Scope.of(c).login();
                    },
                    child: const Text('Ingresar'),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () => Navigator.push(
                      c,
                      MaterialPageRoute(builder: (_) => const Register()),
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(54),
                      foregroundColor: charcoal,
                    ),
                    child: const Text('Crear cuenta'),
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'MVP académico · autenticación y pagos simulados',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.black45),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {
  final form = GlobalKey<FormState>();
  bool ok = false;
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(backgroundColor: canvas),
    body: ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text('Crea tu cuenta', style: Theme.of(c).textTheme.headlineLarge),
        const SizedBox(height: 8),
        const Text('Todo listo para descubrir sabores cerca de ti.'),
        const SizedBox(height: 28),
        Form(
          key: form,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nombre completo',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (v) =>
                    (v?.trim().length ?? 0) > 2 ? null : 'Ingresa tu nombre',
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Correo',
                  prefixIcon: Icon(Icons.mail_outline),
                ),
                validator: (v) =>
                    v != null && v.contains('@') ? null : 'Correo inválido',
              ),
              const SizedBox(height: 12),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                validator: (v) =>
                    (v?.length ?? 0) >= 6 ? null : 'Mínimo 6 caracteres',
              ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: ok,
                activeColor: orange,
                onChanged: (v) => setState(() => ok = v ?? false),
                title: const Text('Acepto los términos de esta demostración.'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (form.currentState!.validate() && ok) {
                    Scope.of(c).login();
                    Navigator.pop(c);
                  } else if (!ok) {
                    ScaffoldMessenger.of(c).showSnackBar(
                      const SnackBar(
                        content: Text('Acepta los términos para continuar.'),
                      ),
                    );
                  }
                },
                child: const Text('Registrarme'),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

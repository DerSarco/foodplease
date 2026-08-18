# FoodPlease · MVP académico

Aplicación Flutter visual y navegable para APTC106, Semana 9, Sumativa 3. Continúa la propuesta del Grupo 11 y demuestra el ciclo completo de un pedido con datos locales.

## Demostración

- Correo precargado: `cliente@foodplease.cl`
- Contraseña precargada: `demo1234`
- El registro acepta cualquier nombre, correo válido y contraseña de 6 o más caracteres.
- Autenticación, pago, GPS, notificaciones, asignación y API son **simulaciones locales**.

## Funcionalidades implementadas

- Inicio de sesión y registro con validaciones básicas.
- Inicio con búsqueda, categorías y restaurantes ficticios consistentes.
- Detalle, menú y agregado al carrito.
- Carrito con suma/resta de cantidades, despacho y total.
- Selección de medio de pago simulado y confirmación.
- Seguimiento manual por cinco estados: recibido, preparación, listo, en camino y entregado.
- Historial, perfil y cierre de sesión.
- Estados vacíos para búsquedas, carrito y pedidos.
- Vistas demostrativas mínimas para restaurante y repartidor desde Perfil.
- Diseño responsive basado en Stitch para teléfono Android estándar (referencia 390 × 844).

## Ejecución

Requiere Flutter 3.47.0 y Dart 3.13.0.

```bash
flutter pub get
flutter run -d chrome
```

Para Android:

```bash
flutter emulators --launch medium_phone
flutter run -d medium_phone
```

Verificación:

```bash
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build web
flutter build apk --debug
```

## Arquitectura

El MVP usa una capa de estado local (`AppState`), modelos de dominio y pantallas Flutter. La evolución propuesta conserva la arquitectura previa:

```text
App cliente Flutter ─┐
Web restaurante ─────┼─ HTTPS/JSON → API REST → servicios → base central
App repartidor ──────┘                    ├ pagos/mapas/notificaciones
                                         └ asignación y reportes
```

En este repositorio solo la aplicación cliente está desarrollada como flujo completo. Las vistas de restaurante y repartidor son mockups interactivos acotados para explicar la integración. No existe backend ni sincronización real.

## Decisiones de diseño

- Sistema Stitch “Vibrant Velocity”: naranja `#FF5722`, carbón `#263238`, fondo `#F5F7F8`, Inter, retícula de 8 px y radios de 12 px.
- Jerarquía de alto contraste para acelerar búsqueda, elección y confirmación.
- Espectro logístico por estados: ámbar, celeste, naranja, morado y verde.
- Iconografía y gradientes propios de Material para no depender de assets con licencias externas ni red.
- Datos locales deterministas para que la evaluación sea repetible y funcione sin conexión.

El inventario de requisitos, pantallas y trazabilidad está en [`docs/INVENTARIO.md`](docs/INVENTARIO.md).

## Alcance pendiente

- API REST, persistencia, autenticación segura y autorización por roles.
- Pasarela de pago, mapas/GPS, notificaciones push y ubicación real.
- Gestión web completa de restaurante y app completa de repartidor.
- Accesibilidad ampliada, internacionalización y pruebas de integración/E2E.
- Publicación en GitHub: la instrucción académica la exige, pero este encargo prohíbe publicar sin autorización/conexión explícita.

## Evidencia

Las capturas verificadas están en `outputs/`. La compilación web queda en `build/web` y el APK de depuración, cuando se construye, en `build/app/outputs/flutter-apk/app-debug.apk`.

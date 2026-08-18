# Inventario y trazabilidad

## Fuentes académicas (instrucciones presentes en documentos)

- La plantilla de Semana 9 pide integrar la propuesta previa, desplegar en GitHub, realizar mockups móviles con primeras interacciones, y entregar un Word de máximo 8 páginas con URL, mockups e integración móvil/web.
- La rúbrica pondera análisis crítico (10 %), portada/índice/introducción (10 %), conclusiones (20 %), Git y primer commit (15 %), funcionamiento MVP (15 %) y mockups/integración (30 %).
- La propuesta previa define cliente móvil, restaurante web, repartidor móvil, API REST/JSON/HTTPS, servicios y base central; identifica seguimiento, GPS, asignación y notificaciones como mejoras.

## Requisitos añadidos por este encargo

- Implementar lógica local completa del cliente, pruebas, compilación, capturas, README y primer commit local.
- No publicar remotamente ni exponer secretos.
- Simular localmente servicios productivos y expresarlo de forma transparente.

## Inventario Stitch

Proyecto: “Ecosistema Digital FoodPlease Optimizado”. Referencias recuperadas:

1. Cliente - Inicio (móvil).
2. Cliente - Seguimiento Real-Time (móvil).
3. Restaurante - Gestión de Pedidos (escritorio).
4. Repartidor - Ruta de Entrega (móvil).

Tokens: naranja `#FF5722`, carbón `#263238`, fondo `#F5F7F8`, superficies blancas, Inter, base 8 px, margen móvil 16 px, tarjeta/botón 12 px, inputs tipo píldora. Estados: ámbar (recibido), celeste (preparación), naranja (listo), morado (en camino), verde (entregado).

## Trazabilidad funcional

| Requisito | Evidencia en MVP |
|---|---|
| Inicio de sesión | `Login`, datos demo y validación |
| Registro | `Register`, validaciones y aceptación |
| Restaurantes | `Home`, búsqueda, filtros y 3 locales |
| Detalle/menú | `RestaurantPage`, 3 productos por local |
| Carrito | `Cart`, cantidades, subtotal, envío y total |
| Confirmación | `Checkout` y `Success`, pago simulado |
| Seguimiento | `Tracking`, mapa ilustrativo y 5 estados |
| Historial/perfil | `Orders` y `Profile` |
| Integración | `Partner` para restaurante/repartidor y diagrama README |
| Estados vacíos | búsqueda, carrito y pedidos |

## Estructura interna

- `app`: composición, alcance de dependencias y estado coordinador.
- `core`: tema, formato monetario y widgets compartidos sin conocimiento de features.
- `features/auth`: acceso y registro.
- `features/catalog`: modelos de dominio, datos simulados y catálogo/menú.
- `features/cart`, `checkout` y `tracking`: etapas independientes del embudo de compra.
- `features/orders` y `profile`: historial, cuenta e integración con otros roles.
- `features/shell`: navegación primaria entre módulos.

Esta separación mantiene el MVP simple, pero permite reemplazar el catálogo simulado, extraer controladores por feature y agregar servicios REST sin concentrar nuevamente toda la aplicación en un único archivo.

## Guion de demostración

1. Ingresar con datos precargados.
2. Abrir Burger Lab, agregar Burger clásica y volver al carrito.
3. Cambiar cantidad y revisar el total.
4. Continuar, elegir pago, confirmar y abrir seguimiento.
5. Pulsar “Simular siguiente estado” hasta Entregado.
6. Revisar Pedidos y Perfil; abrir las dos vistas del ecosistema.

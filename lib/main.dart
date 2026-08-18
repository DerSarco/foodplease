import 'package:flutter/material.dart';

void main() => runApp(const FoodPleaseApp());
const orange = Color(0xFFFF5722),
    charcoal = Color(0xFF263238),
    canvas = Color(0xFFF5F7F8);
String money(int n) =>
    '\$${n.toString().replaceAllMapped(RegExp(r'(?=(\d{3})+(?!\d))'), (_) => '.')}';

class Food {
  const Food(this.name, this.desc, this.price, this.icon);
  final String name, desc;
  final int price;
  final IconData icon;
}

class Restaurant {
  const Restaurant(
    this.name,
    this.kind,
    this.rating,
    this.minutes,
    this.fee,
    this.colors,
    this.foods,
  );
  final String name, kind;
  final double rating;
  final int minutes, fee;
  final List<Color> colors;
  final List<Food> foods;
}

const restaurants = <Restaurant>[
  Restaurant(
    'Burger Lab',
    'Hamburguesas',
    4.8,
    25,
    990,
    [Color(0xFFFF8A65), Color(0xFFBF360C)],
    [
      Food(
        'Burger clásica',
        'Carne, cheddar, tomate y salsa de la casa',
        6490,
        Icons.lunch_dining,
      ),
      Food(
        'Doble smash',
        'Doble carne, cheddar, cebolla y pepinillos',
        7990,
        Icons.lunch_dining,
      ),
      Food(
        'Papas rústicas',
        'Papas sazonadas con salsa ahumada',
        3290,
        Icons.fastfood,
      ),
    ],
  ),
  Restaurant(
    'Sushi Nori',
    'Sushi',
    4.7,
    35,
    1490,
    [Color(0xFF80CBC4), Color(0xFF00695C)],
    [
      Food(
        'Nori mix 20',
        'Salmón, palta, camarón y queso crema',
        10990,
        Icons.set_meal,
      ),
      Food(
        'Veggie rolls 10',
        'Palta, pepino y pimentón asado',
        5990,
        Icons.eco,
      ),
      Food(
        'Gyozas',
        'Seis unidades de pollo y verduras',
        4490,
        Icons.rice_bowl,
      ),
    ],
  ),
  Restaurant(
    'Casa Pasta',
    'Italiana',
    4.6,
    30,
    1190,
    [Color(0xFFFFCC80), Color(0xFFEF6C00)],
    [
      Food(
        'Fettuccine pesto',
        'Pesto de albahaca, parmesano y nueces',
        8490,
        Icons.dinner_dining,
      ),
      Food(
        'Penne al ragú',
        'Salsa de tomate, carne y hierbas',
        8990,
        Icons.dinner_dining,
      ),
      Food('Tiramisú', 'Café, mascarpone y cacao', 4290, Icons.cake),
    ],
  ),
];

class Line {
  Line(this.restaurant, this.food, [this.qty = 1]);
  final Restaurant restaurant;
  final Food food;
  int qty;
}

class AppState extends ChangeNotifier {
  bool logged = false, ordered = false;
  int stage = 0;
  final cart = <Line>[];
  int get count => cart.fold(0, (s, x) => s + x.qty);
  int get subtotal => cart.fold(0, (s, x) => s + x.food.price * x.qty);
  int get fee => cart.isEmpty ? 0 : cart.first.restaurant.fee;
  int get total => subtotal + fee;
  void login() {
    logged = true;
    notifyListeners();
  }

  void logout() {
    logged = false;
    ordered = false;
    cart.clear();
    notifyListeners();
  }

  void add(Restaurant r, Food f) {
    final found = cart.where((x) => identical(x.food, f));
    found.isEmpty ? cart.add(Line(r, f)) : found.first.qty++;
    notifyListeners();
  }

  void change(Line x, int d) {
    x.qty += d;
    if (x.qty < 1) cart.remove(x);
    notifyListeners();
  }

  void order() {
    ordered = true;
    stage = 0;
    notifyListeners();
  }

  void next() {
    if (stage < 4) stage++;
    notifyListeners();
  }
}

class Scope extends InheritedNotifier<AppState> {
  const Scope({super.key, required AppState state, required super.child})
    : super(notifier: state);
  static AppState of(BuildContext c) =>
      c.dependOnInheritedWidgetOfExactType<Scope>()!.notifier!;
}

class FoodPleaseApp extends StatefulWidget {
  const FoodPleaseApp({super.key});
  @override
  State<FoodPleaseApp> createState() => _App();
}

class _App extends State<FoodPleaseApp> {
  final state = AppState();
  @override
  Widget build(BuildContext c) => Scope(
    state: state,
    child: AnimatedBuilder(
      animation: state,
      builder: (_, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FoodPlease',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Inter',
          scaffoldBackgroundColor: canvas,
          colorScheme: ColorScheme.fromSeed(
            seedColor: orange,
            primary: orange,
            secondary: charcoal,
            surface: Colors.white,
          ),
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
              fontWeight: FontWeight.w800,
              letterSpacing: -.7,
            ),
            headlineMedium: TextStyle(fontWeight: FontWeight.w700),
            titleLarge: TextStyle(fontWeight: FontWeight.w700),
            titleMedium: TextStyle(fontWeight: FontWeight.w700),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: const BorderSide(color: Color(0xFFECEFF1)),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 17,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: orange,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(54),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
          cardTheme: CardThemeData(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Color(0xFFEEEEEE)),
            ),
          ),
        ),
        home: state.logged ? const Shell() : const Login(),
      ),
    ),
  );
}

class Brand extends StatelessWidget {
  const Brand({super.key, this.small = false});
  final bool small;
  @override
  Widget build(BuildContext c) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: small ? 38 : 54,
        height: small ? 38 : 54,
        decoration: BoxDecoration(
          color: orange,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(
          Icons.delivery_dining,
          color: Colors.white,
          size: small ? 23 : 31,
        ),
      ),
      const SizedBox(width: 10),
      Text(
        'FoodPlease',
        style: TextStyle(
          fontSize: small ? 22 : 30,
          fontWeight: FontWeight.w900,
          color: charcoal,
          letterSpacing: -1,
        ),
      ),
    ],
  );
}

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

class Shell extends StatefulWidget {
  const Shell({super.key});
  @override
  State<Shell> createState() => _Shell();
}

class _Shell extends State<Shell> {
  int i = 0;
  @override
  Widget build(BuildContext c) {
    final s = Scope.of(c);
    final pages = [
      Home(openCart: () => setState(() => i = 1)),
      const Cart(),
      const Orders(),
      const Profile(),
    ];
    return Scaffold(
      body: IndexedStack(index: i, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: i,
        onDestinationSelected: (v) => setState(() => i = v),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: s.count > 0,
              label: Text('${s.count}'),
              child: const Icon(Icons.shopping_bag_outlined),
            ),
            selectedIcon: const Icon(Icons.shopping_bag),
            label: 'Carrito',
          ),
          const NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Pedidos',
          ),
          const NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key, required this.openCart});
  final VoidCallback openCart;
  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  String q = '', kind = 'Todos';
  @override
  Widget build(BuildContext c) {
    final s = Scope.of(c);
    final list = restaurants.where(
      (r) =>
          (kind == 'Todos' || r.kind == kind) &&
          r.name.toLowerCase().contains(q.toLowerCase()),
    );
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 74,
        backgroundColor: canvas,
        title: const Brand(small: true),
        actions: [
          IconButton(
            onPressed: widget.openCart,
            icon: Badge(
              isLabelVisible: s.count > 0,
              label: Text('${s.count}'),
              child: const Icon(Icons.shopping_bag_outlined),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          const Text(
            'ENTREGA EN',
            style: TextStyle(
              color: orange,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.1,
            ),
          ),
          const Row(
            children: [
              Icon(Icons.location_on, size: 19),
              SizedBox(width: 4),
              Text(
                'Av. Providencia 1234',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text(
            '¿Qué se te antoja hoy?',
            style: Theme.of(c).textTheme.headlineLarge,
          ),
          const SizedBox(height: 16),
          TextField(
            onChanged: (v) => setState(() => q = v),
            decoration: const InputDecoration(
              hintText: 'Busca restaurantes',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 42,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: ['Todos', 'Hamburguesas', 'Sushi', 'Italiana']
                  .map(
                    (x) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(x),
                        selected: kind == x,
                        selectedColor: orange,
                        labelStyle: TextStyle(
                          color: kind == x ? Colors.white : charcoal,
                          fontWeight: FontWeight.w700,
                        ),
                        onSelected: (_) => setState(() => kind = x),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 24),
          if (list.isEmpty)
            const Empty(
              icon: Icons.search_off,
              title: 'Sin resultados',
              message: 'Prueba otra búsqueda o categoría.',
            ),
          ...list.map((r) => RestaurantCard(r)),
        ],
      ),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  const RestaurantCard(this.r, {super.key});
  final Restaurant r;
  @override
  Widget build(BuildContext c) => Card(
    margin: const EdgeInsets.only(bottom: 18),
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: () => Navigator.push(
        c,
        MaterialPageRoute(builder: (_) => RestaurantPage(r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 158,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: r.colors),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 22,
                  bottom: -8,
                  child: Icon(
                    r.foods.first.icon,
                    color: Colors.white.withValues(alpha: .92),
                    size: 130,
                  ),
                ),
                const Positioned(
                  left: 16,
                  top: 16,
                  child: Pill('DESTACADO', charcoal),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        r.name,
                        style: Theme.of(c).textTheme.titleLarge,
                      ),
                    ),
                    const Icon(Icons.star, color: orange, size: 19),
                    Text(
                      ' ${r.rating}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: orange,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  '${r.kind}  •  ${r.minutes}-${r.minutes + 10} min  •  Envío ${money(r.fee)}',
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class RestaurantPage extends StatelessWidget {
  const RestaurantPage(this.r, {super.key});
  final Restaurant r;
  @override
  Widget build(BuildContext c) => Scaffold(
    body: CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 230,
          pinned: true,
          backgroundColor: r.colors.last,
          foregroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: r.colors),
              ),
              child: Center(
                child: Icon(
                  r.foods.first.icon,
                  size: 150,
                  color: Colors.white.withValues(alpha: .88),
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(r.name, style: Theme.of(c).textTheme.headlineLarge),
                const SizedBox(height: 7),
                Row(
                  children: [
                    const Icon(Icons.star, color: orange, size: 18),
                    Text(
                      ' ${r.rating}  •  ${r.minutes}-${r.minutes + 10} min  •  Envío ${money(r.fee)}',
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Text(
                  'Menú popular',
                  style: Theme.of(c).textTheme.headlineMedium,
                ),
                const Text(
                  'Preparado al momento para tu pedido.',
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 14),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (c, i) => FoodCard(r, r.foods[i]),
            childCount: r.foods.length,
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 30)),
      ],
    ),
  );
}

class FoodCard extends StatelessWidget {
  const FoodCard(this.r, this.f, {super.key});
  final Restaurant r;
  final Food f;
  @override
  Widget build(BuildContext c) => Card(
    margin: const EdgeInsets.fromLTRB(16, 0, 16, 14),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(f.name, style: Theme.of(c).textTheme.titleMedium),
                const SizedBox(height: 5),
                Text(f.desc, style: const TextStyle(color: Colors.black54)),
                const SizedBox(height: 12),
                Text(
                  money(f.price),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              Container(
                width: 82,
                height: 74,
                decoration: BoxDecoration(
                  color: r.colors.first.withValues(alpha: .3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(f.icon, size: 42, color: r.colors.last),
              ),
              const SizedBox(height: 6),
              OutlinedButton.icon(
                onPressed: () {
                  Scope.of(c).add(r, f);
                  ScaffoldMessenger.of(c).showSnackBar(
                    SnackBar(
                      content: Text('${f.name} agregado'),
                      duration: const Duration(milliseconds: 900),
                    ),
                  );
                },
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Agregar'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: orange,
                  side: const BorderSide(color: orange),
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class Cart extends StatelessWidget {
  const Cart({super.key});
  @override
  Widget build(BuildContext c) {
    final s = Scope.of(c);
    return Scaffold(
      appBar: AppBar(title: const Text('Tu carrito'), backgroundColor: canvas),
      body: s.cart.isEmpty
          ? const Empty(
              icon: Icons.shopping_bag_outlined,
              title: 'Tu carrito está vacío',
              message: 'Explora restaurantes y agrega algo delicioso.',
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  s.cart.first.restaurant.name,
                  style: Theme.of(c).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                ...s.cart.map(
                  (x) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Container(
                            width: 54,
                            height: 54,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFE0D6),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(x.food.icon, color: orange),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  x.food.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  money(x.food.price),
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => s.change(x, -1),
                            icon: const Icon(Icons.remove_circle_outline),
                          ),
                          Text(
                            '${x.qty}',
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                          IconButton(
                            onPressed: () => s.change(x, 1),
                            icon: const Icon(Icons.add_circle, color: orange),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Summary('Subtotal', money(s.subtotal)),
                Summary('Envío', money(s.fee)),
                const Divider(height: 28),
                Summary('Total', money(s.total), bold: true),
                const SizedBox(height: 18),
                ElevatedButton.icon(
                  onPressed: () => Navigator.push(
                    c,
                    MaterialPageRoute(builder: (_) => const Checkout()),
                  ),
                  icon: const Icon(Icons.lock_outline),
                  label: const Text('Continuar al pago'),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Pago simulado para fines académicos.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.black45),
                ),
              ],
            ),
    );
  }
}

class Summary extends StatelessWidget {
  const Summary(this.label, this.value, {super.key, this.bold = false});
  final String label, value;
  final bool bold;
  @override
  Widget build(BuildContext c) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: bold ? FontWeight.w800 : FontWeight.w400,
            fontSize: bold ? 19 : 15,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: bold ? FontWeight.w900 : FontWeight.w600,
            fontSize: bold ? 20 : 15,
          ),
        ),
      ],
    ),
  );
}

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

class Info extends StatelessWidget {
  const Info(this.icon, this.title, this.subtitle, {super.key});
  final IconData icon;
  final String title, subtitle;
  @override
  Widget build(BuildContext c) => Card(
    child: ListTile(
      contentPadding: const EdgeInsets.all(14),
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFFFE0D6),
        child: Icon(icon, color: orange),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.check_circle, color: Color(0xFF2E7D32)),
    ),
  );
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

class Orders extends StatelessWidget {
  const Orders({super.key});
  @override
  Widget build(BuildContext c) {
    final s = Scope.of(c);
    return Scaffold(
      appBar: AppBar(title: const Text('Mis pedidos'), backgroundColor: canvas),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (s.ordered)
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: CircleAvatar(
                  backgroundColor: stageColors[s.stage].withValues(alpha: .15),
                  child: Icon(stageIcons[s.stage], color: stageColors[s.stage]),
                ),
                title: Text(
                  '#FP-2408 · ${s.cart.first.restaurant.name}',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text('${stages[s.stage]} · ${money(s.total)}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.push(
                  c,
                  MaterialPageRoute(builder: (_) => const Tracking()),
                ),
              ),
            )
          else
            const Empty(
              icon: Icons.receipt_long_outlined,
              title: 'Aún no hay pedidos',
              message: 'Cuando confirmes uno, aparecerá aquí.',
            ),
          const SizedBox(height: 22),
          Text('Historial', style: Theme.of(c).textTheme.titleLarge),
          const SizedBox(height: 10),
          const History('Sushi Nori', '12 ago 2026', '\$16.470'),
          const History('Casa Pasta', '2 ago 2026', '\$13.970'),
        ],
      ),
    );
  }
}

class History extends StatelessWidget {
  const History(this.name, this.date, this.total, {super.key});
  final String name, date, total;
  @override
  Widget build(BuildContext c) => Card(
    child: ListTile(
      leading: const CircleAvatar(
        backgroundColor: Color(0xFFE8F5E9),
        child: Icon(Icons.check, color: Color(0xFF2E7D32)),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.w700)),
      subtitle: Text('$date · Entregado'),
      trailing: Text(
        total,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
  );
}

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
                    builder: (_) => const Partner('Repartidor'),
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

class Pill extends StatelessWidget {
  const Pill(this.text, this.color, {super.key});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext c) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 11,
        fontWeight: FontWeight.w800,
        letterSpacing: .7,
      ),
    ),
  );
}

class Empty extends StatelessWidget {
  const Empty({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  });
  final IconData icon;
  final String title, message;
  @override
  Widget build(BuildContext c) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 70, color: Colors.black26),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(c).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            message,
            style: const TextStyle(color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

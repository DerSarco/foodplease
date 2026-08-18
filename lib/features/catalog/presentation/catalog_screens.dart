import 'package:flutter/material.dart';

import '../../../app/app_scope.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/currency.dart';
import '../../../core/widgets/brand.dart';
import '../../../core/widgets/common_widgets.dart';
import '../data/mock_catalog.dart';
import '../domain/catalog_models.dart';

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

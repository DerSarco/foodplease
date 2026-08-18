import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class Summary extends StatelessWidget {
  const Summary(this.label, this.value, {super.key, this.bold = false});
  final String label, value;
  final bool bold;

  @override
  Widget build(BuildContext context) => Padding(
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

class Info extends StatelessWidget {
  const Info(this.icon, this.title, this.subtitle, {super.key});
  final IconData icon;
  final String title, subtitle;

  @override
  Widget build(BuildContext context) => Card(
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

String money(int n) =>
    '\$${n.toString().replaceAllMapped(RegExp(r"(?=(\\d{3})+(?!\\d))"), (_) => ".")}';

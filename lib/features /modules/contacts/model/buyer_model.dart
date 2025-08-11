class Buyer {
  final String id;       // stable key
  final String name;
  final String phone;
  final bool selected;

  const Buyer({
    required this.id,
    required this.name,
    required this.phone,
    this.selected = false,
  });

  Buyer copyWith({bool? selected}) =>
      Buyer(id: id, name: name, phone: phone, selected: selected ?? this.selected);

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'phone': phone,
    'selected': selected,
  };

  static Buyer fromMap(Map<String, dynamic> m) => Buyer(
    id: m['id'],
    name: m['name'],
    phone: m['phone'],
    selected: (m['selected'] ?? false) as bool,
  );
}

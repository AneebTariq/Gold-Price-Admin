class JewelryItem {
  final String? id;
  final String? name;
  final String? weight;
  final String? crt;
  final List<String>? imageUrls;

  JewelryItem( {
    required this.id,
    required this.name,
    required this.weight,
    required this.imageUrls,
    required this.crt,
  });

  factory JewelryItem.fromMap(String key, Map<dynamic, dynamic> map) {
    return JewelryItem(
      id: map['id'],
      name: map['name'],
      weight: map['weight'],
      crt: map['crt'],
      imageUrls: List<String>.from(map['imageUrls']),
    );
  }
}
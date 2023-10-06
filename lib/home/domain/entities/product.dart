class Product {
  final int id;
  int quantity;
  final String name;
  final String imageLink;
  final String price;
  final String description;
  final String rate;

  Product({
    required this.id,
    required this.name,
    required this.imageLink,
    required this.price,
    required this.quantity,
    required this.description,
    required this.rate,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return (other is Product && other.id == id);
  }

  @override
  int get hashCode => id.hashCode;
}

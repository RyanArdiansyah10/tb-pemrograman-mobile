class Product {
  int id;
  String name;
  double price;
  int qty;
  String attr;
  double weight;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.qty,
    required this.attr,
    required this.weight,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      qty: json['qty'],
      attr: json['attr'],
      weight: json['weight'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'qty': qty,
      'attr': attr,
      'weight': weight,
    };
  }
}

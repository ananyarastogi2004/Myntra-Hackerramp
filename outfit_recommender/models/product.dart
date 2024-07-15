// lib/models/product.dart
class Product {
  final int pid;
  final String name;
  final String description;
  final int price;
  final String img;
  final String category;
  final String subcategory;
  final String brand;
  final String colour;
  final String occasion;
  final String fabric;

  Product({
    required this.pid,
    required this.name,
    required this.description,
    required this.price,
    required this.img,
    required this.category,
    required this.subcategory,
    required this.brand,
    required this.colour,
    required this.occasion,
    required this.fabric,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      pid: map['p_id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      img: map['img'],
      category: map['category'],
      subcategory: map['subcategory'],
      brand: map['brand'],
      colour: map['colour'],
      occasion: map['occasion'],
      fabric: map['fabric'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pid': pid,
      'name': name,
      'description': description,
      'price': price,
      'img': img,
      'category': category,
      'subcategory': subcategory,
      'brand': brand,
      'colour': colour,
      'occasion': occasion,
      'fabric': fabric,
    };
  }
}

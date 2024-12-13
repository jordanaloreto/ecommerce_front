import 'package:ecommerce_front/models/sub_categoria.dart';

class Product {
  int id;
  String name;
  double price;
  int subCategoriaId;
  SubCategoria subCategoria;

  Product({
    required this.id, 
    required this.name, 
    required this.price,
    required this.subCategoriaId,
    required this.subCategoria,
    });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      subCategoriaId: json['sub_category_id'],
      subCategoria: SubCategoria.fromJson(json['sub_category']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'sub_category_id': subCategoriaId,
      'sub_category': subCategoria.toJson(),
    };
  }
}

class Categoria {
  int id;
  String name;

  Categoria({required this.id, required this.name});

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
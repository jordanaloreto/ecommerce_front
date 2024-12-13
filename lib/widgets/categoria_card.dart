import 'package:flutter/material.dart';
import '../controllers/categoria_controller.dart';
import '../models/categoria.dart';
import 'package:provider/provider.dart';

class CategoriaCard extends StatelessWidget {
  final Categoria categoria;

  CategoriaCard({required this.categoria}) : super(key: ValueKey(categoria.id));

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(categoria.name),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            Provider.of<CategoriaController>(context, listen: false)
                .removeCategoria(categoria.id);
          },
        ),
      ),
    );
  }
}
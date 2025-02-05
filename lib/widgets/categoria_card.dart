import 'package:flutter/material.dart';
import '../controllers/categoria_controller.dart';
import '../models/categoria.dart';
import 'package:provider/provider.dart';
import '../screens/add_categoria_popup.dart';

class CategoriaCard extends StatelessWidget {
  final Categoria categoria;

  CategoriaCard({required this.categoria}) : super(key: ValueKey(categoria.id));

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(categoria.name),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddCategoriaPopup(categoria: categoria);
                  },
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Provider.of<CategoriaController>(context, listen: false)
                    .removeCategoria(categoria.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/categoria_controller.dart';
import '../models/categoria.dart';

class AddCategoriaPopup extends StatefulWidget {
  @override
  _AddCategoriaPopupState createState() => _AddCategoriaPopupState();
}

class _AddCategoriaPopupState extends State<AddCategoriaPopup> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Adicionar Categoria'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Nome do Categoria'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe o nome do Categoria';
                }
                return null;
              },
              onSaved: (value) {
                _name = value!;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Adicionar'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final newCategoria = Categoria(id: 0, name: _name);
              Provider.of<CategoriaController>(context, listen: false)
                  .addCategoria(newCategoria);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
import '../controllers/categoria_controller.dart';
import '../controllers/sub_categoria_controller.dart';
import '../models/categoria.dart';
import '../models/sub_categoria.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddSubCategoriaPopup extends StatefulWidget {
  @override
  _AddSubCategoriaPopupState createState() => _AddSubCategoriaPopupState();
}

class _AddSubCategoriaPopupState extends State<AddSubCategoriaPopup> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  Categoria? _selectedCategoria;

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<CategoriaController>(context).categorias;

    return AlertDialog(
      title: Text('Adicionar Subcategoria'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Nome da Subcategoria'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe o nome da subcategoria';
                }
                return null;
              },
              onSaved: (value) {
                _name = value!;
              },
            ),
            DropdownButtonFormField<Categoria>(
              decoration: InputDecoration(labelText: 'Categoria'),
              items: categories.map((category) {
                return DropdownMenuItem<Categoria>(
                  value: category,
                  child: Text(category.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategoria = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Selecione uma categoria';
                }
                return null;
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
              final newSubCategoria = SubCategoria(
                id: 0,
                name: _name,
                categoriaId: _selectedCategoria!.id,
                categoria: _selectedCategoria!
              );
              Provider.of<SubCategoriaController>(context, listen: false)
                  .addSubCategoria(newSubCategoria);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
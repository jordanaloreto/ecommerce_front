import 'package:ecommerce_front/controllers/sub_categoria_controller.dart';
import 'package:ecommerce_front/models/sub_categoria.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/product_controller.dart';
import '../models/product.dart';

class AddProductPopup extends StatefulWidget {
  @override
  _AddProductPopupState createState() => _AddProductPopupState();
}

class _AddProductPopupState extends State<AddProductPopup> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  double _price = 0.0;
  SubCategoria? _selectedSubCategoria;

 @override
  Widget build(BuildContext context) {
    final subCategorias =
        Provider.of<SubCategoriaController>(context).subCategorias;
    return AlertDialog(
      title: Text('Adicionar Produto'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Nome do Produto'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe o nome do produto';
                }
                return null;
              },
              onSaved: (value) {
                _name = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Preço do Produto'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || double.tryParse(value) == null) {
                  return 'Informe um preço válido';
                }
                return null;
              },
              onSaved: (value) {
                _price = double.parse(value!);
              },
            ),
            DropdownButtonFormField<SubCategoria>(
              decoration: InputDecoration(labelText: 'Subcategoria'),
              items: subCategorias.map((subCategoria) {
                return DropdownMenuItem<SubCategoria>(
                  value: subCategoria,
                  child: Text(subCategoria.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedSubCategoria = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Selecione uma subcategoria';
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
              final newProduct = Product(
              id: 0, 
              name: _name, 
              price: _price,
              subCategoriaId: _selectedSubCategoria!.id,
              subCategoria: _selectedSubCategoria!,
              );
              Provider.of<ProductController>(context, listen: false)
                  .addProduct(newProduct);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
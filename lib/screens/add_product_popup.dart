import 'package:ecommerce_front/controllers/sub_categoria_controller.dart';
import 'package:ecommerce_front/models/sub_categoria.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/product_controller.dart';
import '../models/product.dart';

class AddProductPopup extends StatefulWidget {
  final Product? product;

  AddProductPopup({this.product});

  @override
  _AddProductPopupState createState() => _AddProductPopupState();
}

class _AddProductPopupState extends State<AddProductPopup> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late double _price;
  SubCategoria? _selectedSubCategory;

  @override
  void initState() {
    super.initState();
    _name = widget.product?.name ?? '';
    _price = widget.product?.price ?? 0.0;
    _selectedSubCategory = widget.product?.subCategoria;
  }

  @override
  Widget build(BuildContext context) {
    final subCategories =
        Provider.of<SubCategoriaController>(context).subCategorias;

    // Ensure _selectedSubCategory is an object from the subCategories list
    if (_selectedSubCategory != null && subCategories.isNotEmpty) {
      _selectedSubCategory = subCategories.firstWhere(
        (subCategory) => subCategory.id == _selectedSubCategory!.id,
        orElse: () => _selectedSubCategory!,
      );
    }

    return AlertDialog(
      title: Text(widget.product == null ? 'Adicionar Produto' : 'Editar Produto'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: _name,
              decoration: InputDecoration(labelText: 'Nome do Produto'),
              validator: (value) => value == null || value.isEmpty ? 'Informe o nome do produto' : null,
              onSaved: (value) => _name = value!,
            ),
            TextFormField(
              initialValue: _price.toString(),
              decoration: InputDecoration(labelText: 'Preço do Produto'),
              keyboardType: TextInputType.number,
              validator: (value) => value == null || double.tryParse(value) == null ? 'Informe um preço válido' : null,
              onSaved: (value) => _price = double.parse(value!),
            ),
            DropdownButtonFormField<SubCategoria>(
              decoration: InputDecoration(labelText: 'Subcategoria'),
              value: _selectedSubCategory,
              items: subCategories.map((subCategory) {
                return DropdownMenuItem<SubCategoria>(
                  value: subCategory,
                  child: Text(subCategory.name),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedSubCategory = value),
              validator: (value) => value == null ? 'Selecione uma subcategoria' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancelar'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text(widget.product == null ? 'Adicionar' : 'Salvar'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              final newProduct = Product(
                id: widget.product?.id ?? 0, // Garante que mantém o ID na edição
                name: _name,
                price: _price,
                subCategoriaId: _selectedSubCategory!.id,
                subCategoria: _selectedSubCategory!,
              );

              final controller = Provider.of<ProductController>(context, listen: false);

              if (widget.product == null) {
                controller.addProduct(newProduct);
              } else {
                controller.updateProduct(newProduct);
              }

              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
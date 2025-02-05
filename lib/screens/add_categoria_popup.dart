import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/categoria_controller.dart';
import '../models/categoria.dart';

class AddCategoriaPopup extends StatefulWidget {
  final Categoria? categoria;

  AddCategoriaPopup({this.categoria});

  @override
  _AddCategoriaPopupState createState() => _AddCategoriaPopupState();
}

class _AddCategoriaPopupState extends State<AddCategoriaPopup> {
  final _formKey = GlobalKey<FormState>();
  late String _name;

  @override
  void initState() {
    super.initState();
    _name = widget.categoria?.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.categoria == null ? 'Adicionar Categoria' : 'Editar Categoria'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          initialValue: _name,
          decoration: InputDecoration(labelText: 'Nome da Categoria'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Informe o nome da Categoria';
            }
            return null;
          },
          onSaved: (value) {
            _name = value!;
          },
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancelar'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text(widget.categoria == null ? 'Adicionar' : 'Salvar'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final controller = Provider.of<CategoriaController>(context, listen: false);
              if (widget.categoria == null) {
                controller.addCategoria(Categoria(id: 0, name: _name));
              } else {
                controller.updateCategoria(Categoria(id: widget.categoria!.id, name: _name));
              }
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}

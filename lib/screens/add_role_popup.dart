import '../controllers/role_controller.dart';
import '../models/role.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRolePopup extends StatefulWidget {
  final Role? role; // Parâmetro opcional para edição

  AddRolePopup({this.role}); // Construtor atualizado

  @override
  _AddRolePopupState createState() => _AddRolePopupState();
}

class _AddRolePopupState extends State<AddRolePopup> {
  final _formKey = GlobalKey<FormState>();
  late String _name;

  @override
  void initState() {
    super.initState();
    // Inicializa o campo com o nome da role, se estiver no modo de edição
    _name = widget.role?.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.role == null ? 'Adicionar Role' : 'Editar Role'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: _name, // Preenche o campo com o nome da role
              decoration: InputDecoration(labelText: 'Nome do Role'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe o nome do Role';
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
          child: Text(widget.role == null ? 'Adicionar' : 'Salvar'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              final roleController =
                  Provider.of<RoleController>(context, listen: false);

              if (widget.role == null) {
                // Modo de adição
                final newRole = Role(id: 0, name: _name);
                roleController.addRole(newRole);
              } else {
                // Modo de edição
                final updatedRole = Role(id: widget.role!.id, name: _name);
                roleController.updateRole(updatedRole);
              }

              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
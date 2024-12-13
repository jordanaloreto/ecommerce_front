import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/role_controller.dart';
import '../controllers/user_controller.dart';
import '../models/role.dart';
import '../models/user.dart';

class AddUserPopup extends StatefulWidget {
  @override
  _AddUserPopupState createState() => _AddUserPopupState();
}

class _AddUserPopupState extends State<AddUserPopup> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _password = '';
  Role? _selectedRole;

  @override
  Widget build(BuildContext context) {
    final roles =
        Provider.of<RoleController>(context).roles;

    return AlertDialog(
      title: Text('Adicionar User'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Nome do User'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe o nome do User';
                }
                return null;
              },
              onSaved: (value) {
                _name = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Senha'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe a Senha';
                }
                return null;
              },
              onSaved: (value) {
                _password = value!;
              },
            ),
            DropdownButtonFormField<Role>(
              decoration: InputDecoration(labelText: 'Role'),
              items: roles.map((role) {
                return DropdownMenuItem<Role>(
                  value: role,
                  child: Text(role.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedRole = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Selecione uma role';
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
              final newUser = User(
                id: 0,
                userName: _name,
                password: _password,
                roleId: _selectedRole!.id,
                role: _selectedRole!,
              );
              Provider.of<UserController>(context, listen: false)
                  .addUser(newUser);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
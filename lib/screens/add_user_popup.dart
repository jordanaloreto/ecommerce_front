import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/role_controller.dart';
import '../controllers/user_controller.dart';
import '../models/role.dart';
import '../models/user.dart';

class AddUserPopup extends StatefulWidget {
  final User? user;

  AddUserPopup({this.user});

  @override
  _AddUserPopupState createState() => _AddUserPopupState();
}

class _AddUserPopupState extends State<AddUserPopup> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _password = '';
  Role? _selectedRole;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _name = widget.user!.userName;
      _password = widget.user!.password;

      // Aguarda o carregamento dos roles antes de definir o _selectedRole
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final roles = Provider.of<RoleController>(context, listen: false).roles;
        setState(() {
          _selectedRole = roles.firstWhere(
            (role) => role.id == widget.user!.roleId,
          );
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final roles = Provider.of<RoleController>(context).roles;

    return AlertDialog(
      title: Text(widget.user == null ? 'Adicionar User' : 'Editar User'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: _name,
              decoration: InputDecoration(labelText: 'Nome do User'),
              validator: (value) => value == null || value.isEmpty ? 'Informe o nome do User' : null,
              onSaved: (value) => _name = value!,
            ),
            TextFormField(
              initialValue: _password,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
              validator: (value) => value == null || value.isEmpty ? 'Informe a Senha' : null,
              onSaved: (value) => _password = value!,
            ),
            DropdownButtonFormField<Role>(
              decoration: InputDecoration(labelText: 'Role'),
              value: roles.contains(_selectedRole) ? _selectedRole : null,
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
              validator: (value) => value == null ? 'Selecione uma role' : null,
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
          child: Text(widget.user == null ? 'Adicionar' : 'Atualizar'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              final userController = Provider.of<UserController>(context, listen: false);

              if (widget.user == null) {
                final newUser = User(
                  id: DateTime.now().millisecondsSinceEpoch,
                  userName: _name,
                  password: _password,
                  roleId: _selectedRole!.id,
                  role: _selectedRole!,
                );
                userController.addUser(newUser);
              } else {
                final updatedUser = User(
                  id: widget.user!.id,
                  userName: _name,
                  password: _password,
                  roleId: _selectedRole!.id,
                  role: _selectedRole!,
                );
                userController.updateUser(updatedUser.id, updatedUser);
              }
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}

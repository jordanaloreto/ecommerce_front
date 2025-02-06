import '../controllers/role_controller.dart';
import '../models/role.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/add_role_popup.dart';

class RoleCard extends StatelessWidget {
  final Role role;

  RoleCard({required this.role}) : super(key: ValueKey(role.id));

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(role.name),
        trailing: Row(
          mainAxisSize: MainAxisSize.min, // Para alinhar os ícones corretamente
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                // Abre o AddRolePopup no modo de edição
                showDialog(
                  context: context,
                  builder: (context) => AddRolePopup(role: role),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Provider.of<RoleController>(context, listen: false)
                    .removeRole(role.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:frontend/view_models/user.view_model.dart';
import 'package:frontend/widgets/dialogs/edit_user_credentials.dialog.dart';
import 'package:frontend/widgets/dialogs/edit_user_info.dialog.dart';
import 'package:provider/provider.dart';

import '../../../../di/app.module.dart';
import '../../../../models/user.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  Future<void> Function() _showEditCredentialsDialog(BuildContext context, User user, {bool isPassword = false}) {
    return () async {
      await showDialog(
        context: context,
        builder: (BuildContext ctx) => EditUserCredentialsDialog.onCreate(user, isPassword),
      );
    };
  }

  Future<void> Function() _showEditInfoDialog(BuildContext context, User user) {
    return () async {
      await showDialog(
        context: context,
        builder: (BuildContext ctx) => EditUserInfoDialog.onCreate(user),
      );
    };
  }

  Widget _getProfilePicture(BuildContext context, String? url) {
    final viewModel = context.read<UserViewModel>();

    return GestureDetector(
      child: CircleAvatar(
        radius: 100,
        backgroundColor: Colors.blueGrey,
        backgroundImage: url != null ? NetworkImage(url) : null,
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PopupMenuItem(
                    onTap: viewModel.updatePictureHandler,
                    child: const Text('Изменить картинку'),
                  ),
                  PopupMenuItem(
                    onTap: viewModel.deletePictureHandler,
                    child: const Text('Удалить картинку'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _getProfileItem({
    required IconData icon,
    required String label,
    required String value,
    required Future<void> Function() onEdit,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      subtitle: Text(value),
      trailing: TextButton(
        onPressed: onEdit,
        child: const Icon(Icons.edit),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<UserViewModel>();
    final User? user = viewModel.getUserOrNull();

    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: user == null
                ? const LinearProgressIndicator()
                : SizedBox(
                    width: 500,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: _getProfilePicture(context, user.profilePicture),
                        ),
                        const Divider(),
                        _getProfileItem(
                          icon: Icons.email,
                          label: 'E-mail',
                          value: user.email,
                          onEdit: _showEditCredentialsDialog(context, user),
                        ),
                        const Divider(),
                        _getProfileItem(
                          icon: Icons.password,
                          label: 'Пароль',
                          value: '********',
                          onEdit: _showEditCredentialsDialog(context, user, isPassword: true),
                        ),
                        const Divider(),
                        _getProfileItem(
                          icon: Icons.text_fields,
                          label: 'Имя',
                          value: user.firstName,
                          onEdit: _showEditInfoDialog(context, user),
                        ),
                        const Divider(),
                        _getProfileItem(
                          icon: Icons.text_fields,
                          label: 'Фамилия',
                          value: user.lastName,
                          onEdit: _showEditInfoDialog(context, user),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.logout,
        child: const Icon(Icons.logout),
      ),
    );
  }

  static Widget onCreate() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => injector.get<UserViewModel>(param1: context),
      child: const UserPage(),
    );
  }
}

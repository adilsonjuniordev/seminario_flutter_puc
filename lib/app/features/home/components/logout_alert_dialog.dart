import 'package:flutter/material.dart';

class LogoutAlertDialog extends StatefulWidget {
  const LogoutAlertDialog({super.key});

  @override
  State<LogoutAlertDialog> createState() => LogoutAlertDialogState();
}

class LogoutAlertDialogState extends State<LogoutAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Text('Fazer Logout'),
      content: const Text('Tem certeza que deseja sair?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text('Sair'),
        )
      ],
    );
  }
}

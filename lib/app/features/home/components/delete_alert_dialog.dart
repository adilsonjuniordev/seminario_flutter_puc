import 'package:flutter/material.dart';

class DeleteAlertDialog extends StatefulWidget {
  const DeleteAlertDialog({super.key});

  @override
  State<DeleteAlertDialog> createState() => _DeleteAlertDialogState();
}

class _DeleteAlertDialogState extends State<DeleteAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Text('Excluir Tarefa'),
      content: const Text('Tem certeza que deseja excluir esta task?'),
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
          child: const Text('Excluir'),
        )
      ],
    );
  }
}

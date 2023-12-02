import 'package:flutter/material.dart';
import 'package:puc_minas/app/core/components/custom_snackbar.dart';
import 'package:puc_minas/app/core/components/dialog.dart';
import 'package:puc_minas/app/core/constants/app_routes.dart';
import 'package:puc_minas/app/features/home/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Conta'),
        actions: [
          IconButton(
            onPressed: () async {
              if (await logout()) {
                if (mounted) {
                  CustomSnackbar.success(
                    context: context,
                    message: 'Você foi deslogado com sucesso',
                  );
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.login,
                    (route) => false,
                  );
                }
              } else {
                if (mounted) {
                  CustomSnackbar.error(
                    context: context,
                    message: 'Houve um problema ao fazer logout',
                  );
                }
              }
            },
            icon: const Icon(Icons.login_outlined),
          )
        ],
      ),
      body: Container(),
    );
  }
}

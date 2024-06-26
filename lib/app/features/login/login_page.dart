import 'package:flutter/material.dart';
import 'package:puc_minas/app/core/components/custom_snackbar.dart';
import 'package:puc_minas/app/core/components/dialog.dart';
import 'package:puc_minas/app/core/constants/app_routes.dart';
import 'package:puc_minas/app/features/login/login_controller.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final controller = LoginController();

  final emailEC = TextEditingController();
  final nameEC = TextEditingController();
  final ageEC = TextEditingController();
  final passwordEC = TextEditingController();

  bool marcaCheckBox = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        leading: Navigator.of(context).canPop()
            ? IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_circle_left_outlined,
                  size: 34,
                ),
              )
            : null,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: emailEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Email é obrigatório'),
                      Validatorless.email('Este email é inválido'),
                    ]),
                    decoration: const InputDecoration(hintText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    onTapOutside: (pointer) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: nameEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Nome é obrigatório'),
                    ]),
                    decoration: const InputDecoration(hintText: 'Nome'),
                    keyboardType: TextInputType.name,
                    onTapOutside: (pointer) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: ageEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Idade é obrigatório'),
                      Validatorless.number('Aceita somente números'),
                    ]),
                    decoration: const InputDecoration(hintText: 'Idade'),
                    keyboardType: TextInputType.number,
                    onTapOutside: (pointer) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: passwordEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha é obrigatória'),
                      Validatorless.min(8, 'Senha muito fraca (mín. 8 caracteres)'),
                    ]),
                    decoration: const InputDecoration(hintText: 'Senha'),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    onTapOutside: (pointer) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  const SizedBox(height: 15),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        showLoader(context);
                        bool isLogged = await controller.login(
                          email: emailEC.text,
                          password: passwordEC.text,
                          name: nameEC.text,
                          age: int.tryParse(ageEC.text) ?? 0,
                        );

                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }

                        if (isLogged) {
                          if (context.mounted) {
                            CustomSnackbar.success(context: context, message: 'Seja bem-vindo(a)');
                            Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
                          }
                        } else {
                          if (context.mounted) {
                            CustomSnackbar.error(context: context, message: 'Usuário ou senha inválidos');
                          }
                        }
                      }
                    },
                    child: const Text('Fazer login', style: TextStyle(fontSize: 24)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

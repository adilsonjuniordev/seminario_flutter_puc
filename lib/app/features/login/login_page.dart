import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final emailEC = TextEditingController();
  final cpfEC = TextEditingController();
  final passwordEC = TextEditingController();
  final passwordConfirmEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_circle_left_outlined,
            size: 34,
          ),
        ),
      ),
      body: Center(
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
                  controller: cpfEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('CPF é obrigatório'),
                    Validatorless.cpf('CPF inválido'),
                  ]),
                  decoration: const InputDecoration(hintText: 'CPF'),
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
                    Validatorless.min(8, 'Senha muito fraca'),
                  ]),
                  decoration: const InputDecoration(hintText: 'Senha'),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  onTapOutside: (pointer) {
                    FocusScope.of(context).unfocus();
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: passwordConfirmEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('Confirma senha é obrigatório'),
                    Validatorless.min(8, 'Senha muito fraca'),
                    Validatorless.compare(passwordEC, 'Senhas não conferem'),
                  ]),
                  decoration: const InputDecoration(hintText: 'Confirma senha'),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  onTapOutside: (pointer) {
                    FocusScope.of(context).unfocus();
                  },
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    formKey.currentState?.validate();
                  },
                  child: const Text('Fazer login', style: TextStyle(fontSize: 24)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

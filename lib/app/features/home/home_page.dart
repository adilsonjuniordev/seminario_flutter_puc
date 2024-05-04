import 'package:flutter/material.dart';
import 'package:puc_minas/app/core/models/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:puc_minas/app/core/constants/app_routes.dart';
import 'package:puc_minas/app/core/modals/add_item_modal.dart';
import 'package:puc_minas/app/features/home/home_controller.dart';
import 'package:puc_minas/app/core/components/custom_snackbar.dart';
import 'package:puc_minas/app/features/home/components/task_card.dart';
import 'package:puc_minas/app/features/home/components/user_panel.dart';
import 'package:puc_minas/app/features/home/components/delete_alert_dialog.dart';
import 'package:puc_minas/app/features/home/components/logout_alert_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences sp;
  List<TaskModel> tasks = [];
  String? name;
  String? age;

  final controller = HomeController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      sp = await SharedPreferences.getInstance();
      name = sp.getString('name');
      age = sp.getInt('age').toString();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Conta'),
        actions: [
          IconButton(
            onPressed: () async {
              bool? signOut = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return const LogoutAlertDialog();
                },
              );

              if (signOut ?? false) {
                try {
                  await controller.logout();
                  if (context.mounted) {
                    CustomSnackbar.warning(
                      context: context,
                      message: 'Você foi deslogado com sucesso',
                    );
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.login,
                      (route) => false,
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    CustomSnackbar.error(
                      context: context,
                      message: 'Houve um problema ao fazer logout',
                    );
                  }
                }
              }
            },
            icon: const Icon(Icons.login_outlined),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var task = await showDialog<TaskModel?>(
            context: context,
            builder: (context) {
              return const Dialog(
                insetPadding: EdgeInsets.all(0),
                child: AddItemModal(),
              );
            },
          );
          if (task != null) {
            tasks.add(task);
            setState(() {});
          }
        },
        backgroundColor: Colors.lightGreen,
        elevation: 10,
        foregroundColor: Colors.white,
        tooltip: 'Adicionar',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 110),
        child: Column(
          children: [
            UserPanel(name: name, age: age),
            const SizedBox(height: 10),
            tasks.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: tasks.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: UniqueKey(),
                          confirmDismiss: (direction) async {
                            bool? deleted = await showDialog<bool>(
                              context: context,
                              builder: (context) {
                                return const DeleteAlertDialog();
                              },
                            );

                            if (deleted ?? false) {
                              try {
                                tasks.removeAt(index);
                                if (context.mounted) {
                                  CustomSnackbar.warning(
                                    context: context,
                                    message: 'A tarefa foi excluída!',
                                  );
                                }
                                setState(() {});
                              } catch (e) {
                                if (context.mounted) {
                                  CustomSnackbar.error(
                                    context: context,
                                    message: 'Erro ao excluir tarefa!',
                                  );
                                }
                              }
                            }
                            return deleted ?? false;
                          },
                          child: TaskCard(tasks: tasks, index: index),
                        );
                      },
                    ),
                  )
                : const Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.list_alt_outlined, size: 36),
                          SizedBox(height: 10),
                          Text('Nenhuma Task no momento!', style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

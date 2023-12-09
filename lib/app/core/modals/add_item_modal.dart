import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:puc_minas/app/core/components/custom_snackbar.dart';
import 'package:puc_minas/app/core/models/task_model.dart';
import 'package:validatorless/validatorless.dart';

class AddItemModal extends StatefulWidget {
  const AddItemModal({super.key});

  @override
  State<AddItemModal> createState() => _AddItemModalState();
}

class _AddItemModalState extends State<AddItemModal> {
  final formkey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final descriptionEC = TextEditingController();
  final ImagePicker picker = ImagePicker();

  XFile? image;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      height: height * 0.85,
      width: width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Form(
        key: formkey,
        child: Column(
          children: [
            const Text(
              'Nova Tarefa',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: nameEC,
              validator: Validatorless.required('Campo é obrigatório'),
              decoration: const InputDecoration(hintText: 'Nome da Tarefa'),
              keyboardType: TextInputType.text,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: descriptionEC,
              maxLines: 2,
              validator: Validatorless.required('Campo é obrigatório'),
              decoration: const InputDecoration(hintText: 'Descrição da Tarefa'),
              keyboardType: TextInputType.text,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const Text(
              'Adicionar Foto (Opcional)',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    image = await picker.pickImage(source: ImageSource.gallery);
                    setState(() {});
                  },
                  icon: const Icon(Icons.photo),
                  label: const Text('Galeria'),
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blueGrey),
                    elevation: MaterialStatePropertyAll(2),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    image = await picker.pickImage(source: ImageSource.camera);
                    setState(() {});
                  },
                  icon: const Icon(Icons.camera_alt_rounded),
                  label: const Text('Câmera'),
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blueGrey),
                    elevation: MaterialStatePropertyAll(2),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            image != null
                ? Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(20),
                        height: width * 0.4,
                        width: width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: FileImage(File(image!.path)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                          onPressed: () {
                            image = null;
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.remove_circle,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  )
                : const Spacer(),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (formkey.currentState?.validate() ?? false) {
                    var task = TaskModel(
                      name: nameEC.text,
                      description: descriptionEC.text,
                      image: image,
                    );

                    CustomSnackbar.success(
                      context: context,
                      message: 'Tarefa salva com sucesso',
                    );

                    Navigator.of(context).pop(task);
                  }
                },
                child: const Text(
                  'Salvar Tarefa',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  )),
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:puc_minas/app/core/models/task_model.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.tasks, required this.index});

  final List<TaskModel> tasks;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightGreen.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(7),
      child: Row(
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nome da Tarefa: ${tasks[index].name}',
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  'Descrição da Tarefa: ${tasks[index].description}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          if (tasks[index].image != null)
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 1.5),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: FileImage(File(tasks[index].image!.path)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:image_picker/image_picker.dart';

class TaskModel {
  final String name;
  final String description;
  final XFile? image;

  TaskModel({
    required this.name,
    required this.description,
    this.image,
  });

  @override
  String toString() => 'TaskModel(name: $name, description: $description, image: $image)';
}

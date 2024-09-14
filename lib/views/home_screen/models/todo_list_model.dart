import 'package:hive/hive.dart';

part 'todo_list_model.g.dart';  // Add this line to link the generated file


@HiveType(typeId: 1)
class ToDoListItemModel {
  @HiveField(1)
  final String heading;

  @HiveType(typeId: 2)
  final String description;

// Convert the model to a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'heading': heading,
      'description': description,
    };
  }

  // Factory constructor to create a model from a Map<String, dynamic>
  factory ToDoListItemModel.fromMap(Map<String, dynamic> map) {
    return ToDoListItemModel(
      heading: map['heading'] as String,
      description: map['description'] as String,
    );
  }

  ToDoListItemModel({
    required this.heading,
    required this.description,
  });
}

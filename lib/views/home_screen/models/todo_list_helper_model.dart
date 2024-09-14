class TodoListItemHelperModel {
  final String heading, description;
  final int itemKey;


  // Convert the model to a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'heading': heading,
      'description': description,
      'itemKey' : itemKey
    };
  }

  // Factory constructor to create a model from a Map<String, dynamic>
  factory TodoListItemHelperModel.fromMap(Map<String, dynamic> map) {
    return TodoListItemHelperModel(
      heading: map['heading'] as String,
      description: map['description'] as String,
      itemKey: map['itemKey'] as int,
    );
  }


  TodoListItemHelperModel(
      {required this.itemKey,
      required this.description,
      required this.heading});
}

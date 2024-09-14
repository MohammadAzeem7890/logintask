import 'package:hive/hive.dart';

import '../utils/constants.dart';
import '../views/home_screen/models/todo_list_model.dart';

class HiveDB {
  static Map getToDoList(Box<ToDoListItemModel> box) {
    return box.toMap();
  }

  static void addDataToHive(
      {required Box<ToDoListItemModel> box, required dynamic item}) {
    box.add(item);
  }


  static void updateEntryToHive(
      {required int key,
      required ToDoListItemModel listItemModel,
      required Box<ToDoListItemModel> box}) async {
    await box.put(key, listItemModel);
  }

  static Future<void> deleteEntryFromHive(
      Box<ToDoListItemModel> box, int key) async {
    await box.delete(key); // delete using key
  }
}

import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:login_task/network/hive_db.dart';
import 'package:login_task/network/network.dart';
import 'package:login_task/views/home_screen/bloc/home_state.dart';
import 'package:login_task/views/home_screen/models/todo_list_model.dart';

import '../../../helper_functions/global_functions.dart';
import '../../../utils/constants.dart';
import '../models/todo_list_helper_model.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeBlocInitial());

  static final Box<ToDoListItemModel> _box = Hive.box(Constants.toDoBox);

  Map _todoData = {};

  getToDoListFromHive() {
    print("this is get data ");
    emit(HomeBlocDataLoading());
    print("this is get data $state");
    try {
      final data = HiveDB.getToDoList(_box);
      print("this is to do data $data");
      emit(HomeBlocDataLoadSuccess());
      _todoData = data;
      print("this is to do data $_todoData");
      return data;
    } catch (e) {
      print("exception in get in home bloc : $e");
      emit(HomeBlocDataLoadFailed());
    }
  }

  postDataToFirebase() async {
    try {
      List<TodoListItemHelperModel> itemList = [];

      _todoData.forEach((key, value) {
        itemList.add(TodoListItemHelperModel(
            itemKey: key,
            description: value.description,
            heading: value.heading));
      });

      var response = await FirebaseDB.postListItemToFirebase(itemList);

      print("this is reponse: $response");
    } catch (e) {
      print("could not post data to firebase: $e");
    }
  }

  syncDataWithFirebase() async {
    if (kDebugMode) {
      print("begin");
    }
    // post data to firebase every six hours
    Future.delayed(const Duration(seconds: 1), () async {
      try {
        if (_todoData.isNotEmpty) {
          // post local data to firebase
          postDataToFirebase();
        }
      } catch (e) {
        if (kDebugMode) {
          print("could not sync hive and firebase $e");
        }
      }
    });
  }

  // Function to delete data from Hive
  Future<void> deleteToDoItem(int key, context) async {
    try {
      if (_box.keys.contains(key)) {
        await HiveDB.deleteEntryFromHive(_box, key);
        emit(HomeDeleteSuccess());
        showSnackBar("Delete Success", context);
      } else {
        showSnackBar("Delete Failed", context);
        emit(HomeDeleteFailed()); // Emit failure if key not found
      }
    } catch (e) {
      showSnackBar("Delete Failed", context);
      emit(HomeDeleteFailed());
    }
  }

  getErrorMessage(HomeState state) {
    switch (state) {
      case HomeBlocDataLoadFailed _:
        return "Could not load todo List : $state";
      default:
        return "An unexpected error has occurred! : $state";
    }
  }

  getMappedToDoHelperModel(ToDoListItemModel itemModel, int itemKey) {
    final helperItemModel = TodoListItemHelperModel(
        itemKey: itemKey,
        description: itemModel.description,
        heading: itemModel.heading);
    return helperItemModel;
  }

  Color getRandomColors() {
    List<Color> colors = const [
      Color(0xFF6A1B9A), // Purple
      Color(0xFF00897B), // Teal
      Color(0xFFF57C00), // Orange
      Color(0xFF1976D2), // Blue
      Color(0xFF388E3C), // Green
    ];
    Random random = Random();
    int index = random
        .nextInt(colors.length); // Get a random index within the list range
    return colors[index];
  }
}

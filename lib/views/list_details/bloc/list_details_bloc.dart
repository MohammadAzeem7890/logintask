import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:login_task/helper_functions/global_functions.dart';
import 'package:login_task/network/hive_db.dart';

import '../../../utils/constants.dart';
import '../../../validations/validations.dart';
import '../../home_screen/models/todo_list_helper_model.dart';
import '../../home_screen/models/todo_list_model.dart';
import 'list_details_state.dart';

class ListDetailsBloc extends Cubit<ListDetailsState> {
  ListDetailsBloc() : super(GetListDetailsInitial());

  final Box<ToDoListItemModel> _box = Hive.box(Constants.toDoBox);

  addEntryToHive(final heading, final description, context) {
    print(" in add entry to hive function");
    emit(ListDetailsLoading());
    try {
      print(" in try add entry to hive function");
      ToDoListItemModel itemModel =
      ToDoListItemModel(heading: heading, description: description);
      HiveDB.addDataToHive(box: _box, item: itemModel);
      print(" in add entry to hive success");
      emit(AddListDetailsSuccess());
    } catch (e) {
      print(" in add entry to hive failure");
      emit(AddListDetailsSuccess());
      showSnackBar(e.toString(), context);
    }
  }

  updateItemEntry(
      {required context, required TodoListItemHelperModel helperModel}) async {
    emit(UpdateListDetailsLoading());
    try {
      final ToDoListItemModel listItemModel = ToDoListItemModel(
          heading: helperModel.heading, description: helperModel.description);
      HiveDB.updateEntryToHive(
          key: helperModel.itemKey, listItemModel: listItemModel, box: _box);
      emit(UpdateListDetailsSuccess());
      showSnackBar("Data Updated Successfully", context);
    } catch (e) {
      emit(UpdateListDetailsFailure());
      showSnackBar(e.toString(), context);
    }
  }

  validateEntry(
      {required String heading,
        required String description,
        required context}) {
    final bool isHeadingEmpty = Validations.isTextFieldEmpty(heading);
    final bool isDescriptionEmpty = Validations.isTextFieldEmpty(description);
    if (!isHeadingEmpty && !isDescriptionEmpty) {
      addEntryToHive(heading, description, context);
    } else if (isHeadingEmpty) {
      showSnackBar("heading", context);
    } else if (isDescriptionEmpty) {
      showSnackBar("desc", context);
    } else {
      showSnackBar("message other", context);
    }
  }

  // Function to delete data from Hive
  Future<void> deleteToDoItem(int key, context) async {
    try {
      if (_box.keys.contains(key)) {
        await HiveDB.deleteEntryFromHive(_box, key);
        emit(DeleteListDetailsSuccess());
        showSnackBar("Delete Success", context);
      } else {
        showSnackBar("Delete Failed", context);

        emit(DeleteListDetailsFailed()); // Emit failure if key not found
      }
    } catch (e) {
      showSnackBar("Delete Failed", context);

      emit(DeleteListDetailsFailed());
    }
  }
}
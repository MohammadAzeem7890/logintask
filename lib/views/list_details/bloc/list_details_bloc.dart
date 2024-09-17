
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

  addEntryToHive(final heading, final description ) {

    emit(ListDetailsLoading());
    try {

      ToDoListItemModel itemModel =
      ToDoListItemModel(heading: heading, description: description);
      HiveDB.addDataToHive(box: _box, item: itemModel);

      emit(AddListDetailsSuccess());
    } catch (e) {

      emit(AddListDetailsSuccess());
      showToast(e.toString(), );
    }
  }

  updateItemEntry(
      {required , required TodoListItemHelperModel helperModel}) async {
    emit(UpdateListDetailsLoading());
    try {
      final ToDoListItemModel listItemModel = ToDoListItemModel(
          heading: helperModel.heading, description: helperModel.description);
      HiveDB.updateEntryToHive(
          key: helperModel.itemKey, listItemModel: listItemModel, box: _box);
      emit(UpdateListDetailsSuccess());
      showToast("Data Updated Successfully", );
    } catch (e) {
      emit(UpdateListDetailsFailure());
      showToast(e.toString(), );
    }
  }

  validateEntry(
      {required String heading,
        required String description,
        required }) {
    final bool isHeadingEmpty = Validations.isTextFieldEmpty(heading);
    final bool isDescriptionEmpty = Validations.isTextFieldEmpty(description);
    if (!isHeadingEmpty && !isDescriptionEmpty) {
      addEntryToHive(heading, description, );
    } else if (isHeadingEmpty) {
      showToast("heading", );
    } else if (isDescriptionEmpty) {
      showToast("desc", );
    } else {
      showToast("message other", );
    }
  }

  // Function to delete data from Hive
  Future<void> deleteToDoItem(int key, ) async {
    try {
      if (_box.keys.contains(key)) {
        await HiveDB.deleteEntryFromHive(_box, key);
        emit(DeleteListDetailsSuccess());
        showToast("Delete Success", );
      } else {
        showToast("Delete Failed", );

        emit(DeleteListDetailsFailed()); // Emit failure if key not found
      }
    } catch (e) {
      showToast("Delete Failed", );

      emit(DeleteListDetailsFailed());
    }
  }
}
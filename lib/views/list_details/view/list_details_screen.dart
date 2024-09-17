import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../helper_functions/global_functions.dart';
import '../../../validations/validations.dart';
import '../../../widgets/primary_scaffold.dart';
import '../../../widgets/primary_textfield.dart';
import '../../home_screen/models/todo_list_helper_model.dart';
import '../bloc/list_details_bloc.dart';
import 'list_view_widgets/save_or_update_button.dart';

class ListDetailsScreen extends StatefulWidget {
  const ListDetailsScreen({super.key});

  @override
  State<ListDetailsScreen> createState() => _ListDetailsScreenState();
}

class _ListDetailsScreenState extends State<ListDetailsScreen> {
  final TextEditingController _headingController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  int? toDoItemKey;

  assignDataToFields() {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as TodoListItemHelperModel?;
    if (arguments.toString() != "null") {
      _headingController.text = arguments!.heading;
      _descriptionController.text = arguments.description;
      toDoItemKey = arguments.itemKey;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    assignDataToFields();
  }

  @override
  void dispose() {
    _headingController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      appBar: appBarWidget(
        title: "List Details",
        isBackIconVisible: true,
        onBack: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              PrimaryTextField(
                controller: _headingController,
                label: "Heading",
                validator: Validations.validateHeading,
                hintText: "Enter heading here...",
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 20,
              ),
              PrimaryTextField(
                controller: _descriptionController,
                maxLines: 6,
                validator: Validations.validateDescription,
                hintText: "Enter description here...",
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onSubmit: (_) => onSubmit(),
              ),
              const SizedBox(
                height: 50,
              ),
              SaveOrUpdateButton(
                isUpdateButton: isUpdateButton(),
                onDelete: onDelete,
                onSubmit: onSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  isUpdateButton() {
    return toDoItemKey.toString() != "null";
  }

  onSubmit() {
    isUpdateButton() ? onUpdate() : onAdd();
  }

  onAdd() {
    final listDetailCubit = context.read<ListDetailsBloc>();
    listDetailCubit.validateEntry(
        description: _descriptionController.text,
        heading: _headingController.text,
        );
  }

  onUpdate() {
    final listDetailCubit = context.read<ListDetailsBloc>();
    if (toDoItemKey.toString() != "null") {
      final TodoListItemHelperModel helperModel = getItemHelperData();
      listDetailCubit.updateItemEntry(
          helperModel: helperModel);
    }
  }

  TodoListItemHelperModel getItemHelperData() {
    String heading = _headingController.text;
    String description = _descriptionController.text;
    int itemKey = toDoItemKey!;
    final TodoListItemHelperModel helperModel = TodoListItemHelperModel(
        heading: heading, description: description, itemKey: itemKey);
    return helperModel;
  }

  onDelete() {
    final listDetailCubit = context.read<ListDetailsBloc>();
    if (toDoItemKey.toString() != "null") {
      listDetailCubit.deleteToDoItem(toDoItemKey!);
    }
  }
}

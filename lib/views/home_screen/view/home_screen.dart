import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widgets/primary_circular_bar.dart';
import '../../../widgets/primary_scaffold.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
import '../models/todo_list_helper_model.dart';
import '../models/todo_list_model.dart';
import 'package:login_task/helper_functions/global_functions.dart';
import 'home_widgets/centered_error_text.dart';
import 'home_widgets/todo_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final TextEditingController _noteHeadingController = TextEditingController();
  final TextEditingController _noteDescriptionController =
      TextEditingController();

  final HomeBloc _homeBloc = HomeBloc();

  _initiateAnimatedController() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 350), vsync: this);
  }

  Map _todoData = {};

  getListItems() {
    final homeBloc = context.read<HomeBloc>();
   _todoData = homeBloc.getToDoListFromHive();
  }

  syncDataWithFirebase() {
    final homeBloc = context.read<HomeBloc>();
    homeBloc.syncDataWithFirebase();
  }

  onDeleteItem(dynamic key) {
    final homeBloc = context.read<HomeBloc>();
    homeBloc.deleteToDoItem(key, context);
  }

  navigateToListDetailScreen(ToDoListItemModel itemModel, int itemKey) {
    final helperItemModel =
        _homeBloc.getMappedToDoHelperModel(itemModel, itemKey);

    Navigator.pushNamed(
      context,
      '/list_details',
      arguments: helperItemModel,
    );
  }

  String getErrorMessage(state) {
    final errorMessage = _homeBloc.getErrorMessage(state);
    return errorMessage;
  }

  @override
  void initState() {
    getListItems();
    syncDataWithFirebase();
    _initiateAnimatedController();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _noteHeadingController.dispose();
    _noteDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
        appBar: appBarWidget(title: "ToDo List"),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).pushNamed("/list_details"),
          child: const Icon(Icons.add),
        ),
        body: BlocConsumer<HomeBloc, HomeState>(builder: (context, state) {
          final listItems = _todoData.values.toList();
          if (state is HomeBlocDataLoading) {
            return const PrimaryCircularBar();
          } else if (state is HomeBlocDataLoadSuccess) {
            if (listItems.isEmpty) {
              return const CenteredErrorText(text: "No Todos Found");
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: listItems.length,
                        itemBuilder: (context, index) {
                          final ToDoListItemModel itemModel = listItems[index];
                          final int itemKey =
                          _todoData.keys.toList()[index];
                          return ToDoListItem(
                              onTap: () => navigateToListDetailScreen(
                                  itemModel, itemKey),
                              circleAvatarColor: _homeBloc.getRandomColors(),
                              description: itemModel.description,
                              heading: itemModel.heading,
                              onDelete: () => onDeleteItem(itemKey));
                        }),
                  ],
                ),
              ),
            );
          }
          return CenteredErrorText(text: getErrorMessage(state));
        }, listener: (context, state) {
          if (state is HomeDeleteSuccess) {
            getListItems();
          }
        }));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widgets/primary_button.dart';
import '../../bloc/list_details_bloc.dart';
import '../../bloc/list_details_state.dart';

class SaveOrUpdateButton extends StatelessWidget {
  final Function() onSubmit, onDelete;
  final bool isUpdateButton;

  const SaveOrUpdateButton(
      {super.key,
        required this.onDelete,
        required this.onSubmit,
        required this.isUpdateButton});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListDetailsBloc, ListDetailsState>(
        builder: (context, state) {
          if (state is DeleteListDetailsLoading) {
            return const CircularProgressIndicator();
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: PrimaryButton(
                  text: isUpdateButton ? "Update" : "Add",
                  onPressed: onSubmit,
                  textColor: Colors.white,
                  buttonColor: Colors.green,
                ),
              ),
              const SizedBox(width: 15,),
              Expanded(
                child: PrimaryButton(
                  text: "Delete",
                  textColor: Colors.white,
                  onPressed: onDelete,
                  buttonColor: Colors.red,
                ),
              ),
            ],
          );
        }, listener: (context, state) {
      if (state is AddListDetailsSuccess ||
          state is UpdateListDetailsSuccess ||
          state is DeleteListDetailsSuccess) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }
}
import 'package:flutter/material.dart';
import 'package:login_task/utils/app_colors.dart';

import '../../../../widgets/primary_ink_well.dart';
import '../../../../widgets/primary_text.dart';

class ToDoListItem extends StatelessWidget {
  final String heading, description;
  final Color circleAvatarColor;
  final Function() onDelete, onTap;
  const ToDoListItem(
      {super.key,
      required this.description,
      required this.onTap,
      required this.circleAvatarColor,
      required this.heading,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 15,
                  color: Colors.black12,
                  spreadRadius: 0,
                  blurStyle: BlurStyle.outer)
            ]),
        child: PrimaryInkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 12,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: circleAvatarColor),
                  child: Center(
                    child: PrimaryText(
                      text: heading.isNotEmpty ? heading[0].toString() : "E",
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PrimaryText(
                        text: heading.toString(),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        maxLines: 2,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      PrimaryText(
                        text: description.toString(),
                        fontSize: 14,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
                PrimaryInkWell(
                  onTap: onDelete,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: IgnorePointer(
                        ignoring: true,
                        child: Icon(
                          Icons.delete_forever,
                          size: 28,
                          color: Colors.red,
                        )),
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

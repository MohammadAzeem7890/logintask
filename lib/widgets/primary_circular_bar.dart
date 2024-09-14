import 'package:flutter/material.dart';
import 'package:login_task/utils/app_colors.dart';

class PrimaryCircularBar extends StatelessWidget {
  final Color color;
  const PrimaryCircularBar({super.key, this.color = AppColors.headingColor});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: color,),);
  }
}
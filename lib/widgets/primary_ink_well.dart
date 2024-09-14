import 'package:flutter/material.dart';

class PrimaryInkWell extends StatelessWidget {
  final Function() onTap;
  final Widget child;
  final double radius;

  const PrimaryInkWell(
      {super.key, required this.onTap, required this.child, this.radius = 15});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
        onTap: onTap,
        child: child,
      ),
    );
  }
}
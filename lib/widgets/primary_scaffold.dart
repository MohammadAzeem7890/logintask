import 'package:flutter/material.dart';

class PrimaryScaffold extends StatelessWidget {
  final Widget body;
  final Color? backgroundColor;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;
  const PrimaryScaffold(
      {super.key,
        required this.body,
        this.backgroundColor,
        this.floatingActionButton,
        this.appBar});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: backgroundColor,
          appBar: appBar,
          floatingActionButton: floatingActionButton,
          body: body,
        ));
  }
}
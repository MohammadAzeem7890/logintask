import 'package:flutter/material.dart';

import '../../../../widgets/primary_text.dart';


class CenteredErrorText extends StatelessWidget {
  final String text;
  const CenteredErrorText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Center(
        child: PrimaryText(
          text: text,
          maxLines: 3,
          align: TextAlign.center,
          color: Colors.black,
        ),
      ),
    );
  }
}
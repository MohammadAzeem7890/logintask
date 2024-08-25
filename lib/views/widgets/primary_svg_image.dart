import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_task/utils/app_assets.dart';

class PrimarySvgImage extends StatelessWidget {
  final String assetName;
  const PrimarySvgImage({super.key, required this.assetName});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppAssets.svgImagePath + assetName,
      semanticsLabel: "",
      alignment: Alignment.topLeft,
    );
  }
}

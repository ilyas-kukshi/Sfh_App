import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/constants.dart';

void reusableLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.2), // Soft dim background
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const _BlurLoader();
    },
  );
}

class _BlurLoader extends StatelessWidget {
  const _BlurLoader();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blurred background
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
          child:
              Container(color: Colors.transparent), // Required for blur to show
        ),

        // Centered loader
        Center(
          child: CircularProgressIndicator(
            color: AppThemeShared.secondaryColor,
          ),
        ),
      ],
    );
  }
}

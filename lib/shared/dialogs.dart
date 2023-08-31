import 'package:flutter/material.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';

class DialogShared {
  static loadingDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: AlertDialog(
            contentPadding: const EdgeInsets.symmetric(horizontal: 32),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: Column(
              children: [
                const SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  text,
                  style: const TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static doubleButtonDialog(BuildContext context, String text,
      void Function()? yesClicked, void Function()? noClicked) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(horizontal: 32),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Column(
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppThemeShared.sharedRaisedButton(
                      context: context,
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.2,
                      color: Colors.green,
                      buttonText: "Yes",
                      onPressed: yesClicked),
                  AppThemeShared.sharedRaisedButton(
                      context: context,
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.2,
                      color: Colors.red,
                      buttonText: "No",
                      onPressed: noClicked)
                ],
              )
            ],
          ),
        );
      },
    );
  }

  static singleButtonDialog(
    BuildContext context,
    String text,
    String buttonText,
    void Function()? onClicked,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(horizontal: 32),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Column(
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              AppThemeShared.sharedRaisedButton(
                  context: context,
                  height: 45,
                  borderRadius: 12,
                  width: MediaQuery.of(context).size.width * 0.3,
                  color: AppThemeShared.primaryColor,
                  buttonText: "Ohk",
                  onPressed: onClicked),
            ],
          ),
        );
      },
    );
  }
}

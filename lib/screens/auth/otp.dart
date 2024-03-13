import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sfh_app/services/auth/auth_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/utility.dart';
import 'package:sms_autofill/sms_autofill.dart';

class Otp extends ConsumerStatefulWidget {
  final Map<String, String> authDetails;
  const Otp({super.key, required this.authDetails});

  @override
  ConsumerState<Otp> createState() => _OtpState();
}

class _OtpState extends ConsumerState<Otp> {
  bool otpIncorrect = false;
  bool otpMatched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemeShared.appBar(
          title: "Otp",
          context: context,
          backButton: false,
          textStyle: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text(
                "Please enter the verification code we've sent you on +91-${widget.authDetails["phoneNumber"]}",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.black.withOpacity(0.6)),
              ),
              PinFieldAutoFill(
                  autoFocus: true,
                  // cursor: Cursor(height: 20, width: 4, color: Colors.black),
                  decoration: UnderlineDecoration(
                      errorText: otpIncorrect ? "Otp is wrong" : "",
                      colorBuilder: FixedColorBuilder(AppThemeShared
                          .primaryColor)), // UnderlineDecoration, BoxLooseDecoration or BoxTightDecoration see https://github.com/TinoGuo/pin_input_text_field for more info,
                  currentCode: "", // prefill with a code
                  onCodeSubmitted: (otp) async {
                    if (otp == widget.authDetails["otp"]) {
                      setState(() {
                        otpMatched = true;
                      });
                      await checIfUserExists();
                    } else {
                      Fluttertoast.showToast(msg: "Otp is incorrect");
                    }
                  }, //code submitted callback
                  onCodeChanged: (otp) {}, //code changed callback
                  codeLength: 6 //code length, default 6
                  ),
              const SizedBox(height: 30),
              otpMatched ? const CircularProgressIndicator() : const Offstage()
            ],
          ),
        ),
      ),
    );
  }

  checIfUserExists() async {
    String? token =
        await AuthService().login("91${widget.authDetails["phoneNumber"]}");

    if (token != null) {
      await Utility().setStringSF("token", token);
      Navigator.pushNamed(context, '/bottomNav', arguments: 0);
    } else {
      Fluttertoast.showToast(msg: "Authentication Failed");
    }
  }
}

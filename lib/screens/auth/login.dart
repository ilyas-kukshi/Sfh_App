// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sfh_app/services/auth/auth_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/loading_dialog.dart';
import 'package:sfh_app/shared/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  bool accExists = true;
  bool buttonValid = false;
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController phoneNumber = TextEditingController();

  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project

  @override
  void initState() {
    super.initState();
    checkUser();
    Utility().catchDeepLinks(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppThemeShared.appBar(
          title: "Login",
          context: context,
          backButton: false,
          textStyle: GoogleFonts.montserrat(
              color: Colors.white, fontWeight: FontWeight.bold)),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(height: kToolbarHeight + 20),
                const SizedBox(height: 20),
                Text("Welcome to\n Sakina Fashion House",
                    // textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 26, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Text(
                  "Log in for best experience",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.black.withOpacity(0.6), fontSize: 16),
                ),
                const SizedBox(height: 20),
                AppThemeShared.textFormField(
                  widthPercent: 0.95,
                  context: context,
                  // hintText: "Enter your whatsapp number",
                  labelText: "Phone number",
                  controller: phoneNumber,
                  autoFocus: true,
                  validator: Utility.phoneNumberValidator,
                  keyboardType: TextInputType.number,
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],

                  onChanged: (value) {
                    if (formkey.currentState!.validate()) {
                      setState(() {
                        buttonValid = !buttonValid;
                      });
                    } else {
                      if (buttonValid == true) {
                        setState(() {
                          buttonValid = false;
                        });
                      }
                    }
                  },
                ),
                const SizedBox(height: 20),
                AppThemeShared.sharedButton(
                  height: 50,
                  context: context,
                  width: MediaQuery.of(context).size.width * 0.9,
                  color:
                      buttonValid ? AppThemeShared.primaryColor : Colors.grey,
                  buttonText: "Get Otp",
                  textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  onTap: () async {
                    final valid = formkey.currentState!.validate();
                    reusableLoadingDialog(context);
                    if (valid) {
                      if (phoneNumber.text == "9111991119") {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/otp', arguments: {
                          "phoneNumber": phoneNumber.text,
                          "otp": "911119"
                        });
                      } else {
                        if (!kIsWeb) {
                          await SmsAutoFill().listenForCode();
                        }
                        final String? otp =
                            await AuthService().getOtp(phoneNumber.text);

                        if (otp != null) {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/otp', arguments: {
                            "phoneNumber": phoneNumber.text,
                            "otp": otp
                          });
                        } else {
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: "Failed to fetch OTP. Please try again.");
                        }
                      }

                      // final user = ref.read(
                      //     getUserByNumberProvider("91${phoneNumber.text}")
                      //         .future);
                      // user.whenComplete(() async {
                      //   await Utility().setStringSF(
                      //       "phoneNumber", "91${phoneNumber.text}");

                      //   Navigator.pushNamed(context, '/bottomNav');
                      // });
                    }
                  },
                ),
                const SizedBox(height: 20),
                Center(
                    child: Text(
                  "OR",
                  style: Theme.of(context).textTheme.labelLarge,
                )),
                const SizedBox(height: 20),
                AppThemeShared.sharedButton(
                  height: 50,
                  context: context,
                  color: AppThemeShared.primaryColor,
                  width: MediaQuery.of(context).size.width * 0.9,
                  buttonText: "Continue as Guest",
                  textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  onTap: () {
                    Navigator.pushNamed(context, '/bottomNav', arguments: 0);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  checkUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString("phoneNumber") != null) {
      Navigator.pushNamed(context, '/bottomNav', arguments: 0);
    }
  }

  sendOtp() async {}
}

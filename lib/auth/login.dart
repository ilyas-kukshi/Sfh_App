import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/utility.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool accExists = true;

  TextEditingController phoneNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppThemeShared.appBar(
      //     title: "Login", context: context, backButton: false),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "Welcome to",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                "Sakina Fashion House",
                style: TextStyle(
                    color: AppThemeShared.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              const SizedBox(height: 10),
              AppThemeShared.textFormField(
                  context: context,
                  hintText: "Enter your whatsapp number",
                  controller: phoneNumber,
                  validator: Utility.phoneNumberValidator,
                  keyboardType: TextInputType.number,
                  inputFormatters: [LengthLimitingTextInputFormatter(10)]),
              const SizedBox(height: 10),
              AppThemeShared.sharedButton(
                height: 50,
                context: context,
                width: MediaQuery.of(context).size.width * 0.85,
                buttonText: "Get Otp",
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
  sendOtp()async {
  }
}

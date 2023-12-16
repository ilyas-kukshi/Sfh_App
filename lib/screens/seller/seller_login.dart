// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sfh_app/models/auth/auth_model.dart';
import 'package:sfh_app/services/auth/auth_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SellerLogin extends ConsumerStatefulWidget {
  const SellerLogin({super.key});

  @override
  ConsumerState<SellerLogin> createState() => _SellerLoginState();
}

class _SellerLoginState extends ConsumerState<SellerLogin> {
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemeShared.appBar(title: "Seller Area", context: context),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                AppThemeShared.textFormField(
                  context: context,
                  controller: phoneNumber,
                  hintText: 'Phone number',
                  validator: Utility.phoneNumberValidator,
                  keyboardType: TextInputType.number,
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                ),
                const SizedBox(height: 10),
                AppThemeShared.textFormField(
                    context: context,
                    hintText: "Enter password",
                    controller: password,
                    validator: Utility.nameValidator),
                const SizedBox(height: 10),
                AppThemeShared.sharedButton(
                  context: context,
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.85,
                  buttonText: "Login",
                  onTap: () {
                    final valid = key.currentState!.validate();
                    if (valid) {
                      login();
                    }
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  "Not a seller?",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Register to become one!",
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, "/sellerRegister"),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: AppThemeShared.primaryColor, width: 3)),
                    child: const Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    // UserModel? user = await SellerService().login(
    //     AuthModel(phoneNumber: phoneNumber.text, password: password.text));
    final signin = ref.read(signInProvider(
            AuthModel(phoneNumber: phoneNumber.text, password: password.text))
        .future);

    signin.then((singedIn) async {
      if (singedIn) {
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.setString(
            "phoneNumber", "91${phoneNumber.text}");
        Fluttertoast.showToast(msg: "logged in successfully");
        Navigator.pushNamedAndRemoveUntil(
            context, '/bottomNav', (route) => false);
      }
    });
  }
}

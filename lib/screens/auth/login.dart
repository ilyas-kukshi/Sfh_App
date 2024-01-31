import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sfh_app/services/auth/auth_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  bool accExists = true;

  TextEditingController phoneNumber = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppThemeShared.appBar(
      //     title: "Login", context: context, backButton: false),
      body: SafeArea(
        child: Center(
          child: Form(
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
                  onTap: () async {
                    final user = ref.read(
                        getUserByNumberProvider("91${phoneNumber.text}")
                            .future);
                    user.then((value) {
                      if (value != null) {
                        Navigator.pushNamed(context, '/bottomNav');
                      }
                    });
                    // user.when(
                    //   data: (data) {
                    //     if (data != null) {
                    //       Navigator.pushNamed(context, '/dashboardMain');
                    //     }
                    //   },
                    //   error: (error, stackTrace) => const Offstage(),
                    //   loading: () => const Offstage(),
                    // );
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
      Navigator.pushNamed(context, '/bottomNav');
    }
  }

  sendOtp() async {}
}

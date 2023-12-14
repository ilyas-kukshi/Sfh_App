// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sfh_app/models/seller_register/seller_register_model.dart';
import 'package:sfh_app/services/seller_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/dialogs.dart';
import 'package:sfh_app/shared/utility.dart';

class SellerRegister extends StatefulWidget {
  const SellerRegister({super.key});

  @override
  State<SellerRegister> createState() => _SellerRegisterState();
}

class _SellerRegisterState extends State<SellerRegister> {
  TextEditingController name = TextEditingController();
  TextEditingController businessName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController businessDescription = TextEditingController();
  TextEditingController productTypes = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppThemeShared.appBar(title: "Seller Registration", context: context),
      body: Center(
        child: Form(
          key: key,
          child: Column(
            children: [
              const SizedBox(height: 10),
              AppThemeShared.textFormField(
                  context: context, hintText: "Your name*", controller: name),
              const SizedBox(height: 10),
              AppThemeShared.textFormField(
                  context: context,
                  hintText: "Business name*",
                  controller: businessName),
              const SizedBox(height: 10),
              AppThemeShared.textFormField(
                context: context,
                controller: phoneNumber,
                hintText: 'Phone number*',
                validator: Utility.phoneNumberValidator,
                keyboardType: TextInputType.number,
                inputFormatters: [LengthLimitingTextInputFormatter(10)],
              ),
              const SizedBox(height: 10),
              AppThemeShared.textFormField(
                context: context,
                controller: businessDescription,
                hintText: "Business desciption*",
              ),
              const SizedBox(height: 10),
              AppThemeShared.textFormField(
                context: context,
                controller: productTypes,
                hintText: "Types of products*",
              ),
              const SizedBox(height: 10),
              AppThemeShared.sharedButton(
                context: context,
                height: 55,
                width: MediaQuery.of(context).size.width * 0.85,
                buttonText: "Register",
                onTap: () {
                  final valid = key.currentState!.validate();
                  if (valid) {
                    register();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  register() async {
    bool registered = await SellerService().register(SellerRegisterModel(
        name: name.text,
        businessName: businessName.text,
        phoneNumber: phoneNumber.text,
        businessDescription: businessDescription.text,
        productTypes: productTypes.text));

    if (registered) {
      DialogShared.singleButtonDialog(
          context: context,
          barrierDismissible: false,
          text:
              "Thank you for registering to become a Seller on our platform, We will contact you soon. Thank you!",
          buttonText: "Okay",
          onClicked: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/dashboardMain', (route) => false);
          });
    } else {
      Fluttertoast.showToast(msg: "Registration failed");
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sfh_app/models/user/user_model.dart';
import 'package:sfh_app/services/category/category_services.dart';
import 'package:sfh_app/services/seller/seller_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/category_selection.dart';
import 'package:sfh_app/shared/utility.dart';

class AddSeller extends ConsumerStatefulWidget {
  const AddSeller({super.key});

  @override
  ConsumerState<AddSeller> createState() => _AddSellerState();
}

class _AddSellerState extends ConsumerState<AddSeller> {
  List<String> selectedCategories = [];
  bool verified = false;

  GlobalKey<FormState> key = GlobalKey();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController productLimit = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final allCategories = ref.watch(allCategoriesProvider);
    return Scaffold(
      appBar: AppThemeShared.appBar(title: "Add Seller", context: context),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    controller: name,
                    hintText: "Name",
                    validator: Utility.nameValidator),
                const SizedBox(height: 10),
                AppThemeShared.textFormField(
                  context: context,
                  controller: productLimit,
                  hintText: "Product limit",
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Select Categories",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                allCategories.when(
                  data: (data) => Wrap(
                    children: data
                        .map((e) => CategorySelection(
                              category: e,
                              clicked: (category) {
                                if (selectedCategories.contains(category.id)) {
                                  selectedCategories.remove(category.id);
                                } else {
                                  selectedCategories.add(category.id!);
                                }
                              },
                            ))
                        .toList(),
                  ),
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => const CircularProgressIndicator(),
                ),
                const SizedBox(height: 10),
                AppThemeShared.sharedButton(
                  context: context,
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.85,
                  buttonText: "Add Seller",
                  onTap: () {
                    final valid = key.currentState!.validate();
                    if (valid && selectedCategories.isNotEmpty) {
                      addSeller();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  addSeller() async {
    bool added = await SellerService().add(UserModel(
        phoneNumber: "91${phoneNumber.text}",
        name: name.text,
        role: "Seller",
        productLimit: int.parse(productLimit.text),
        categoryAccess: selectedCategories));

    if (added) {
      Fluttertoast.showToast(msg: "Seller Added");
    }
  }
}

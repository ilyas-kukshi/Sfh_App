import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sfh_app/models/address/address_model.dart';
import 'package:sfh_app/services/address/address_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/dialogs.dart';
import 'package:sfh_app/shared/utility.dart';

class AddAddress extends ConsumerStatefulWidget {
  const AddAddress({super.key});

  @override
  ConsumerState<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends ConsumerState<AddAddress> {
  GlobalKey<FormState> form = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController houseNo = TextEditingController();
  TextEditingController roadName = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemeShared.appBar(title: "Add Address", context: context),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: form,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                AppThemeShared.textFormField(
                  controller: name,
                  widthPercent: 0.95,
                  context: context,
                  labelText: "Name*",
                  validator: Utility.emptyValidator,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 10),
                AppThemeShared.textFormField(
                  widthPercent: 0.95,
                  context: context,
                  // hintText: "Enter your whatsapp number",
                  labelText: "Phone number*",
                  controller: phoneNumber,
                  validator: Utility.phoneNumberValidator,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                  onChanged: (value) {},
                ),
                const SizedBox(height: 10),
                AppThemeShared.textFormField(
                  widthPercent: 0.95,
                  context: context,
                  labelText: "House No., Building No.*",
                  controller: houseNo,
                  validator: Utility.emptyValidator,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 10),
                AppThemeShared.textFormField(
                  widthPercent: 0.95,
                  context: context,
                  labelText: "Road Name, Area Colony*",
                  controller: roadName,
                  validator: Utility.emptyValidator,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 10),
                AppThemeShared.textFormField(
                  widthPercent: 0.95,
                  context: context,
                  labelText: "Nearby landmark",
                  controller: landmark,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 10),
                AppThemeShared.textFormField(
                  // validator: Utility.pin,
                  widthPercent: 0.95,
                  context: context,
                  labelText: "Pincode*",
                  controller: pincode,
                  validator: Utility.emptyValidator,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppThemeShared.textFormField(
                        // validator: Utility.pin,
                        widthPercent: 0.45,
                        context: context,
                        labelText: "City, Town*",
                        controller: city,
                        validator: Utility.emptyValidator,
                        textInputAction: TextInputAction.next,
                      ),
                      AppThemeShared.textFormField(
                        // validator: Utility.pin,
                        widthPercent: 0.45,
                        context: context,
                        labelText: "State*",
                        controller: state,
                        validator: Utility.emptyValidator,
                        textInputAction: TextInputAction.done,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                AppThemeShared.sharedButton(
                  height: 45,
                  widthPercent: 0.95,
                  // width: 200,
                  context: context,
                  buttonText: "Save Address",
                  onTap: () {
                    final valid = form.currentState!.validate();
                    if (valid) {
                      addAddress();
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

  void addAddress() async {
    DialogShared.loadingDialog(context, "Adding");
    String? token = await Utility().getStringSf("token");
    final added = await AddressService().addAddress(AddressModel(
        name: name.text,
        phoneNumber: phoneNumber.text,
        houseNo: houseNo.text,
        roadName: roadName.text,
        pincode: pincode.text,
        city: city.text,
        state: state.text));
    if (added) {
      final refereshed = ref.refresh(getAddressesProvider(token!).future);
      refereshed.whenComplete(() {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    } else {
      Fluttertoast.showToast(msg: "Not added");
      Navigator.pop(context);
    }
  }
}

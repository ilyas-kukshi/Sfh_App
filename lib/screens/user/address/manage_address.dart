import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sfh_app/models/address/address_model.dart';
import 'package:sfh_app/services/address/address_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/dialogs.dart';
import 'package:sfh_app/shared/utility.dart';

class ManageAddress extends StatefulWidget {
  final bool selectAddress;
  const ManageAddress({super.key, required this.selectAddress});

  @override
  State<ManageAddress> createState() => _ManageAddressState();
}

class _ManageAddressState extends State<ManageAddress> {
  TextEditingController country = TextEditingController(text: "India");
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();

  AddressModel? selectedAddress;
  String? token;
  Future<void> getToken() async {
    token = await Utility().getStringSf("token");
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemeShared.appBar(title: "Address", context: context),
      body: FutureBuilder<void>(
        future: getToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer(
              builder: (context, ref, child) {
                final addressProvider = ref.watch(GetAddressesProvider(token!));
                return addressProvider.when(
                  data: (addresses) => ListView.builder(
                    itemCount: addresses.length,
                    itemBuilder: (context, index) =>
                        addressCard(ref, addresses[index]),
                  ),
                  error: (error, stackTrace) => Center(
                    child: Text(error.toString()),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/addAddress');
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                border:
                    Border.all(width: 2, color: AppThemeShared.primaryColor)),
            child: Center(
                child: Text(
              "Add Address",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 18, color: AppThemeShared.primaryColor),
            )),
          ),
        ),
      ),
    );
  }

  Widget addressCard(WidgetRef ref, AddressModel address) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Text(
                      "${address.houseNo}, ${address.roadName}, ${address.landmark ?? ''}, ${address.city}, ${address.state} - ${address.pincode}"),
                ),
                const SizedBox(height: 4),
                Text("+${address.phoneNumber}"),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 2, color: AppThemeShared.primaryColor),
                      ),
                      child: const Text("Edit"),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () async {
                        DialogShared.loadingDialog(context, "Delete");
                        final deleted =
                            await AddressService().delete(address.id!, token!);
                        if (deleted) {
                          final update =
                              ref.refresh(getAddressesProvider(token!).future);
                          update.whenComplete(() => Navigator.pop(context));
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 20),
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.red),
                        ),
                        child: const Text("Delete"),
                      ),
                    )
                  ],
                )
              ],
            ),
            widget.selectAddress
                ? Align(
                    alignment: Alignment.topRight,
                    child: Radio<AddressModel>(
                      activeColor: AppThemeShared.primaryColor,
                      value: address,
                      groupValue: selectedAddress,
                      onChanged: (value) {
                        setState(() {
                          selectedAddress = value;
                        });
                      },
                    ),
                  )
                : const Offstage()
          ],
        ),
      ),
    );
  }
}

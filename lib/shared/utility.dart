import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class Utility {
  static String? nameValidator(String? name) {
    if (name!.isEmpty) {
      return " Please enter your name";
    }
    return null;
  }

  static String? categoryNameValidator(String? name) {
    if (name!.isEmpty) {
      return " Please enter your category name";
    }
    return null;
  }

  static String? productNameValidator(String? name) {
    if (name!.isEmpty) {
      return " Please enter your category name";
    }
    return null;
  }

  static String? productPriceValidator(String? name) {
    if (name!.isEmpty) {
      return "Please enter your product price";
    }
    return null;
  }

  static String? phoneNumberValidator(String? phoneNumber) {
    if (phoneNumber?.length != 10 ||
        int.tryParse(phoneNumber.toString()) == null) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  static String? passwordLengthValidator(String? password) {
    if (password!.length < 6) {
      return 'Pleas enter a valid phone number';
    }
    return null;
  }

  static String? passwordSameValidator(
      String? setPassword, String? confirmPassword) {
    if (confirmPassword!.length < 6) {
      return 'Pleas enter a valid phone number';
    } else if (setPassword != confirmPassword) {
      return 'Both passwords should be same';
    }
    return null;
  }

  static String? otpValidator(String? otp) {
    if (otp!.length != 6) {
      return 'Pleas enter a valid otp';
    }
    return null;
  }

  static String? shopNameValidator(String? name) {
    if (name!.isEmpty) {
      return " Please enter your shop name";
    }
    return null;
  }

  static String? shopLocationValidator(String? name) {
    if (name!.isEmpty) {
      return " Please set your shop location";
    }
    return null;
  }

  static String? shopAddressValidator(String? name) {
    if (name!.isEmpty) {
      return " Please enter your shop address";
    }
    return null;
  }

  Future<List<String>?> uploadImages(List<CroppedFile> images) async {
    List<String> imageUrls = [];

    for (var image in images) {
      String? downloadUrl = await uploadImage(image);
      if (downloadUrl == null) {
        for (String imageUrl in imageUrls) {
          await FirebaseStorage.instance.refFromURL(imageUrl).delete();
        }
        return null;
      } else {
        imageUrls.add(downloadUrl);
      }
    }
    return imageUrls;
  }

  Future<String?> uploadImage(CroppedFile image) async {
    var ref = FirebaseStorage.instance.ref(getUniqueId());
    XFile? compressed = await testCompressAndGetFile(image, image.path);

    if (compressed != null) {
      try {
        await ref.putFile(File(compressed.path));
      } on FirebaseException catch (error) {
        Fluttertoast.showToast(msg: error.toString());
        // print(error);
        return null;
      }
    } else {
      return null;
    }

    return await ref.getDownloadURL();
  }

  Future<XFile?> testCompressAndGetFile(
      CroppedFile file, String targetPath) async {
    try {
      XFile? result = await FlutterImageCompress.compressAndGetFile(
          file.path,
          targetPath.endsWith("png")
              ? "${targetPath}compressed.png"
              : "${targetPath}compressed.jpeg",
          quality: 70,
          format: targetPath.endsWith("png")
              ? CompressFormat.png
              : CompressFormat.jpeg
          // rotate: 180,
          );

      if (result != null) {
        // print(File(result.path).lengthSync());
        return result;
      }
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
      // print(error);
    }

    // print(result!.lengthSync());

    return null;
  }

  deleteImageFromRef(List<String> imageUrls) async {
    for (String imageUrl in imageUrls) {
      await FirebaseStorage.instance.refFromURL(imageUrl).delete();
    }
  }

  String getUniqueId() {
    var uuid = const Uuid();
    return uuid.v1();
  }

  Future<String?> getPhoneNumberSF() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(prefs.getString("phoneNumber"));
      return prefs.getString("phoneNumber");
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
      // print(error);
    }
    return null;
  }
}

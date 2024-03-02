import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:sfh_app/shared/constants.dart';
import 'package:sfh_app/shared/utility.dart';

class UserService {
  Future<bool> updateWishlist(String productId, String userId) async {
    String? token = await Utility().getStringSf("token");

    try {
      var response = await http
          .put(Uri.parse("${Constants.baseUrl}/user/wishlist"), headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        "userId": userId,
        "productId": productId
      });
      // var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      // print(error);
      Fluttertoast.showToast(msg: error.toString());
      return false;
    }
  }
}

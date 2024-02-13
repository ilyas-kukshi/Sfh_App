import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:sfh_app/shared/constants.dart';

class UserService {
  Future<bool> updateWishlist(String productId, String userId) async {
    try {
      var response = await http.put(
          Uri.parse("${Constants.baseUrl}/user/wishlist"),
          body: {"userId": userId, "productId": productId});
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

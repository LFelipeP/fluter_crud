import 'dart:convert' as convert;
import 'package:fluter_crud/models/user.dart';
import 'package:fluter_crud/utils/constants.dart';
import 'package:http/http.dart' as http;

class UserApi {
  static Future<List<User>> getUser() async {
    try {
      final String _baseUrl = '${Constants.BASE_API_URL}/users';
      var response = await http.get(_baseUrl);
      String json = response.body;
      List list = convert.json.decode(json);
      final user = List<User>();
      for (Map map in list) {
        User c = User.fromJson(map);
        user.add(c);
      }
      return [];
    } catch (error) {
      print(error);
    }
  }
}

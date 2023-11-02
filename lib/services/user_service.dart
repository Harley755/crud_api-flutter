import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:post_api/models/user_model.dart';

class UserService implements UserMethods {
  @override
  getAll() async {
    var url = dotenv.env['GET_USER_URL'];
    var uri = Uri.parse(url!);
    var response = await http.get(uri);
    print("response User : ${response.body}");
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final user = json
          .map(
            (e) => User(
              id: e['id'],
              name: e['name'],
              username: e['username'],
              email: e['email'],
              phone: e['phone'],
              website: e['website'],
              address: Address.fromJson(e['address']),
            ),
          )
          .toList();
      return user;
    }
    return [];
  }
}

import 'dart:convert';
import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:post_api/models/post_model.dart';

class PostService implements PostMethods {
  @override
  getAll() async {
    var url = dotenv.env['GET_POST_URL'];
    var uri = Uri.parse(url!);
    var response = await http.get(uri);
    print("response : ${response.body}");
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final post = json
          .map(
            (e) => Post(
              id: e['id'],
              title: e['title'],
              body: e['body'],
              userId: e['userId'],
            ),
          )
          .toList();
      return post;
    }
    return [];
  }

  @override
  createPost({
    required String title,
    required String body,
    required userId,
  }) async {
    var url = dotenv.env['CREATE_POST_URL'];
    var uri = Uri.parse(url!);
    var response = await http.post(uri, body: {
      'title': title,
      'body': body,
      'userId': userId,
    });
    if (response.statusCode == 201) {
      print("response create Post : ${response.body}");
    } else {
      print("Erreur d'enregistrement : ${response.body}");
    }
  }

  @override
  getPost({required int idPost}) async {
    var url = dotenv.env['EDIT_POST_URL']!.replaceFirst(
      ':id',
      idPost.toString(),
    );
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    print("response One Post : ${response.body}");
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final post = json
          .map(
            (e) => Post(
              id: e['id'],
              title: e['title'],
              body: e['body'],
              userId: e['userId'],
            ),
          )
          .toList();
      return post;
    }
    return [];
  }

  @override
  updatePost({
    required int idPost,
    required String title,
    required String body,
    required userId,
  }) async {
    var url = dotenv.env['UPDATE_POST_URL']!.replaceFirst(
      ':id',
      idPost.toString(),
    );
    log("Url " + url.toString());
    var uri = Uri.parse(url);
    var response = await http.put(uri, body: {
      'title': title,
      'body': body,
      'userId': userId,
    });
    print("response update code : ${response.statusCode}");
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  deletePost({required int idPost}) async {
    var url = dotenv.env['UPDATE_POST_URL']!.replaceFirst(
      ':id',
      idPost.toString(),
    );
    log("Url " + url.toString());
    var uri = Uri.parse(url);
    var response = await http.delete(uri);
    print("response delete code : ${response.statusCode}");
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}

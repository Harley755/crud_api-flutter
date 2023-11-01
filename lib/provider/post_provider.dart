import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:post_api/models/post_model.dart';
import 'package:post_api/services/post_service.dart';

class PostProvider extends ChangeNotifier {
  final service = PostService();
  bool isLoading = false;
  List<Post> _posts = [];
  List<Post> get posts => _posts;

  getPosts() async {
    isLoading = true;
    notifyListeners();
    final res = await service.getAll();
    _posts = res;
    log("e : ${_posts.length}");
    isLoading = false;
    notifyListeners();
  }

  create({
    required String title,
    required String body,
    required userId,
  }) async {
    isLoading = true;
    notifyListeners();
    final res =
        await service.createPost(title: title, body: body, userId: userId);
    log("e : $res");
    isLoading = false;
    notifyListeners();
  }
}

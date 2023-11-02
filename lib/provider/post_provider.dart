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

  getOne({
    required postId,
  }) async {
    isLoading = true;
    notifyListeners();
    final res = await service.getPost(idPost: postId);
    log("e get One : $res");
    isLoading = false;
    notifyListeners();
  }

  update({
    required postId,
    required String title,
    required String body,
    required userId,
  }) async {
    isLoading = true;
    notifyListeners();
    final res = await service.updatePost(
      title: title,
      body: body,
      userId: userId,
      idPost: postId,
    );
    log("e update : $res");
    isLoading = false;
    notifyListeners();
  }

  delete({required postId}) async {
    isLoading = true;
    notifyListeners();
    final res = await service.deletePost(idPost: postId);
    log("e update : $res");
    isLoading = false;
    notifyListeners();
  }
}

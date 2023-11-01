import 'package:flutter/material.dart';
import 'package:post_api/screen/posts/create_post.dart';
import 'package:post_api/screen/posts/edit_post.dart';

Map<String, WidgetBuilder> routes = {
  "/post/create": (context) => const CreatePost(),
  "/post/:id": (context) => const EditPost(),
};

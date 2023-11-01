import 'package:flutter/material.dart';
import 'package:post_api/screen/posts/post_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PostScreen(),
    );
  }
}

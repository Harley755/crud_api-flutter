import 'package:flutter/material.dart';
import 'package:post_api/provider/post_provider.dart';
import 'package:post_api/screen/posts/create_post.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<PostProvider>(context, listen: false);
      provider.getPosts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var posts = context.watch<PostProvider>().posts;
    var isLoading = context.watch<PostProvider>().isLoading;

    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text("LIST POSTS"),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 6.0,
                horizontal: 15.0,
              ),
              child: ListView.builder(
                itemCount: posts.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    const SizedBox(height: 7.0);
                    return ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          CreatePost.routeName,
                        );
                      },
                      child: const Text('Add Post'),
                    );
                  } else {
                    var post = posts[index - 1];
                    return ListTile(
                      title: Text(
                        post.title,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      subtitle: Text(post.body, textAlign: TextAlign.justify),
                      trailing: SizedBox(
                        width: 100.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            IconButton(
                              onPressed: () {
                                // log();
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.green[300],
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red[300],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          );
  }
}

import 'package:flutter/material.dart';
import 'package:post_api/models/post_model.dart';
import 'package:post_api/models/user_model.dart';
import 'package:post_api/provider/post_provider.dart';
import 'package:post_api/provider/user_provider.dart';
import 'package:post_api/screen/posts/post_screen.dart';
import 'package:provider/provider.dart';

class EditPost extends StatefulWidget {
  final Post post;
  static String routeName = "/post/:id";
  const EditPost({super.key, required this.post});

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  @override
  void initState() {
    _titleController = TextEditingController();
    _bodyController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<UserProvider>(context, listen: false);
      if (provider.users.isEmpty) {
        provider.getUsers().then((_) {
          setState(() {
            selectedUser = provider.users[0].id
                .toString(); // Assuming 'id' is the field you want to assign to 'selectedUser'
          });
        });
      }
    });

    _titleController.text = widget.post.title.toString();
    _bodyController.text = widget.post.body.toString();
    selectedUser = widget.post.userId.toString();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;

  String title = "";
  String body = "";
  late String? selectedUser = "";

  @override
  Widget build(BuildContext context) {
    var users = context.read<UserProvider>().users;
    var isLoading = context.watch<UserProvider>().isLoading;
    return Scaffold(
      appBar: AppBar(
        title: const Text('EDIT POST'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 15.0,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TITLE
              TextFormField(
                controller: _titleController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter title',
                  hintMaxLines: 20,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Title is empty';
                  }
                  return null;
                },
                onSaved: (value) {
                  title = value!;
                },
              ),

              const SizedBox(height: 22.0),

              // BODY
              TextFormField(
                controller: _bodyController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Body',
                  hintText: 'Enter body',
                  hintMaxLines: 20,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Body is empty';
                  }
                  return null;
                },
                onSaved: (value) {
                  body = value!;
                },
              ),

              const SizedBox(height: 22.0),

              // USER
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : DropdownButtonFormField(
                      value: selectedUser,
                      items: users
                          .map((User e) {
                            return DropdownMenuItem<String>(
                              value: e.id.toString(),
                              child: Text(e.name),
                            );
                          })
                          .toSet()
                          .toList(),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedUser = value!;
                        });
                      },
                      onSaved: (value) {
                        selectedUser = value!;
                      },
                    ),

              const SizedBox(height: 22.0),

              // BUTTON
              ElevatedButton(
                onPressed: () {
                  onPressSubmit(context);
                },
                child: const Text('Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onPressSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<PostProvider>().update(
            title: _titleController.text,
            body: _bodyController.text,
            userId: selectedUser!,
            postId: widget.post.id,
          );
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const PostScreen()),
          (route) => false);
    }
  }
}

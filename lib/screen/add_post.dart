import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../models/post.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  // type inference
  var userIdC = TextEditingController();
  var titleC = TextEditingController();
  var bodyC = TextEditingController();

  Post? globalPost;

  createPost(Post post) async {
    String url = 'https://jsonplaceholder.typicode.com/posts';
    Uri uri = Uri.parse(url);

    http.Response response = await http.post(
        uri,
        headers: {'Content-type': 'application/json; charset=UTF-8'},
        body: jsonEncode(post.toJson()) // map, key value pairs
    );

    if (response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body);
      Post resultingPost = Post.fromJson(jsonResponse);

      setState(() {
        globalPost = resultingPost;
      });
    } else {
      print('Something went wrong');

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Post'), backgroundColor: Colors.green),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 20,
          children: [
            TextField(
              controller: userIdC,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'User ID',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: titleC,
              decoration: InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),

            TextField(
              controller: bodyC,
              maxLines: 7,
              decoration: InputDecoration(
                hintText: 'Body',
                border: OutlineInputBorder(),
              ),
            ),

            ElevatedButton(
              onPressed: () async {
                String userId = userIdC.text.trim();
                String title = titleC.text.trim();
                String body = bodyC.text.trim();

                if (userId.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please provide user id')),
                  );
                  return;
                }

                if (title.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please provide title')),
                  );
                  return;
                }

                if (body.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please provide body description')),
                  );
                  return;
                }

                // send this post to server
                Post post = Post(
                  userId: int.parse(userId!),
                  title: title,
                  body: body,
                );

                await createPost(post);
              },
              child: const Text('Submit'),
            ),

            Text('${globalPost?.toJson()}'),
          ],
        ),
      ),
    );
  }
}
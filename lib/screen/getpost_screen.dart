import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:metapi_api/models/post.dart';

class GetpostScreen extends StatefulWidget {
  const GetpostScreen({super.key});

  @override
  State<GetpostScreen> createState() => _GetpostScreenState();
}

class _GetpostScreenState extends State<GetpostScreen> {
  Future<Post> getPostFromApi ()async{
    String url = 'https://jsonplaceholder.typicode.com/posts/11';
    Uri uri = Uri.parse(url);

    http.Response response = await http.get( uri);

    if( response.statusCode == 200 ){
      var jsonResponse = jsonDecode(response.body);

      Post post = Post.fromJson(jsonResponse);
      print(jsonResponse);

      return post;
    }else{
      print('SWW');
    }

    return Post();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Screen"),
      ),
      body:FutureBuilder<Post>(future: getPostFromApi(), builder: (context, snapshot){
        if (snapshot.hasData){
          Post post = snapshot.data as Post;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Center(
                child: Column(
                  children: [
                    Text(post.userId?.toString()??"No UserID"),
                    SizedBox(height: 20,),
                    Text(post.id?.toString()??"No ID"),
                    SizedBox(height: 20,),
                    Text(post.title?.toString()??"No title"),
                    SizedBox(height: 20,),
                    Text(post.body?.toString()??"No body"),
                    SizedBox(height: 20,),

                  ],
                ),
              ),
            ),
          );
        }
        else{
          return Center(child: CircularProgressIndicator(),);
        }
      }),
    );
  }
}

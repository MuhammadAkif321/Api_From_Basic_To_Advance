import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:metapi_api/models/user_info.dart';

class GetUserScreen extends StatefulWidget {
  const GetUserScreen({super.key});

  @override
  State<GetUserScreen> createState() => _GetUserScreenState();
}

class _GetUserScreenState extends State<GetUserScreen> {
  Future<User> getUserFromApi ()async{
    String url = 'https://jsonplaceholder.typicode.com/users/1';
    Uri uri = Uri.parse(url);

    http.Response response = await http.get( uri);

    if( response.statusCode == 200 ){
      var jsonResponse = jsonDecode(response.body);

      User user = User.fromJson(jsonResponse);
      print(jsonResponse);

      return user;
    }else{
      print('SWW');
    }

    return User();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Info Screen"),
      ),
      body: FutureBuilder<User>(
          future: getUserFromApi(),
          builder: (context, snapshot){

            if( snapshot.hasData){

              User user = snapshot.data as User;

              return Column(
                children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Card(
                     child: Center(
                       child: Column(
                         children: [
                           Text(user.id?.toString() ?? "NO ID"),
                           SizedBox(height: 10,),
                           Text(user.name?.toString() ?? "NO NAME"),
                           SizedBox(height: 10,),
                           Text(user.username?.toString() ?? "NO USERNAME"),
                           SizedBox(height: 10,),
                           Text(user.email?.toString() ?? "NO EMAIL"),

                         ],
                       ),
                     ),
                   ),
                 ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Center(
                        child: Column(
                          children: [
                            Text(user.address?.street?.toString() ?? "NO street"),
                            SizedBox(height: 10,),
                            Text(user.address?.suite?.toString() ?? "NO suite"),
                            SizedBox(height: 10,),
                            Text(user.address?.city?.toString() ?? "NO city"),
                            SizedBox(height: 10,),
                            Text(user.address?.zipcode?.toString() ?? "NO zipcode"),
                            SizedBox(height: 10,),
                            Text(user.address?.geo?.toString() ?? "NO geo"),


                          ],
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Center(
                        child: Column(
                          children: [
                            Text(user.company?.name?.toString() ?? "NO name"),
                            SizedBox(height: 10,),
                            Text(user.company?.catchPhrase?.toString() ?? "NO catchphrase"),
                            SizedBox(height: 10,),
                            Text(user.company?.bs?.toString() ?? "NO bs"),


                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );

            }else{
              return Center(child: CircularProgressIndicator(),);
            }
          }),
    );
  }
}

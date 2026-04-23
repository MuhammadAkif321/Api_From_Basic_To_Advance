import 'package:flutter/material.dart';
import 'package:metapi_api/screen/get_products_screen.dart';
import 'package:metapi_api/screen/get_user_screen.dart';
import 'package:metapi_api/screen/getpost_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text("Show posts"),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return GetpostScreen();
                }));
              },
            ),
          ),

          Card(
            child: ListTile(
              title: Text("Show products"),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return GetProductsScreen();
                }));
              },
            ),
          ),

          Card(
            child: ListTile(
              title: Text("Show users"),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return GetUserScreen();
                }));
              },
            ),
          ),
        ],
      ),
    );
  }
}

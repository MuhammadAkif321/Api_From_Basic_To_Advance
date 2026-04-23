import 'dart:convert';

import 'package:flare_rating/flare_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:metapi_api/models/product.dart';

class GetProductsScreen extends StatefulWidget {
  const GetProductsScreen({super.key});

  @override
  State<GetProductsScreen> createState() => _GetProductsScreenState();
}

class _GetProductsScreenState extends State<GetProductsScreen> {
  Future<List<Product>> getAllProducts ()async{
    String url = 'https://fakestoreapi.com/products';
    Uri uri = Uri.parse(url);

    http.Response response = await http.get(uri);
    if( response.statusCode == 200 ){

      var jsonResponse = jsonDecode(response.body);

      List<Product> productList = [];


      // inside this loop, each json product is converted
      // to Product object
      // and added to list
      // and then the list is returned
      for( var jsonProduct in jsonResponse){
        Product product = Product.fromJson(jsonProduct);

        productList.add(product);
      }

      return productList;
    }

    return [];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Products Screen"),
      ),
      body: FutureBuilder<List<Product>>(future: getAllProducts(), builder: (context,snapshot){
        if(snapshot.hasData){
          List <Product> products= snapshot.data as List<Product>;

          return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemBuilder:(context,index){
            Product product = products[index];

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  spacing: 20,
                  children: [
                    Image.network(product.image!,width: 200,),
                    Text(product.title?? "No",style: TextStyle(fontWeight: FontWeight.bold),),
                    Text('${product.price}\$' ?? "No", style: TextStyle(color: Colors.red),),
                    Wrap(
                      spacing: 16,
                      children: [
                        FlareRating(
                          rating: product.rating?.rate ?? 0.0,
                          allowHalfRating: true,
                          itemCount: 5,
                          //onRatingUpdate: (value) => setState(() => _rating = value),
                        ),
                        Text("(${product.rating?.count ?? 0})", style: TextStyle(fontSize: 20, fontWeight: .bold),)
                      ],
                    ),

                    Text('${product.description}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: .bold,
                          fontSize: 20),)


                  ],
                ),
              ),
            );
          });

        }else{
          return Center(child: SpinKitRipple(color: Colors.cyan,size: 170));
        }
      })
    );
  }
}

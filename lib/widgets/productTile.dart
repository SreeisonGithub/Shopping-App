import 'package:flutter/material.dart';
import 'package:funcart/models/productModel.dart';
import 'package:funcart/screen/productDetailsScreen.dart';
import 'package:funcart/services/authentication_service.dart';
import '../blocs/productProvider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

Widget productTile(ProductBloc bloc, BuildContext context) {
  var user = AuthenticationService().getCurrentFirebaseUser();
  return StreamBuilder(
    stream: bloc.products,
    builder: (context, AsyncSnapshot<List<Products>> snapshot) {
      if (snapshot.hasError) {
        return Text('Something went wrong');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      if (!snapshot.hasData) {
        return Center(
          child: Text('Application Error'),
        );
      }

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: StaggeredGridView.countBuilder(
          primary: false,
          shrinkWrap: true,
          crossAxisCount: 2,
          staggeredTileBuilder: (index) => StaggeredTile.fit(1),
          crossAxisSpacing: 10,
          mainAxisSpacing: 12,
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailsScreen(snapshot.data[index]),
                  ),
                );
              },
              child: Container(
                //height: 200,width:200,
                decoration: BoxDecoration(
                  color: Colors.black,
                  //Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.10),
                        offset: Offset(0, 4),
                        blurRadius: 10)
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Hero(
                      tag: snapshot.data[index].id,
                      child: Image.network(
                        snapshot.data[index].imageLink,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace stackTrace) {
                          return Image.asset("assets/images/error.png");
                        },
                      ),
                    ),
                    SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Text(
                        snapshot.data[index].name,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        //product.name,
                        //style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            "Rs " + snapshot.data[index].price,
                            //product.getPrice(),
                            style: TextStyle(color: Colors.white),
                            //style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        user == null
                            ? Container()
                            : 
                            InkWell(
                                child: Icon(
                                  Icons.bookmark_outline,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  bookmarkTapped(snapshot.data[index],user.email);
                                },
                              ),
                      ],
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}

bookmarkTapped(Products item, String email) {
  var add = AuthenticationService().addBookmark(item, email);
}

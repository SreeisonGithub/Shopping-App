import 'package:flutter/material.dart';
import 'package:funcart/models/productModel.dart';
import 'package:funcart/screen/productDetailsScreen.dart';
import '../blocs/productProvider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

Widget productTile(ProductBloc bloc, BuildContext context) {
 
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

        return StaggeredGridView.countBuilder(
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
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 180,
                              width: double.infinity,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Image.network(
                                snapshot.data[index].imageLink,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          snapshot.data[index].name,
                          maxLines: 2,
                          style: TextStyle(
                              fontFamily: 'avenir',
                              fontWeight: FontWeight.w800),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8),
                        if (snapshot.data[index].rating != null)
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  snapshot.data[index].rating.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        SizedBox(height: 8),
                        Text('\$${snapshot.data[index].price}',
                            style:
                                TextStyle(fontSize: 32, fontFamily: 'avenir')),
                      ],
                    ),
                  ),
                ),
              );
            });
      });
}

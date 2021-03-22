import 'package:flutter/material.dart';

import '../screens/product_detail.screen.dart';

class ProductItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String id;

  ProductItem(
    this.imageUrl,
    this.title,
    this.id,
  );
  
  @override
  Widget build (BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: id
            );
          }
         ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
            color: Theme.of(context).accentColor,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
            color: Theme.of(context).accentColor,
          ) 
        )
      )
    );
  }
}
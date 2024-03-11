import 'package:flutter/material.dart';

class Shoe {
  final String name;
  final double price;
  final String imageUrl;

  Shoe({
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}

Shoe nikeShoe = Shoe(
  name: 'Nike Air Max',
  price: 129.99,
  imageUrl: 'assets/nike_air_max.jpg', // Assuming you have this image in your assets folder
);

Shoe adidasShoe = Shoe(
  name: 'Adidas Ultraboost',
  price: 149.99,
  imageUrl: 'assets/adidas_ultraboost.jpg', // Assuming you have this image in your assets folder
);

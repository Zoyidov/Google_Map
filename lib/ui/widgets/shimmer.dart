// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerScreen extends StatelessWidget {
  const ShimmerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Column(
        children: [
          const SizedBox(height: 10,),
          Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Colors.indigo.withOpacity(0.9),
            child: const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Categories(text: "All"),
                  Categories(text: "electronics"),
                  Categories(text: "jewelery"),
                  Categories(text: "men's clothing"),
                  Categories(text: "women's clothing"),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15,),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: 10,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 2,
                childAspectRatio: 0.65,
              ),
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.white,
                  highlightColor: Colors.indigo.withOpacity(0.9),
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Categories extends StatefulWidget {
  const Categories({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Center(
              child: Text(
            widget.text,
            style: const TextStyle(color: Colors.white),
          )),
        ),
      ),
    );
  }
}

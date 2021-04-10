import 'package:flutter/material.dart';
import 'package:pokemonapp/widgets/homepage.dart';

void main() => {runApp(MyApp())};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pokemon App",
      debugShowCheckedModeBanner: false,
      home: HomePage()
      
    );
  }
}


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pokemonapp/models/pokeman.dart';
import 'package:pokemonapp/screens/pokemon_details.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PokeHub pokeHub;
  var url = Uri.parse(
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json");
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var response = await http.get(url);
    var decodedJson = jsonDecode(response.body);
    pokeHub = PokeHub.fromJson(decodedJson);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Poke App",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.cyan,
          centerTitle: true,
        ),
        drawer: Drawer(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.cyan,
          child: Icon(Icons.refresh),
          onPressed: () => {},
        ),
        body: pokeHub == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GridView.count(
                crossAxisCount: 2,
                children: pokeHub.pokemon
                    .map(
                      (poke) => Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PokeDetail(
                                            pokemon: poke,
                                          )));
                            },
                            child: Hero(
                              tag: poke.img,
                              child: Card(
                                  elevation: 3.0,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(poke.img)),
                                        ),
                                      ),
                                      Text(
                                        poke.name,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )),
                            ),
                          )),
                    )
                    .toList()));
  }
}

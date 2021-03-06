import 'package:flutter/material.dart';
import 'package:pokemon/poke_viewmodel.dart';
import 'package:pokemon/pokemon.dart';

class PokeView extends StatefulWidget {
  @override
  _PokeViewState createState() => _PokeViewState();
}

class _PokeViewState extends State<PokeView> {
  final controller = PokeViewModel();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blueGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<Pokemon>(
              stream: controller.streamPokemon.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.active) {
                  return CircularProgressIndicator();
                }

                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white,
                              width: 10,
                            )),
                        child: Container(
                          child: Column(children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 10,
                                  )),
                              child: Image.network(
                                snapshot.data.urlImage,
                                height: 300,
                                width: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              snapshot.data.nome,
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                        ),
                      ),
                      Container(
                        height: 150,
                        width: 150,
                        margin: EdgeInsets.all(2),
                        alignment: Alignment.center,
                        child: Center(
                          child: ListView.builder(
                            itemCount: snapshot.data.abilities.length,
                            itemBuilder: (context, index) {
                              return Text(
                                snapshot.data.abilities[index].name,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    snapshot.error,
                    style: TextStyle(fontSize: 24, color: Colors.red),
                  );
                }
                return Container();
              }),
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
                onPressed: () {
                  controller.loadPokemon();
                },
                child: Text(
                  'Carregar Pokemon',
                  style: TextStyle(fontSize: 20),
                )),
          ),
        ],
      ),
    );
  }
}

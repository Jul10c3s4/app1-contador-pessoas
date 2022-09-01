import 'dart:ui';

import 'package:flutter/material.dart';

//ver vídeo https://www.youtube.com/watch?v=3jWe6G69VzM no minuto: 4:11
//parei na aula 11/07 no minuto: 44: 54
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int quant_pessoas = 0;
  String status = 'O local está vazio';
  List<String> clientes = [];

  bool get isEmpty => quant_pessoas == 0;
  bool get isFull => quant_pessoas == 20;
  final TextEditingController _controller = TextEditingController();

  void inclemente() {
    setState(() {
      if (quant_pessoas < 20) {
        quant_pessoas++;
        status = "Pode entrar";
      }
      if (quant_pessoas == 20) {
        status = "o local está cheio";
      }
    });
  }

  void decremente() {
    setState(() {
      if (quant_pessoas > 0) {
        quant_pessoas--;
        status = "Pode entrar";
      }
      if (quant_pessoas == 0) {
        status = "O local está vazio";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/pordo-sol.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('$status',
                    style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.w700,
                        color: isEmpty | isFull
                            ? Colors.red.withOpacity(0.8)
                            : Colors.white))
              ]),
              SizedBox(
                height: 10,
              ),
              Text(
                '$quant_pessoas',
                style: TextStyle(
                  color: isEmpty | isFull
                      ? Colors.red.withOpacity(0.8)
                      : Colors.white,
                  fontSize: 100,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 350,
                child: TextField(
                  controller: _controller,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    //fdfdffd
                  ),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    label: Text('Insira o nome de quem entrou: '),
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (quant_pessoas < 20 && _controller != "") {
                        quant_pessoas++;
                        status = "Pode entrar";
                        clientes.add(_controller.text);
                        print(clientes);
                      }
                      if (quant_pessoas == 20) {
                        status = "o local está cheio";
                      }
                    });
                  },
                  child: Text(
                    'Entrou',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: isFull || _controller.text == ""
                        ? Colors.white.withOpacity(0.2)
                        : Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ]),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${_controller.text}",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 300,
                width: 500,
                child: ListView.builder(
                    itemCount: clientes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          color: Colors.white.withOpacity(0.4),
                          child: ListTile(
                            leading: Icon(Icons.person_rounded),
                            title: Text(
                              clientes[index],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              clientes[index],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.remove_circle),
                              onPressed: () {
                                setState(() {
                                  clientes.remove(clientes[index]);
                                  quant_pessoas--;
                                });
                              },
                            ),
                          ));
                    }),
              )
            ],
          ),
        ));
  }
}

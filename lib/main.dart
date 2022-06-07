import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Get New Random Number'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  // Future<http.Response> fetchAlbum() {
  //   return http.get(Uri.parse('https://csrng.net/csrng/csrng.php?min=1&max=1000'));
  // }

  Future getData() async {
    var response =
    await http.get(Uri.https('csrng.net', 'csrng/csrng.php'));
    var jsonData = jsonDecode(response.body);
    List<Random> randomNumber = [];

    for (var u in jsonData) {
      Random random = Random(u["random"]);
      randomNumber.add(random);
    }
    return randomNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

      ),
      body: Container(
        child: Card(
          child: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: const Center(
                    child: Text(
                      'Previous Numbers',
                      // '$(randomNumber)',
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w600,
                      ),

                    ),
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: (snapshot.data as dynamic).length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text((snapshot.data as dynamic)[i].random),
                      );
                    });
              }
            },
          ),
        ),
      ),
    );
  }
}

class Random {
  final String random;
  Random(this.random);
}
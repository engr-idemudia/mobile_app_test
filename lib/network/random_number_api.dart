import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future<Get_Values> getRandomNumbers() async {
  final response = await http
      .get(Uri.parse('https://csrng.net/csrng/csrng.php?min=1&max=1000'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Get_Values.fromJson(jsonDecode(response.body)[0]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load numbers');
  }
}



class Get_Values{
  String status;
  int min, max;
  int random;

  Get_Values(
      {required this.status,
        required this.min,
        required this.max,
        required this.random});

  factory Get_Values.fromJson(Map<String, dynamic> json)=> Get_Values(
    status: json["status"],
    min: json["min"],
    max: json["max"],
    random:json["random"],
  );
}


import 'package:http/http.dart' as http;
import 'dart:convert';

class RandomNumberApi {
  static const String endpointServer = 'csrng.net';

  static Future<int> fetchRandomNumber() async {

    var url = Uri.https(endpointServer, '/csrng/csrng.php', {'min': '1', 'max': '1000'});

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List;
      if(jsonResponse[0]['status'] == "success")
      {
        var randomNumber = jsonResponse[0]['random'];
        print('Random Number: $randomNumber');
        return randomNumber;
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return -1;







    // http.Response response = await http.get(
    //     Uri.https(endpointServer));
    //
    // Map<String, dynamic> responseMap = jsonDecode(response.body);
    // return responseMap["result"];
    //
    // var response = await http.get(url);
    // if (response.statusCode == 200) {
    //   var jsonResponse =
    //   convert.jsonDecode(response.body) as Map<String, dynamic>;
    //   var itemCount = jsonResponse['totalItems'];
    //   print('Number of books about http: $itemCount.');
    // } else {
    //   print('Request failed with status: ${response.statusCode}.');
    // }

  }
}


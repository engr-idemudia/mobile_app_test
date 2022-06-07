import 'package:flutter/material.dart';
import 'package:mobile_app_test/network/random_number_api.dart';
import 'package:shared_preferences/shared_preferences.dart';


class pageLayout extends StatefulWidget {
  const pageLayout({Key? key}) : super(key: key);

  @override
  _pageLayoutState createState() => _pageLayoutState();
}
class _pageLayoutState extends State<pageLayout> {

  late Future<Get_Values> randomNumber;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _counter = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt('counter') ?? 0);
    });

    randomNumber= getRandomNumbers();
  }

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<int> _counter;

  Future<void> _incrementCounter() async{
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt('counter') ?? 0) + 1;
     setState(() {
       _counter = prefs.setInt("counter", counter).then((bool sucess){
         return counter;
       });
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const SizedBox(height:20),

              Container(
                padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                decoration: const BoxDecoration(color: Colors.blue),

                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),

                  onPressed: () {
                    setState(() {
                      randomNumber = getRandomNumbers();
                    });
                       print(randomNumber);
                    },

                  child: const Text(
                    'Get New Random Number',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ),
              ),

              const SizedBox(height:20),

              FutureBuilder<Get_Values>(
                future:randomNumber ,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!.random.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50.0,
                    ),
                    );
                  }
                  else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },
              ),

              const SizedBox(height: 80.0),

              Container(
                child: FutureBuilder<int>(
                  future: _counter,
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const CircularProgressIndicator();
                      default:
                        if(snapshot.hasError){
                          return Text('Error: ${snapshot.error}');

                        }else{
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                          );
                        }
                    }
                  }
                ),
              ),

              Text(
                'Previous Numbers',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                'loading.....',
                style: TextStyle(
                  color: Colors.grey[700],
                  // letterSpacing: 2.0,
                ),
              ),
            ]
        ),
      ),
    );
  }
}
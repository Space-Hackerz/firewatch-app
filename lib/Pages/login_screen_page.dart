import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App bar
      appBar: AppBar(
        title: const Text("Firewatch",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            ),
        ),
        centerTitle: true,
      ),

      //Body
      body: Column(
        children: <Widget>[
          //Image
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 255,
            child: Image.asset(""),//Need image of hilary clinton
          ),
          //spacing
          SizedBox(height: 40,),

          //Form information
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
            decoration: const BoxDecoration(
              //TODO change colour of box if needed
              color: Colors.white24,
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  color: Colors.black26,
                  offset: Offset(0,-3),
                ),
              ]

            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [],


              ),
            ),
            ),
          ),
        ],
      ),

    );
  }
}

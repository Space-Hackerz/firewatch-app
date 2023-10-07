import 'package:flutter/material.dart';

class GeneralInformation extends StatelessWidget {
  const GeneralInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App bar
      appBar: AppBar(
        title: const Text("General Info",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body:Center(
        child:Column(
          children: <Widget>[
            const SizedBox(height: 400),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Emergency Response Info'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Evacuation Route Information'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Safety 101'),
            )
          ],
        ),
      )
    );
  }
}

import 'package:flutter/material.dart';

class WildfireInformation extends StatelessWidget {
  const WildfireInformation({super.key});

  @override
  Widget build(BuildContext context) {
    String fireSrc = "";
    String fireArea = "0km";

    List<String> locations = [
      "Califonia",
      "Madagascar",
      "Hawaii"
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Wildfire Information",
          style: TextStyle(
            color: Color(0xFFd0d2d6),
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Source of fire: $fireSrc",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
             ),
            ),

            const SizedBox(height: 10),

            Text("Area: $fireArea",
              style: TextStyle(
                fontSize: 25,
                  fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 10),


            Center(
              child: Text("Affected areas",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 50,
              ),
              ),
            ),
            const SizedBox(height: 5),

            ListView.builder(
              itemCount: locations.length,
              shrinkWrap: true, itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                     padding: EdgeInsets.all(15),
                      child: Text(locations[index],
                        style: TextStyle(
                        fontSize: 15,
                          )
                        )
              ),
                );
            },
            )



          ],
        ),
      ),

    );
  }
}

import 'package:firewatch/Widgets/CustomCard.dart';
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
           CustomCard(
               cardTitle: "What not to do at a wildfire",
               subTitle: "Learn what not to do at a wildfire!",
               cardIcon: Icon(Icons.album_outlined),
               button1_name: "NASA resources",
               button1_onPressed: (){},
               button2_name: "Forest Protection Services",
               button2_onPressed: (){}),
            CustomCard(
                cardTitle: "How to get bitches at a wildfire",
                subTitle: "Learn how to rizz up the mythical female",
                cardIcon: Icon(Icons.album_outlined),
                button1_name: "Firey rizz tips",
                button1_onPressed: (){},
                button2_name: "How to wash yourself",
                button2_onPressed: (){}),
            CustomCard(
                cardTitle: "Types of Fires",
                subTitle: "Types of fires and what you can do",
                cardIcon: Icon(Icons.album_outlined),
                button1_name: "Fire types",
                button1_onPressed: (){},
                button2_name: "Dangers and warning signs",
                button2_onPressed: (){}),
            const SizedBox(height: 100),
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
            ),
          ],
        ),
      )
    );
  }
}

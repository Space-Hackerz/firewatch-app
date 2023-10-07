import 'package:flutter/material.dart';
class CustomCard extends StatelessWidget {
  final String cardTitle;
  final String subTitle;
  final Icon cardIcon;
  final String button1_name;
  final VoidCallback button1_onPressed;
  final String button2_name;
  final VoidCallback button2_onPressed;
  const CustomCard(
      {super.key, required this.cardTitle, required this.subTitle,
      required this.cardIcon, required this.button1_name,
      required this.button1_onPressed, required this.button2_name,
      required this.button2_onPressed});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              leading: cardIcon,
              title: Text(cardTitle),
              subtitle: Text(subTitle),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: Text(button1_name),
                  onPressed: button1_onPressed,
                ),
                const SizedBox(width: 20),
                TextButton(
                  child: Text(button2_name),
                  onPressed: button2_onPressed,
                ),
                const SizedBox(width: 20),
              ],
            ),
          ],
        ));
  }
}
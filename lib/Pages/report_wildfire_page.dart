import 'dart:typed_data';
import 'package:firewatch/utils/pick_img.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class WildfireReport extends StatefulWidget {
  WildfireReport({super.key});

  @override
  State<WildfireReport> createState() => _WildfireReportState();
}

class _WildfireReportState extends State<WildfireReport> {
  Uint8List? _image;

  void SelectImage()async{
  Uint8List img = await PickImage(ImageSource.gallery);
  setState(() {
    _image = img;
  });

  }

  var addressController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Report wildfire",
            style: TextStyle(
              color: Color(0xFFd0d2d6),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
            //User input wildfire address
            Container(
              child: Text("Address of the wildfire:"),

            ),
            //TODO fix later, make look nice
            TextFormField(
              controller: addressController,
              maxLines: 1,
              validator: (val) => val == "" ? "Please enter your username" : null,
              decoration: InputDecoration(
                hintText: "Address...",
                border: OutlineInputBorder(),

              ),
            ),

            //Decription form
            SizedBox(height: 10),
            Container(
              child: Text("Description: "),
            ),


               TextFormField(
                  controller: descriptionController,
                  expands: false,
                  minLines: 3,
                  maxLines: null,
                  validator: (val) => val == "" ? "Please enter your username" : null,
                  decoration: const InputDecoration(
                    hintText: "Decription...",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(4),
                  ),
                ),



            SizedBox(height: 10),

            Container(
              child: Text("Image upload: "),
              ),

            SizedBox(
              height: 100,
              width: 100,
              child: FittedBox(
                child: _image != null ? Image(image: MemoryImage(_image!)) :
                IconButton(
                  onPressed: () {
                  SelectImage();
                  },
                icon: Icon(
                  Icons.add_circle_outline),
                ),
              ),
            ),
            SizedBox(height: 10),
              //Submit button
            Material(
                  color: Color(0xFF851229),
                  child: InkWell(
                      onTap: (){

                      },
                      borderRadius: BorderRadius.circular(30),
                      child: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 28,
                          ),
                          child: Text(
                              "Submit",
                              style: TextStyle(
                                color: Color(0xFFd0d2d6),
                                fontSize: 16,


                              )
                          )
                      )
                  )
              )




            ],
          ),
        ),
      ),
    );
  }
}

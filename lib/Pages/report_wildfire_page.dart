import 'dart:convert';
import 'dart:typed_data';
import 'package:firewatch/utils/pick_img.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firewatch/utils/report_model.dart';
import 'package:http/http.dart' as http;

class WildfireReport extends StatefulWidget {
  WildfireReport({super.key});

  @override
  State<WildfireReport> createState() => _WildfireReportState();
}

class _WildfireReportState extends State<WildfireReport> {
  Uint8List? _image;
  Position? _userLocation; // Store the user's location data here
  late String descpText = " ";
  late String addressText;
  double? latitude = 0.0;
  double? longitude = 0.0;
  String? description;
  String? address;
  late ReportModel data;

  _setData(Position loc){
  latitude = loc.latitude;
  longitude = loc.longitude;
  description = descpText;
  address = addressText;

  ReportModel data = ReportModel(address: addressText, lat: latitude, long: longitude, description: descpText);
  }
  Future<void> _createReport()async {

    String message = jsonEncode(data.toJson());

    print(message);

    final Uri uri = Uri.parse('http://127.0.0.1:5000');


    try {
      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: message,
      );

      if (response.statusCode == 200) {
        // Request was successful
        print('Response: ${response.body}');
      } else {
        // Request failed
        print('Request failed with status: ${response.statusCode}');
      }
    }
    catch (error) {
      print('Error: $error');
    }

  }


  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("locations not enabled");
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getUserLocation() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission)
      return;
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _userLocation = position;
      });

      if (_userLocation != null) {
        _setData(_userLocation!);
      }
    } catch (e) {
      print('Error getting location: $e');
    }
  }

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
            TextField(
              controller: addressController,
              maxLines: 1,
              onChanged: (value) => addressText = value,
              decoration: InputDecoration(
                hintText: "Address...",
                border: OutlineInputBorder(),

              ),
            ),


            SizedBox(height: 10),
            Container(
              child: Text("Description: "),
            ),

            //description
             TextField(
                expands: false,
                onChanged: (value) => descpText = value,
                minLines: 3,
                maxLines: null,
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
                        _getUserLocation();
                        _createReport();

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

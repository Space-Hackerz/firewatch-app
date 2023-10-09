import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class InteractiveMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _originController = TextEditingController();
  String? _currentAddress;
  Position? _currentPosition;
  Set<Marker> _markers = Set<Marker>();
  List _fire_data = [];

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(0, 0),
    zoom: 1,
  );

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
    readJson();
  }
  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('marker'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: point,
          infoWindow: InfoWindow(
            title: 'Your current location',
            snippet:
            "Latitude: " + point.latitude.toString() +
                " Longitude: " + point.longitude.toString(),
          ),
        ),
      );
    });
  }
  void _addFireMarker(String id, double lat, double lon, String confidence) {
    double fireHue = 0;
    switch(confidence){
      case "l":
        fireHue = BitmapDescriptor.hueYellow;
        break;
      case "n":
        fireHue = BitmapDescriptor.hueOrange;
        break;
      case "h":
        fireHue = BitmapDescriptor.hueRed;
        break;
    }
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(id),
          icon: BitmapDescriptor.defaultMarkerWithHue(fireHue),
          position: LatLng(lat,lon),
          infoWindow: InfoWindow(
            title: 'My Little Fire :)',
            snippet:
            "Latitude: " + lat.toString() +
              "Longitude: " + lon.toString(),
          ),
        ),
      );
    });
  }
  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/sample.json');
    final data = await json.decode(response);
    setState(() {
      _fire_data = data["fire_data"];
    });
  }
  Future<String?> getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String address = "${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}";
        return address;
      } else {
        return "Address not found";
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Google Maps'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _originController,
                      decoration: InputDecoration(hintText: ' Location'),
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  LatLng coords = await getCoordinatesFromAddress(_originController.value.text);
                  print(coords);
                  _goToPlace(coords.latitude, coords.longitude);
                },
                icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: () async {
                  await _getCurrentPosition();
                  _goToPlace(
                    _currentPosition!.latitude!,
                    _currentPosition!.longitude!,
                  );
                  print(_originController.value.text);
                  print(_currentAddress);
                  print(_currentPosition);
                },
                icon: Icon(Icons.my_location),
              ),
              IconButton(
                onPressed: () async {
                  readJson();
                  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                      content: Text("Marking Locations of All Fires in JSon data: ")));
                  _fire_data.forEach((element) {
                    var lat = element["latitude"];
                    var lon = element["longitude"];
                    var confidence = element["confidence"];
                    _addFireMarker(lat.toString()+"_"+lon.toString(), lat, lon, confidence);
                  });
                },
                icon: Icon(Icons.fire_extinguisher),
              ),
            ],
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.satellite,
              markers: _markers,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: (point) async {
                setState(() {
                  print(point);
                  _setMarker(point);
                  //_addCustomWindowMarker(point);
                });
              },
            ),
          ),
          Row(
            children: [
            ],
          ),
        ],
      ),
    );
  }
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
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
  Future<void> _goToPlace(double lat, double lng,) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12),
      ),
    );
    _setMarker(LatLng(lat, lng));
  }
  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }
  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
        '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
  Future<LatLng> getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        print(location);
        return LatLng(location.latitude, location.longitude);
      } else {
        // Handle the case where no location is found for the given address.
        return Future.error("errror");
      }
    } catch (e) {
      // Handle any errors that occur during geocoding.
      print("Error: $e");
      return Future.error("errror");
    }

  }

}

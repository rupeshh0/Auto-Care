import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:crud_based/googlemaps/search_places_screen.dart';
import 'package:crud_based/features/user_auth/presentation/pages/dashboard.dart';

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({Key? key}) : super(key: key);

  @override
  State<CurrentLocationScreen> createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  late GoogleMapController googleMapController;

  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(27.717245, 85.323959), zoom: 14);

  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Maps"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: markers,
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigating to the SearchPlacesScreen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchPlacesScreen()),
          );
        },
        label: const Text("Search Places"),
        icon: Icon(Icons.search),
      ),
    );
  }

  Future<void> _checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        _showLocationServiceDialog();
      } else {
        _getCurrentLocation();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _showLocationServiceDialog() async {
    try {
      bool enableLocationService = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Enable Location Services"),
            content:
                Text("Please enable location services to use this feature."),
            actions: <Widget>[
              TextButton(
                child: Text("CANCEL"),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text("ENABLE"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        },
      );

      if (enableLocationService == true) {
        _getCurrentLocation();
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await _determinePosition();

      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 14)));

      markers.clear();

      markers.add(Marker(
          markerId: const MarkerId('currentLocation'),
          position: LatLng(position.latitude, position.longitude)));

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        throw Exception('Location services are disabled');
      }

      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          throw Exception("Location permission denied");
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
            "Location permissions are permanently denied. Allow it from the settings.");
      }

      Position position = await Geolocator.getCurrentPosition();

      return position;
    } catch (e) {
      throw e;
    }
  }
}

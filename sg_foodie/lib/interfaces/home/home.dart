import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sg_foodie/interfaces/stall/stall.dart';
import 'src/locations.dart' as locations;

// Store stall name data to pass to stall page
class HomeToStall {
  final String hawkerCentreName;
  HomeToStall(this.hawkerCentreName);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoogleMapController mapController;
  String address;
  Position currentPosition;
  var geoLocator = Geolocator();

  // Convert address from user input to latitude and longitude and navigate to the specified position
  _search() {
    Geolocator().placemarkFromAddress(address).then((result) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target:
              LatLng(result[0].position.latitude, result[0].position.longitude),
          zoom: 15.0)));
    });
  }

  // Create custom marker with the SG Foodie image
  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load('images/SG_Foodie.png');
    return byteData.buffer.asUint8List();
  }

  // Add markers
  _handleTap(LatLng tappedPoint) {
    setState(() {
      _markers = {};
    });
  }

  // Get the user current location and locate
  void locatePosition() async {
    Position position = await geoLocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        new CameraPosition(target: latLatPosition, zoom: 15);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    Uint8List imageData = await getMarker();
    setState(() {
      mapController = controller;
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }

      // Display RFC marker
      final RFCmarker = Marker(
          markerId: MarkerId('RFC'),
          position: LatLng(1.2873154504180888, 103.8181721709163),
          infoWindow: InfoWindow(
            title: 'Redhill Food Centre',
            snippet: 'SG Foodie is here!',
          ),
          icon: BitmapDescriptor.fromBytes(imageData),
          onTap: () {
            HomeToStall data = new HomeToStall('Redhill Food Centre');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Stall(data: data)),
            );
          });
      _markers['RFC'] = RFCmarker;

      // Display AVFC marker
      final AVFCmarker = Marker(
          markerId: MarkerId('AVFC'),
          position: LatLng(1.2863751765756848, 103.80451537092631),
          infoWindow: InfoWindow(
            title: 'Alexandra Village Food Centre',
            snippet: 'SG Foodie is here!',
          ),
          icon: BitmapDescriptor.fromBytes(imageData),
          onTap: () {
            HomeToStall data = new HomeToStall('Alexandra Village Food Centre');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Stall(data: data)),
            );
          });
      _markers['AVFC'] = AVFCmarker;

      // Display HLMFC marker
      final HLMFCmarker = Marker(
          markerId: MarkerId('HLMFC'),
          position: LatLng(1.2851608242989465, 103.8457895995918),
          infoWindow: InfoWindow(
            title: 'Hong Lim Market & Food Centre',
            snippet: 'SG Foodie is here!',
          ),
          icon: BitmapDescriptor.fromBytes(imageData),
          onTap: () {
            HomeToStall data = new HomeToStall('Hong Lim Market & Food Centre');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Stall(data: data)),
            );
          });
      _markers['HLMFC'] = HLMFCmarker;
    });

    locatePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          // Google map
          GoogleMap(
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(1.2859783814464378, 103.812819200467),
              zoom: 15.0,
            ),
            markers: _markers.values.toSet(),
            onTap: _handleTap,
          ),

          // Search bar
          Positioned(
            top: 40.0,
            left: 30.0,
            right: 30.0,
            child: Container(
              height: 56.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                style: TextStyle(color: Colors.grey[800], fontSize: 20.0),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 20.0, top: 15.0),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey[800], fontSize: 20.0),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(top: 2.0, right: 5.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.redAccent,
                      ),
                      iconSize: 35.0,
                      onPressed: _search,
                    ),
                  ),
                ),
                onChanged: (val) {
                  if (val != null) {
                    setState(() => address = val);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

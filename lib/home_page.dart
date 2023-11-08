import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Completer<GoogleMapController> _googleMapController = Completer();
  CameraPosition? _cameraPosition;
  Location? _location;
  LocationData? _currentLocation;
  String? image;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    _location = Location();
    _cameraPosition = CameraPosition(
        target: LatLng(0, 0), // this is just the example lat and lng for initializing
        zoom: 15
    );
    _initLocation();
    // final arguments = ModalRoute.of(context)?.settings.arguments;
    // if (arguments is Map<String, dynamic> && arguments.containsKey('image')) {
    //   image = arguments['image'];
    // }
  }

  //function to listen when we move position
  _initLocation() {
    //use this to go to current location instead
    _location?.getLocation().then((location) {
      _currentLocation = location;
    });
    _location?.onLocationChanged.listen((newLocation) {
      _currentLocation = newLocation;
      moveToPosition(LatLng(_currentLocation?.latitude ?? 0, _currentLocation?.longitude ?? 0));
    });
  }

  moveToPosition(LatLng latLng) async {
    GoogleMapController mapController = await _googleMapController.future;
    mapController.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(
                target: latLng,
                zoom: 15
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: _buildBody(),
      appBar: AppBar(title: Text("Find Your Cycle"),),
    );
  }

  Widget _buildBody() {
    return _getMap();
  }

  Widget _getMarker() {
    User? user = _auth.currentUser;
    Future<void> getSingleDocument() async {
      try {
        print("hellopew");
        // Get a reference to the Firestore collection
        CollectionReference collection = FirebaseFirestore.instance.collection('users');

        // Get a reference to the specific document using its document ID
        DocumentSnapshot document = await collection.doc(user!.uid).get();
        print("hellopew");
        // Check if the document exists
        if (document.exists) {
          print("hellopew1");
          // Access the data in the document
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          print(data);

          // You can access fields in the document like this:
          image = data['photoURL'];
          // ... and so on
          print("donr");

          print('Data from the document: $image');
        } else {
          print('Document does not exist');
        }
      } catch (e) {
        print('Error getting document: $e');
      }
    }
    getSingleDocument();
    return Container(
      width: 40,
      height: 40,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(0,3),
                spreadRadius: 4,
                blurRadius: 6
            )
          ]
      ),
      child:   FutureBuilder(
        future: getSingleDocument(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Image has been fetched, build the UI
            return CircleAvatar(
              radius: 30,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(image!),
            );
          } else {
            // Image is still loading, display a loading indicator or placeholder
            return CircularProgressIndicator(); // You can replace this with your own loading widget
          }
        },
      )
    );
  }

  Widget _getMap() {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: _cameraPosition!,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            // now we need a variable to get the controller of google map
            if (!_googleMapController.isCompleted) {
              _googleMapController.complete(controller);
            }
          },
        ),

        Positioned.fill(
            child: Align(
                alignment: Alignment.center,
                child: _getMarker()
            )
        )
      ],
    );
  }
}
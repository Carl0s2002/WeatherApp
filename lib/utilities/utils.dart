
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';


TextStyle getDescriptionTextStyle() {
  return const TextStyle(
    color: Colors.white ,
    fontSize: 14
  );
}

pickImage(ImageSource source) async{
    final ImagePicker _imagePicker = ImagePicker() ;
    XFile? _file = await _imagePicker.pickImage(source: source) ; 

    if (_file != null ){
      return await _file.readAsBytes() ;
    }
    print("No Images selected") ;
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  return await Geolocator.getCurrentPosition() ;
}

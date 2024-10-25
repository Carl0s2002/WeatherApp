
import 'package:flutter/material.dart';
TextStyle getDescriptionTextStyle() {
  return const TextStyle(
    color: Colors.white ,
    fontSize: 14
  );
}

// pickImage(ImageSource source) async{
//     final ImagePicker _imagePicker = ImagePicker() ;
//     XFile? _file = await _imagePicker.pickImage(source: source) ; 

//     if (_file != null ){
//       return await _file.readAsBytes() ;
//     }
//     print("No Images selected") ;
// }
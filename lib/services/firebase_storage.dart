import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageServices {

    final storageRef = FirebaseStorage.instance.ref() ;

    Future<String> uploadProfilePic(Uint8List _image , String? imageName) async {
        final uploadTask = storageRef
            .child("profilePic/${imageName}.jpg")
            .putData(_image) ;

        TaskSnapshot taskSnapshot = await uploadTask ;

        String downloadURL = await taskSnapshot.ref.getDownloadURL() ;

        return downloadURL ;
    }

}
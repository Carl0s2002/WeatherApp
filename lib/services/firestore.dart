import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

    final db = FirebaseFirestore.instance ;


    Future<void> addTest(){
    final test = <String, String>{
      "Name" : "Carlos" , 
      "State" : "Working!" 
    } ;
    return db.collection("Test").doc("TestingPhase").set(test).onError((e, _) => print("Error when writing document: $e")) ;
  }

}
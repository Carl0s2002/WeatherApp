import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wheather_app/models/user.dart';

class FirestoreService {

    final db = FirebaseFirestore.instance ;


    Future<void> createOrEditUser(AppUser user) async{
    final userDetails = <String, String>{
      "First Name" :user.firstName , 
      "Last Name" : user.lastName , 
      "Country" : user.country ,  
      "City" : user.city ,
      "Email" : user.email , 
      "Profile Picture" : user.profilePic
    } ;
    await db
              .collection("users")
              .doc(user.email)
              .set(userDetails)
              .onError((e, _) => print("Error when writing document: $e")) ;
  }

  Future<AppUser> getUser(String email) async {
  final docRef = db.collection("users").doc(email);
  
  try {    
    DocumentSnapshot doc = await docRef.get();   
    if (doc.exists) {     
      var data = doc.data() as Map<String, dynamic>;
      AppUser user = AppUser(
        firstName: data['First Name'],  
        lastName: data['Last Name'],    
        country: data['Country'],      
        city: data['City'],            
        email: email , 
        profilePic: data['Profile Picture']                   
      );
      return user;
    } else {
      throw Exception("User not found");
    }
  } catch (e) {
    print("Error getting document: $e");
    throw e; 
  }
}

}
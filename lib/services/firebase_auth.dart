import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final auth = FirebaseAuth.instance ;

  Future<void> createAccount(String email , String password) async {
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password) ;
    } on FirebaseAuthException catch(e) {
      if ( e.code == 'email-already-in-use'){
          print("Email already in use") ;
      }
    }
  }

  Future<bool> login(String email , String password) async{
    bool success = true ;
     try{
      await auth.signInWithEmailAndPassword(email: email, password: password) ;
     } on FirebaseAuthException catch(e){
        if ( e.code == 'user-not-found') {
          print("No user found for this email") ;
          success = false ;
        }
     }
     return success;
  }

}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<void> logout() async{
    if ( auth.currentUser!.providerData[0].providerId == "google.com") {
        final googleSignIn = GoogleSignIn() ;
        await googleSignIn.signOut() ;
    }
    else{
      await auth.signOut() ;
    }
  } 

  Future<UserCredential> signInWithGoogle() async {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

  if (googleUser == null) {

    throw Exception("Sign-in canceled by user.");
  }

  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  return await FirebaseAuth.instance.signInWithCredential(credential);
}

}
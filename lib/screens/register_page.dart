
import 'package:flutter/material.dart';
import 'package:wheather_app/models/user.dart';
import 'package:wheather_app/services/firebase_auth.dart';
import 'package:wheather_app/services/firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{

  final firstName  = TextEditingController() ;
  final lastName  = TextEditingController() ;
  final email  = TextEditingController() ;
  final password  = TextEditingController() ;
  final country  = TextEditingController() ;
  final city  = TextEditingController() ;
  final confirmPassword = TextEditingController();

  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 68, 71, 255),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Register" , style: TextStyle( fontSize: 30 , color: Colors.white),) ,
                SizedBox(height: 20,),
                Container(width:300 , child:  TextField(
                  controller: firstName,
                  decoration: InputDecoration(
                  border: OutlineInputBorder(), 
                  hintText: "First Name", 
                  label: Text("First Name"), 
                ),
                )
                ) ,
                SizedBox(height: 20,),
                Container(width:300 , child:  TextField(
                  controller: lastName,
                  decoration: InputDecoration(
                  border: OutlineInputBorder(), 
                  hintText: "Last Name", 
                  label: Text("Last Name")
                ),
                )
                ) ,
                SizedBox(height: 20,),
                Container(width:300 , child:  TextField(
                  controller: country,
                  decoration: InputDecoration(
                  border: OutlineInputBorder(), 
                  hintText: "Country", 
                  label: Text("Country")
                ),
                )
                ) ,
                SizedBox(height: 20,),
                Container(width:300 , child:  TextField(
                  controller: city,
                  decoration: InputDecoration(
                  border: OutlineInputBorder(), 
                  hintText: "City", 
                  label: Text("City")
                ),
                )
                ) ,
                SizedBox(height: 20,),
                Container(width:300 , child:  TextField(
                  controller: email,
                  decoration: InputDecoration(
                  border: OutlineInputBorder(), 
                  hintText: "Email", 
                  label: Text("Email")
                ),
                )
                ) ,
                SizedBox(height: 20,),
                Container(width:300 , child:  TextField(
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(
                  border: OutlineInputBorder(), 
                  hintText: "Password", 
                  label: Text("Password")
                ),
                )
                ) ,
                SizedBox(height: 20,),
                Container(width:300 , child:  TextField(
                  obscureText: true,
                  controller: confirmPassword,
                  decoration: InputDecoration(
                  border: OutlineInputBorder(), 
                  hintText: "Confirm Password", 
                  label: Text("Confirm Password")
                ),
                )
                ) ,
                SizedBox(height: 20,),
                ElevatedButton(style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent ,
                  foregroundColor: Colors.white, 
                  minimumSize: Size(200, 30) 
                ),onPressed: () async{
                  if ( firstName.text.isNotEmpty && 
                       lastName.text.isNotEmpty &&
                       country.text.isNotEmpty &&
                       city.text.isNotEmpty &&
                       email.text.isNotEmpty &&
                       password.text.isNotEmpty &&
                       confirmPassword.text.isNotEmpty && 
                       password.text == confirmPassword.text
                  ){
                  AppUser user = AppUser(firstName: firstName.text, lastName: lastName.text, country: country.text, city: city.text , email: email.text);
                  FirebaseAuthService firebaseAuthService = FirebaseAuthService() ;
                  FirestoreService firestoreService = FirestoreService() ;
                  await firebaseAuthService.createAccount(email.text, password.text) ;
                  await firestoreService.createOrEditUser(user) ;
                  Navigator.pop(context) ;
                  }
                  }, child: Text("Register")),
                  ElevatedButton(style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent ,
                  foregroundColor: Colors.white, 
                  minimumSize: Size(200, 30) 
                ),onPressed: (){
                  Navigator.pop(context) ;
                  }
                  , child: Text("Back")),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheather_app/models/user.dart';
import 'package:wheather_app/providers/user_provider.dart';
import 'package:wheather_app/screens/home_page.dart';
import 'package:wheather_app/screens/register_page.dart';
import 'package:wheather_app/services/firebase_auth.dart';
import 'package:wheather_app/services/firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool isLoading = false; 
  String? errorMessage; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 68, 71, 255),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login", style: TextStyle(fontSize: 30, color: Colors.white)),
              SizedBox(height: 20),
              Container(
                width: 300,
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Email",
                    label: Text("Email"),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 300,
                child: TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Password",
                    label: Text("Password"),
                  ),
                ),
              ),
              if (errorMessage != null) 
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  foregroundColor: Colors.white,
                  minimumSize: Size(200, 30),
                ),
                onPressed: isLoading
                    ? null 
                    : () async {
                        setState(() {
                          isLoading = true; 
                          errorMessage = null; 
                        });

                        if (email.text.isNotEmpty && password.text.isNotEmpty) {
                          FirebaseAuthService firebaseAuthService = FirebaseAuthService();
                          FirestoreService firestoreService = FirestoreService();
                          var loginResponse = await firebaseAuthService.login(email.text, password.text);

                          if (loginResponse == true) {
                            try {
                              AppUser user = await firestoreService.getUser(email.text);
                              Provider.of<UserProvider>(context, listen: false).setUser(user);
                              setState(() {
                                isLoading = false ;
                              });
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage())); 
                            } catch (e) {
                              setState(() {
                                errorMessage = "Failed to fetch user data.";
                                isLoading = false;
                              });
                            }
                          } else {
                            setState(() {
                              errorMessage = "Login failed. Please check your credentials.";
                              isLoading = false;
                            });
                          }
                        } else {
                          setState(() {
                            errorMessage = "Please fill in all fields.";
                            isLoading = false;
                          });
                        }
                      },
                child: isLoading ? CircularProgressIndicator() : Text("Log in"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  foregroundColor: Colors.white,
                  minimumSize: Size(200, 30),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()),
                  );
                },
                child: Text("Register"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  foregroundColor: Colors.white,
                  minimumSize: Size(200, 30),
                ),
                onPressed: () async {

                    FirebaseAuthService firebaseAuthService = FirebaseAuthService() ;
                    var credentials = await firebaseAuthService.signInWithGoogle() ;
                    print("HERE!!!!!!!!!!!!!!!!! $credentials") ;

                },
                child: Text("Sign in with Google"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  foregroundColor: Colors.white,
                  minimumSize: Size(200, 30),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MyHomePage()),
                  );
                },
                child: Text("Go to Home Page"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheather_app/providers/user_provider.dart';
import 'package:wheather_app/services/firestore.dart';

class EditPage extends StatefulWidget{

  const EditPage({super.key}) ;

  State<EditPage> createState() => __EditPageState() ;

}

class __EditPageState extends State<EditPage>{

    Widget build(BuildContext context ){
      final userProvider = Provider.of<UserProvider>(context) ;
      var user = userProvider.user ;
      var firstName = TextEditingController(text:user!.firstName) ;
      var lastName = TextEditingController(text:user.lastName) ;
      var country = TextEditingController(text:user.country) ;
      var city = TextEditingController(text:user.city) ;
      return Scaffold(
        body: Container(
          color: const Color.fromARGB(255, 68, 71, 255),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height:60) ,
                Container(width:300 , child:  TextField(
                controller: firstName,
                decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "First Name"  
                ),
                )
                ) ,
                SizedBox(height: 20,),
                Container(width:300 , child:  TextField(
                  controller: lastName,
                  decoration: InputDecoration(
                  border: OutlineInputBorder(),  
                  labelText: "Last Name"
                ),
                )
                ) ,
                SizedBox(height: 20,),
                Container(width:300 , child:  TextField(
                  controller: country,
                  decoration: InputDecoration(
                  border: OutlineInputBorder(), 
                  labelText: "Country"
                ),
                )
                ) ,
                SizedBox(height: 20,),
                Container(width:300 , child:  TextField(
                  controller: city,
                  decoration: InputDecoration(
                  border: OutlineInputBorder(), 
                  labelText: "City"
                ),
                )
                ),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: () async
                { 
                  FirestoreService firestoreService = FirestoreService() ;
                  user.firstName = firstName.text ;
                  user.lastName = lastName.text ;
                  user.country = country.text ;
                  user.city = city.text ;
                  userProvider.setUser(user) ;
                  await firestoreService.createOrEditUser(user) ;
                  Navigator.pop(context);
                }, 
                child: Text("Save changes") , style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent ,
                foregroundColor: Colors.white, 
                minimumSize: Size(200, 30),  
              ),),
                SizedBox(height: 10,),
                ElevatedButton(onPressed: (){ Navigator.pop(context);}, child: Text("Back") , style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent ,
                foregroundColor: Colors.white, 
                minimumSize: Size(200, 30),  
              ),),
              ],
            ),
          ),
        )
      );
    }

}
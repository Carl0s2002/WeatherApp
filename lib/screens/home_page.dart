import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheather_app/providers/user_provider.dart';
import 'package:wheather_app/screens/profile_page.dart';
import 'package:wheather_app/services/firestore.dart';
import 'package:wheather_app/utilities/utils.dart' as utils;

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  
  final FirestoreService firestoreService = FirestoreService() ;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    return Scaffold( 
      body: 
      Container(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        color: const Color.fromARGB(255, 68, 71, 255),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 28),
            Icon(Icons.location_pin , color: Colors.orangeAccent,), 
            SizedBox(height: 10,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent ,
                foregroundColor: Colors.white, 
                minimumSize: Size(200, 30) 
              ),
              onPressed: ()
                {print("Pressed");},
              child: Text("Tg Mures" , style: TextStyle(
                fontSize: 30 ,
              ),
              ),
               ),
            SizedBox(height: 40,),
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text("27" , style: TextStyle(fontSize: 134,
              color: Colors.white),
              ),
              Text("\u00B0C" ,  style: TextStyle(
                fontSize: 40,
                color: Colors.white
              ),
              )
            ]
            ), 
            Text("Cloudy" , style: TextStyle(
              fontSize: 30 , 
              color: Colors.white
            ),
            ),
            SizedBox(height: 120,),
            Container(
              width: 300,
            child: 
              Row( 
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Clouds" , style: utils.getDescriptionTextStyle()  ),
                  Text("88%" , style: utils.getDescriptionTextStyle() ),
                ],
            ),
            ),
            SizedBox(height: 10,),
            Container(
              width: 300,
              child: Row( 
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Rain" , style: utils.getDescriptionTextStyle()  ),
                  Text("50%" , style: utils.getDescriptionTextStyle() ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: 300,
              child: Row( 
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Wind" , style: utils.getDescriptionTextStyle()  ),
                  Text("100 km/h" , style: utils.getDescriptionTextStyle() ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: 300,
              child: Row( 
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Visibility" , style: utils.getDescriptionTextStyle()  ),
                  Text("500m" , style: utils.getDescriptionTextStyle() ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: 300,
              child: Row( 
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Humidity" , style: utils.getDescriptionTextStyle()  ),
                  Text("64%" , style: utils.getDescriptionTextStyle() ),
                ],
              ),
            ),
            SizedBox(height: 100,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent ,
                foregroundColor: Colors.white, 
                minimumSize: Size(270, 40) 
              ),
              onPressed: ()
                {
                  if ( user != null ){
                  final lastname = user.lastName ;
                  print("Welcome $lastname");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage())) ;
                  }
                  },
              child: Text("My Profile" , style: TextStyle(
                fontSize: 24 ,
              ),
              ),
               ),
          ],
        ),
      ),
    ),
    );
  }    
}


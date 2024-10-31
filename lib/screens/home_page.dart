import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:wheather_app/models/user.dart';
import 'package:wheather_app/models/weather.dart';
import 'package:wheather_app/providers/user_provider.dart';
import 'package:wheather_app/providers/weather_provider.dart';
import 'package:wheather_app/screens/profile_page.dart';
import 'package:wheather_app/services/firebase_auth.dart';
import 'package:wheather_app/services/firestore.dart';
import 'package:wheather_app/services/weather_service.dart';
import 'package:wheather_app/utilities/utils.dart' as utils;
import 'package:http/http.dart' as http;
import 'package:wheather_app/viewModels/weather_viewModel.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  WeatherViewModel weatherViewModel  = WeatherViewModel() ;
  final WeatherService weatherService = WeatherService() ;
  final FirestoreService firestoreService = FirestoreService() ;

  @override
  void initState() {
    super.initState() ;
    getLocationAndFetchWeather() ;
  }

  Future<void> getLocationAndFetchWeather() async { 
      final weatherProvider = Provider.of<WeatherProvider>(context , listen: false) ;
      await weatherViewModel.fetchAndUploadWeather(weatherProvider) ;
      await weatherViewModel.loadWeatherData(weatherProvider) ;
      setState(() {});
  }

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
        child:  Column(
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
                child: Text(weatherViewModel.currentWeather.name , style: TextStyle(
                  fontSize: 30 ,
                ),
                ),
                 ),
              SizedBox(height: 40,),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text( weatherViewModel.currentWeather.temp.toStringAsFixed(1) , style: TextStyle(fontSize: 134,
                color: Colors.white),
                ),
                Text("\u00B0C" ,  style: TextStyle(
                  fontSize: 40,
                  color: Colors.white
                ),
                )
              ]
              ), 
              Text(weatherViewModel.currentWeather.description , style: TextStyle(
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
                    Text("${weatherViewModel.currentWeather.clouds}%" , style: utils.getDescriptionTextStyle() ),
                  ],
              ),
              ),
              SizedBox(height: 10,),
              Container(
                width: 300,
              child: 
                Row( 
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Rain" , style: utils.getDescriptionTextStyle()  ),
                    Text("${weatherViewModel.currentWeather.humidity}%" , style: utils.getDescriptionTextStyle() ),
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
                    Text("${weatherViewModel.currentWeather.wind}km/h" , style: utils.getDescriptionTextStyle() ),
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
                    Text("${weatherViewModel.currentWeather.visibility}m" , style: utils.getDescriptionTextStyle() ),
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
                    Text("${weatherViewModel.currentWeather.humidity}%" , style: utils.getDescriptionTextStyle() ),
                  ],
                ),
              ),
              SizedBox(height: 100,),
              user != null ?
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
                 )
                 :
                 ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent ,
                  foregroundColor: Colors.white, 
                  minimumSize: Size(270, 40) 
                ),
                onPressed: ()
                  {
                    Navigator.pop(context) ;
                    },
                child: Text("Log in" , style: TextStyle(
                  fontSize: 24 ,
                ),
                ),
                 ),
                 SizedBox(height: 10,) , 
                 user != null ?
                 ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent ,
                  foregroundColor: Colors.white, 
                  minimumSize: Size(270, 40) 
                ),
                onPressed: ()async
                  {
                    FirebaseAuthService firebaseAuthService = FirebaseAuthService() ;
                    userProvider.setUser(null) ;
                    await firebaseAuthService.logout() ;
                    Navigator.pop(context) ;
                  },
                  child: Text("Log out" , style: TextStyle(
                  fontSize: 24 ,
                ),
                ),
                 )
                 :
                 SizedBox.shrink()
            ],
          ),
      ),
    ),
    );
  }    
}


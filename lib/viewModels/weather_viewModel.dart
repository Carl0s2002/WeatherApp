import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:wheather_app/models/weather.dart';
import 'package:wheather_app/providers/weather_provider.dart';
import 'package:wheather_app/services/firestore.dart';
import 'package:wheather_app/services/weather_service.dart';
import 'package:wheather_app/utilities/utils.dart' as utils ;

class WeatherViewModel extends ChangeNotifier {
  final WeatherService weatherService = WeatherService();
  final FirestoreService firestoreService = FirestoreService();

  Weather currentWeather = Weather(name: "Loading.." , temp: 0, description: "Loading.." , clouds: 0 , wind: 0 , visibility: 0 , humidity: 0 );

  Future<void> fetchAndUploadWeather(WeatherProvider weatherProvider) async {
    try {
      if (  weatherProvider.weather == null || weatherProvider.weather!.name == "Loading.." ) {
      Position location = await utils.determinePosition();
      print(location) ;
      currentWeather = await weatherService.fetchWeather(location.latitude, location.longitude);
      await firestoreService.createOrEditWeather(currentWeather);
      notifyListeners();
      }
      else {
        currentWeather = weatherProvider.weather! ;
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> loadWeatherData(WeatherProvider weatherProvider) async {
    if ( weatherProvider.weather == null || weatherProvider.weather!.name == "Loading..") {
    Weather weather = currentWeather ;
    currentWeather = await firestoreService.fetchWeatherData(weather.name);
    weatherProvider.setWeather(currentWeather) ;
    notifyListeners(); 
    }
    else {
      currentWeather = weatherProvider.weather! ;
    }
  }
}

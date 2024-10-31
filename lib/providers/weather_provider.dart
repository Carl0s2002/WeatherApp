import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:wheather_app/models/weather.dart';

class WeatherProvider extends ChangeNotifier {

    Weather? _weather ;
    Timer? _timer ;

    Weather? get weather => _weather ;

    void setWeather( Weather? weather ) {
      _weather = weather;
      notifyListeners() ;

      _timer?.cancel() ;

      _timer = Timer(Duration(minutes: 5), () {
        final weatherHelper = Weather(name: "Loading.." , temp: 0, description: "Loading.." , clouds: 0 , wind: 0 , visibility: 0 , humidity: 0 ) ;
        setWeather(weatherHelper) ;
        notifyListeners() ;
      }) ;

    }

}
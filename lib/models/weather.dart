class Weather {
  final String name ;
  final double temp ;
  final String description ;
  final int clouds ;
  final double wind ;
  final int visibility ;
  final int humidity ;

  Weather ({
    required this.name , 
    required this.temp ,
    required this.description ,
    required this.clouds ,
    required this.wind ,
    required this.visibility, 
    required this.humidity
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'name' : String name ,
        'main': { 'temp' : num temp ,
                  'humidity' : int humidity
        },
        'weather': [ {'main': String description} ] ,
        'clouds' : {'all' : int clouds} ,
        'wind' : {'speed' : num wind} ,
        'visibility' : int visibility 
      } =>
        Weather(
          name: name,
          temp: (temp -273.15).toDouble() ,
          description: description , 
          clouds: clouds , 
          wind: wind.toDouble() , 
          visibility: visibility , 
          humidity: humidity
        ),
      _ => throw const FormatException('Failed to load data.'),
    };
  }

}



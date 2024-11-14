import 'package:weather_application/model/forecast.dart';

class WeatherData {
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final String description;
  final String icon;
  final double windSpeed;
  final String cityName;
  final int cloudiness;
  final String country;
  final int sunrise;
  final int sunset;
  final List<Forecast> forecast;

  WeatherData({
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.description,
    required this.icon,
    required this.windSpeed,
    required this.cityName,
    required this.cloudiness,
    required this.country,
    required this.sunrise,
    required this.sunset,
    required this.forecast,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    List<Forecast> forecastList = [];
    return WeatherData(
      temperature:
          (json['main']['temp'] is int) ? (json['main']['temp'] as int).toDouble() : json['main']['temp'],
      feelsLike: json['main']['feels_like'],
      tempMin: json['main']['temp_min'],
      tempMax: json['main']['temp_max'],
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      windSpeed: json['wind']['speed'],
      cityName: json['name'],
      cloudiness: json['clouds']['all'],
      country: json['sys']['country'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      forecast: forecastList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'feelsLike': feelsLike,
      'tempMin': tempMin,
      'tempMax': tempMax,
      'pressure': pressure,
      'humidity': humidity,
      'description': description,
      'icon': icon,
      'windSpeed': windSpeed,
      'cityName': cityName,
      'cloudiness': cloudiness,
      'country': country,
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }
}
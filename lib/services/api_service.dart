import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_application/model/forecast.dart';
import 'package:weather_application/model/weather_data.dart';

class ApiService {
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String forecastUrl = 'https://api.openweathermap.org/data/2.5/forecast';

  Future<WeatherData> fetchWeather(String city) async {
    final apiKey = dotenv.env['API_KEY'];
    if (apiKey == null) {
      throw Exception('API key is missing.');
    }

    final response = await http.get(Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return WeatherData.fromJson(jsonData);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<WeatherData> fetchWeatherByLocation(double latitude, double longitude) async {
    final apiKey = dotenv.env['API_KEY'];
    if (apiKey == null) {
      throw Exception('API key is missing.');
    }
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return WeatherData.fromJson(jsonData);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<List<Forecast>> fetchForecast(String city) async {
    final apiKey = dotenv.env['API_KEY'];
    if (apiKey == null) {
      throw Exception('API key is missing.');
    }

    final response = await http.get(Uri.parse('$forecastUrl?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<Forecast> forecastList = [];
      for (var item in jsonData['list']) {
        forecastList.add(Forecast.fromJson(item));
      }
      return forecastList;
    } else {
      throw Exception('Failed to load forecast data');
    }
  }

  Future<List<Forecast>> fetchForecastByLocation(double latitude, double longitude) async {
    final apiKey = dotenv.env['API_KEY'];
    if (apiKey == null) {
      throw Exception('API key is missing.');
    }

    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<Forecast> forecastList = [];
      for (var item in jsonData['list']) {
        forecastList.add(Forecast.fromJson(item));
      }
      return forecastList;
    } else {
      throw Exception('Failed to load forecast data');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_application/model/forecast.dart';
import 'package:weather_application/services/api_service.dart';
import 'package:weather_application/model/weather_data.dart';
import 'package:geolocator/geolocator.dart';

class HomeController extends GetxController {
  TextEditingController searchController = TextEditingController();

  var isLoading = false.obs;
  var weatherData = Rxn<WeatherData>();
  var errorMessage = ''.obs;
  var forecastData = Rx<List<Forecast>>([]);

  @override
  void onInit() {
    super.onInit();
    // Fetch weather data based on device's location when the app starts
    _getLocationAndFetchWeather();
  }

  // Function to get the device's location and fetch weather data
  Future<void> _getLocationAndFetchWeather() async {
    isLoading.value = true;
    errorMessage.value = '';
    weatherData.value = null;
    forecastData.value = [];

    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        errorMessage.value = 'Location services are disabled.';
        return;
      }

      // Request permission to access location
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
          _showPermissionDialog();
          errorMessage.value = 'Location permission denied.';
          isLoading.value = false;
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
      );

      // Fetch weather data using latitude and longitude
      await fetchWeatherByLocation(position.latitude, position.longitude);
    } catch (e) {
      errorMessage.value = 'Failed to get location or fetch weather: $e';
      isLoading.value = false;
    }
  }

  void _showPermissionDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text("Location Permission Required"),
        content: const Text("This app needs location access to display weather data for your area."),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Get.back();
              await openAppSettings(); // Opens app settings
            },
            child: const Text("Settings"),
          ),
        ],
      ),
    );
  }

  Future<void> fetchWeather(String city) async {
    isLoading.value = true;
    errorMessage.value = '';
    weatherData.value = null;
    forecastData.value = [];

    try {
      var data = await ApiService().fetchWeather(city);
      weatherData.value = data;
      var forecast = await ApiService().fetchForecast(city); // Fetch forecast
      forecastData.value = forecast;
    } catch (e) {
      errorMessage.value = 'City not found!';
    }

    isLoading.value = false;
  }

  // Function to fetch weather by location (latitude and longitude)
  Future<void> fetchWeatherByLocation(double latitude, double longitude) async {
    isLoading.value = true;
    errorMessage.value = '';
    weatherData.value = null;
    forecastData.value = [];

    try {
      var data = await ApiService().fetchWeatherByLocation(latitude, longitude);
      weatherData.value = data;
      var forecast = await ApiService().fetchForecastByLocation(latitude, longitude);
      forecastData.value = forecast;
    } catch (e) {
      errorMessage.value = 'Weather fetch failed: $e';
    }

    isLoading.value = false;
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}

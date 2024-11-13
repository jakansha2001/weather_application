import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_application/services/api_service.dart';
import 'package:weather_application/model/weather_data.dart';

class HomeController extends GetxController {
  TextEditingController searchController = TextEditingController();

  var isLoading = false.obs;
  var weatherData = Rxn<WeatherData>();
  var errorMessage = ''.obs;

  Future<void> fetchWeather(String city) async {
    isLoading.value = true;
    errorMessage.value = '';
    weatherData.value = null;

    try {
      var data = await ApiService().fetchWeather(city);
      weatherData.value = data;
    } catch (e) {
      errorMessage.value = 'City not found!';
    }

    isLoading.value = false;
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}

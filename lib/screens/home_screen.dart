import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_application/controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff161621),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: homeController.searchController,
                      decoration: const InputDecoration(
                        hintText: 'Enter city name',
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ).paddingOnly(left: 10),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    alignment: Alignment.center,
                    icon: const Icon(
                      color: Colors.white,
                      Icons.search_rounded,
                      size: 40,
                    ),
                    onPressed: () {
                      if (homeController.searchController.text.isNotEmpty) {
                        homeController.fetchWeather(homeController.searchController.text);
                      }
                    },
                  ),
                ],
              ).paddingOnly(top: 12),
              const SizedBox(height: 45),
              Obx(() {
                final data = homeController.weatherData.value;
                final isLoading = homeController.isLoading.value;

                if (isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (data != null) {
                  return Column(
                    children: [
                      Text(
                        data.cityName,
                        maxLines: 2,
                        style:
                            GoogleFonts.inter(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${data.temperature}°C',
                        maxLines: 2,
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 78),
                      ),
                      Text(
                        data.description,
                        maxLines: 2,
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 18),
                      ),
                      const SizedBox(height: 25),
                      Text('Wind Speed: ${data.windSpeed} m/s',
                          maxLines: 2, style: GoogleFonts.inter(color: Colors.white, fontSize: 18)),
                      Text('Humidity: ${data.humidity}%',
                          maxLines: 2, style: GoogleFonts.inter(color: Colors.white, fontSize: 18)),
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.network(
                          'https://openweathermap.org/img/wn/${data.icon}@2x.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  );
                } else if (homeController.errorMessage.isNotEmpty) {
                  return Center(
                      child: Text(homeController.errorMessage.value,
                          style: GoogleFonts.inter(color: Colors.white, fontSize: 18)));
                }

                return const SizedBox();
              }),
            ],
          ),
        )),
      ),
    );
  }
}

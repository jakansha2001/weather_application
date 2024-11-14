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
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 14, 17, 23),
          elevation: 0,
          title: Text('Weather Application',
              style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w500)),
        ),
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
                        hintText: 'Search for a location',
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
              ).paddingOnly(top: 18),
              const SizedBox(height: 45),
              Obx(() {
                final data = homeController.weatherData.value;
                final isLoading = homeController.isLoading.value;
                final forecast = homeController.forecastData.value;

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
                        data.description.toUpperCase(),
                        maxLines: 2,
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 18),
                      ),
                      const SizedBox(height: 25),
                      Text('Wind Speed: ${data.windSpeed} m/s',
                          maxLines: 2,
                          style: GoogleFonts.inter(
                              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),
                      Text('Humidity: ${data.humidity}%',
                          maxLines: 2,
                          style: GoogleFonts.inter(
                              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),
                      SizedBox(
                        width: 180,
                        height: 180,
                        child: Image.network(
                          'https://openweathermap.org/img/wn/${data.icon}@2x.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      // 5-day forecast
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 14, 17, 23),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: const Text(
                            '5-Day Forecast',
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ).paddingAll(14),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (forecast.isNotEmpty)
                        SizedBox(
                          height: 150,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: forecast.length,
                            itemBuilder: (context, index) {
                              var forecastItem = forecast[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Column(
                                  children: [
                                    Text(forecastItem.date, style: const TextStyle(color: Colors.white)),
                                    const SizedBox(height: 5),
                                    Image.network(
                                      'https://openweathermap.org/img/wn/${forecastItem.icon}@2x.png',
                                      width: 50,
                                      height: 50,
                                    ),
                                    const SizedBox(height: 5),
                                    Text('${forecastItem.temp}°C',
                                        style: const TextStyle(
                                            color: Colors.white, fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 5),
                                    Text(forecastItem.description,
                                        style: const TextStyle(color: Colors.white)),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      else
                        const Text('No forecast data available', style: TextStyle(color: Colors.white)),
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

# Weather Application

This is a simple weather application built with Flutter that allows users to search for weather information of a specific city or fetch weather data based on their current location. The app fetches both current weather data and a 5-day forecast using the OpenWeatherMap API.

## Features

- Weather Data: Displays current weather data such as temperature, wind speed, humidity, and a description of the weather condition.
- 5-Day Forecast: Shows a 5-day forecast with the date, temperature, and weather condition for each day.
- Location-based Weather: Fetch weather data based on the user's current location using Geolocator.
- Search Functionality: Allows users to search for weather data by entering a city name.

## App Demo

https://github.com/user-attachments/assets/70796705-1ea4-49d6-b03c-ec2b3adc270f

## Packages Used

- GetX: A lightweight state management solution to manage the app's state and make it reactive. This ensures that weather data, loading states, and error messages are automatically updated when the state changes.
- Geolocator: To get the device's current geographical location for fetching weather based on location.
- Google Fonts: Used to style text in the app with custom fonts.
- http: To make network requests to fetch weather data from the OpenWeatherMap API.

## How It Works
### Fetching Weather Data
- By City Name: The user can enter the name of a city in the search bar to fetch the current weather data and the 5-day forecast.
- By Current Location: The app automatically fetches weather data based on the user's location when the app is launched.

### GetX State Management
GetX is used to manage the app's state in a reactive way:

- HomeController: The controller responsible for managing the state, including weather data, loading state, and error messages.
- Reactive Variables: Observables like Rxn<WeatherData> and Rx<List<Forecast>> hold the data, and the UI is automatically updated when the data changes.

### Location Permission
The app requests location permissions to fetch weather data based on the user's current location. If permission is denied, the user is prompted to allow location access.

## Error Handling
- Location Access Denial: Shows a message if location services are disabled or permissions are denied.
- City Not Found: Displays a message if the city entered by the user is not found.
- API Errors: Handles network errors and displays an appropriate message to the user.

## Project Setup

To run the Weather App on your local machine, follow these steps:

1. **Clone the repository:**

   ```bash
   git clone https://github.com/jakansha2001/weather_application

2. **Navigate to the project directory:**

   ```bash
   cd weather_application

3. **Install dependencies:**

   Ensure all dependencies are installed by running:

   ```bash
   flutter pub get

4. **Run the app:**

   Use the following command to launch the app on an emulator or connected device:

   ```bash
   flutter run

## Configuration
1. API Key: To get the weather data from OpenWeatherMap, you need to sign up for a free account on [OpenWeatherMap](https://openweathermap.org/) and obtain an API key. Once you have the key, store it in an environment file.

Follow these steps to set up the .env file:
- Create a ```.env``` file at the root of your project and add your API key in the following format:
  
  ```bash
   API_KEY=your_api_key

2. Location Permissions: Ensure that location permissions are properly set for both Android and iOS platforms.

- For Android, add the following permissions in ```android/app/src/main/AndroidManifest.xml```:
 
   ```bash
  <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
  <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>

- For iOS, add the following keys to ```ios/Runner/Info.plist```:
 
   ```bash
  <key>NSLocationWhenInUseUsageDescription</key>
  <string>Your location is needed to fetch weather data</string>

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvement, please open an issue or create a pull request on GitHub.

class Forecast {
  final String date;
  final String description;
  final String icon;
  final double temp;

  Forecast({
    required this.date,
    required this.description,
    required this.icon,
    required this.temp,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000);
    return Forecast(
      date: '${dateTime.day}/${dateTime.month}/${dateTime.year}',
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      temp: (json['main']['temp'] is int) ? (json['main']['temp'] as int).toDouble() : json['main']['temp'],
    );
  }
}

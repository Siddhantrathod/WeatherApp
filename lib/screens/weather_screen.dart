import 'package:flutter/material.dart';
import '../services/weather_services.dart';
import '../models/weather.dart';

class WeatherScreen extends StatefulWidget {
  final String city;

  const WeatherScreen({super.key, required this.city});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Weather> futureWeather;

  // ✅ English + Gujarati descriptions
  final Map<String, Map<String, String>> cityDescriptions = {
    'Ahmedabad': {
      'en': 'Ahmedabad typically experiences a hot and dry climate, with intense summers and mild winters.',
      'gu': 'અમદાવાદમાં સામાન્ય રીતે ઉષ્ણ અને સુકા હવામાન સાથે ઉનાળામાં ભારે ગરમી અને હળવા શિયાળો હોય છે.',
    },
    'Surat': {
      'en': 'Surat has a tropical savanna climate, known for hot summers, mild winters, and significant monsoon rainfall.',
      'gu': 'સુરતમાં ઉષ્ણકટિબંધીય સાવના પ્રકારનું હવામાન છે, જ્યાં ગરમ ઉનાળા, નરમ શિયાળા અને ભારે વરસાદ થાય છે.',
    },
    'Vadodara': {
      'en': 'Vadodara enjoys a semi-arid climate with hot summers, moderate rainfall during monsoon, and pleasant winters.',
      'gu': 'વડોદરામાં ઉષ્ણ અને આર્ધશુષ્ક હવામાન હોય છે waarin ઉનાળામાં ગરમી, મોસમમાં મધ્યમ વરસાદ અને શિયાળામાં ઠંડી રહે છે.',
    },
    'Rajkot': {
      'en': 'Rajkot has a hot semi-arid climate, with extremely hot summers and dry winters.',
      'gu': 'રાજકોટમાં ખૂબ ગરમ ઉનાળા અને સુકા શિયાળાવાળા અર્ધશુષ્ક પ્રકારનું હવામાન છે.',
    },
    'Bhavnagar': {
      'en': 'Bhavnagar experiences a dry climate, with hot weather most of the year and occasional sea breeze.',
      'gu': 'ભવનગરમાં મોટાભાગના વર્ષ દરમિયાન ગરમ અને સુકા હવામાન સાથે ક્યારેક દરિયાઈ પવન લાગે છે.',
    },
  };

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather(widget.city);
  }

  Future<Weather> fetchWeather(String city) async {
    WeatherService weatherService = WeatherService();
    final data = await weatherService.fetchWeather(city);
    return Weather.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);
    String lang = currentLocale.languageCode;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue[100]
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Center(
                child: FutureBuilder<Weather>(
                  future: futureWeather,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(color: Colors.white);
                    } else if (snapshot.hasError) {
                      return Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.white),
                      );
                    } else {
                      final weather = snapshot.data!;
                      final cityInfo = cityDescriptions[widget.city];
                      final cityDescription = cityInfo?[lang] ?? cityInfo?['en'] ?? 'No description available for this city.';

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 50), // Leave space for back button
                            Text(
                              widget.city,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.black45,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              color: Colors.black12.withOpacity(0.2),
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Image.network(
                                      'http://openweathermap.org/img/wn/${weather.icon}@2x.png',
                                      width: 100,
                                      height: 100,
                                    ),
                                    Text(
                                      '${weather.temperature}°C',
                                      style: const TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      weather.description,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      cityDescription,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black12,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
              // ✅ Back Button
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

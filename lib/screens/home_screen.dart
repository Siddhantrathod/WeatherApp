import 'package:flutter/material.dart';
import 'package:weatherapp2/screens/weather_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> cities = [
    {
      'name': 'Ahmedabad',
      'image': 'https://as1.ftcdn.net/v2/jpg/03/84/57/22/1000_F_384572269_3YjcgG90xKYuMDrTMvU6LCvf7AwTl3Af.jpg'
    },
    {
      'name': 'Surat',
      'image': 'https://img.staticmb.com/mbcontent/images/crop/uploads/2024/2/Posh-Areas-in-Surat_0_1200.jpg'
    },
    {
      'name': 'Vadodara',
      'image': 'https://media.istockphoto.com/id/647770280/photo/the-lukshmi-vilas-palace-seen-on-a-bright-sunny-afternoon.jpg?s=2048x2048&w=is&k=20&c=oEErs05GGZ4oCL7wCppjERIgzB_yTqOyhdMH_YOC6Cs='
    },
    {
      'name': 'Rajkot',
      'image': 'https://www.gujarattourism.com/content/dam/gujrattourism/images/gandhi-circuit/mahatma-gandhi-museum-(alfred-high-school)/Mahatma-Gandhi-Museum-Rajkot-Thumbnail.jpg'
    },
    {
      'name': 'Bhavnagar',
      'image': 'https://c1.wallpaperflare.com/preview/853/999/704/palace-nilambagh-palace-heritage-hotel.jpg'
    },
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors. black38,
        centerTitle: true,
        elevation: 2,
        title: const Text(
          'Weather in Gujarat',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: cities.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final city = cities[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeatherScreen(city: city['name']!),
                  ),
                );
              },
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: NetworkImage(city['image']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                  Center(
                    child: Text(
                      city['name']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 8,
                            color: Colors.black54,
                            offset: Offset(1, 1),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

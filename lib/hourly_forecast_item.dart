import 'package:flutter/material.dart';

class HourlyForecastItem extends StatelessWidget {
  final String time;
  final String temperature;
  final IconData icon;

  const HourlyForecastItem(
      {super.key,
      required this.time,
      required this.temperature,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 15),
                Icon(
                  icon,
                  size: 40,
                ),
                const SizedBox(height: 10),
                Text(
                  temperature,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//
//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:weather_app/secrets.dart';
//
// import 'additional_info_item.dart';
// import 'hourly_forecast_item.dart';
//
// class WeatherScreen extends StatefulWidget {
//   const WeatherScreen({super.key});
//
//   @override
//   State<WeatherScreen> createState() => _WeatherScreenState();
// }
//
// class _WeatherScreenState extends State<WeatherScreen> {
//   Future<Map<String, dynamic>> getCurrentWeather() async {
//     try {
//       String cityName = 'London';
//       final res = await http.get(Uri.parse(
//           "https://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=$apikey"));
//       print(res.body);
//
//       final data = jsonDecode(res.body);
//       if (data['cod'] != '200') {
//         throw "An Unexpected Error Occurred";
//       }
//       print(data);
//       return data;
//     } catch (e) {
//       throw e.toString();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Weather App",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//               onPressed: () {
//                 setState(() {});
//               },
//               icon: const Icon(Icons.refresh)),
//         ],
//       ),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: getCurrentWeather(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator.adaptive());
//           }
//           // if (snapshot.hasError) {
//           //   return Center(child: Text(snapshot.error.toString()));
//           // }
//           if (!snapshot.hasData || snapshot.data == null) {
//             return const Center(child: Text("No data available."));
//           }
//
//           final data = snapshot.data!;
//           print(data);
//           final currentWeatherData = data['list'][0];
//
//           final currentTemp = currentWeatherData['main']['temp'];
//           final currentSky = currentWeatherData['weather'][0]['main'];
//           final currentPressure = currentWeatherData['main']['pressure'];
//           final currentWindSpeed = currentWeatherData['wind']['speed'];
//           final currentHumidity = currentWeatherData['main']['humidity'];
//
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   width: double.infinity,
//                   child: Card(
//                     elevation: 10,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16)),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(16),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             const SizedBox(height: 10),
//                             Text(
//                               "${currentTemp.toStringAsFixed(1)}° K",
//                               style: const TextStyle(
//                                 fontSize: 30,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 15),
//                             Icon(
//                               currentSky == 'Clouds' || currentSky == 'Rain'
//                                   ? Icons.cloud
//                                   : Icons.wb_sunny,
//                               size: 70,
//                             ),
//                             const SizedBox(height: 10),
//                             Text(
//                               currentSky,
//                               style: const TextStyle(
//                                 fontSize: 25,
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   "Hourly Forecast",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 15),
//                 Expanded(
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: data['list'].length,
//                     itemBuilder: (context, index) {
//                       final hourlyForecast = data['list'][index];
//                       final hourlySky = hourlyForecast['weather'][0]['main'];
//                       return HourlyForecastItem(
//                         time: hourlyForecast['dt'],
//                         temperature: hourlyForecast['main']['temp'],
//                         icon: hourlySky == 'Clouds' || hourlySky == 'Rain'
//                             ? Icons.cloud
//                             : Icons.wb_sunny,
//                       );
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   "Additional Information",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 15),
//                 Row(
//                   children: [
//                     AdditionalInfoItem(
//                       icon: Icons.water_drop,
//                       label: "Humidity",
//                       value: currentHumidity.toString(),
//                     ),
//                     AdditionalInfoItem(
//                       icon: Icons.air,
//                       label: "Wind Speed",
//                       value: currentWindSpeed.toString(),
//                     ),
//                     AdditionalInfoItem(
//                       icon: Icons.beach_access,
//                       label: "Pressure",
//                       value: currentPressure.toString(),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

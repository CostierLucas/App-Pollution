import 'package:flutter/material.dart';

class Infos extends StatelessWidget {
  final Map list;
  final String city;
  final String lat;
  final String long;

  Infos({
    Key? key,
    required this.list,
    required this.city,
    required this.lat,
    required this.long,
  }) : super(key: key);

  Widget build(BuildContext context) {
    print(list);
    return Scaffold(
      appBar: AppBar(
        title: Text(city),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Coordonnées : ".toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
            Text("Longitude = " + long),
            Text("Lattitude = " + lat),
            Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
            Text(
              "Qualité de l'air :".toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
            Text("Co2 = " + list["list"][0]["components"]["co"].toString()),
            Text("Ozone = " + list["list"][0]["components"]["o3"].toString()),
            Text(
                "Amoniac = " + list["list"][0]["components"]["nh3"].toString()),
            Text("Particule en suspension = " +
                list["list"][0]["components"]["pm10"].toString()),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

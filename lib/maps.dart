import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import './infos.dart';

class Maps extends StatefulWidget {
  Maps({Key? key}) : super(key: key);

  @override
  _Maps createState() => _Maps();
}

class _Maps extends State<Maps> {
  Set<Marker> markers = new Set();
  List _items = [];

  Future readJson() async {
    final String response = await rootBundle.loadString('assets/fr.json');
    setState(() => _items = json.decode(response));
    _items.forEach(
      (element) {
        markers.add(
          Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(
                double.parse(element["lat"]), double.parse(element["lng"])),
            builder: (ctx) => new IconButton(
              onPressed: () =>
                  getAir(element["city"], element["lat"], element["lng"]),
              icon: Icon(Icons.add_location),
            ),
          ),
        );
      },
    );
  }

  Future getAir(String city, String lat, String long) async {
    Map aqi;
    final response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/air_pollution?lat=${lat}&lon=${long}&appid=${Your api key}'));
    if (response.statusCode == 200) {
      aqi = jsonDecode(response.body);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              Infos(list: aqi, city: city, lat: lat, long: long),
        ),
      );
    } else {
      throw Exception('Failed');
    }
  }

  @override
  void initState() {
    super.initState();
    this.readJson();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Maps"),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(48.856614, 2.3522219),
          zoom: 12.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "http://a.tile.openstreetmap.fr/osmfr/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: markers.toList(),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

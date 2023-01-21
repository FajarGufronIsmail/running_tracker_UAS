import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  MapLatLng loc = new MapLatLng(-6.174502, 106.823146);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lokasi Lari"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              height: 100,
              color: Colors.blue,
              alignment: Alignment.bottomLeft,
              child: Text(
                "Menu",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.home),
              title: Text("Beranda"),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => DetailPage()));
              },
              leading: Icon(Icons.location_on_outlined),
              title: Text("Peta"),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Tentang Saya"),
            )
          ],
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: 300,
            child: SfMaps(layers: [
              MapTileLayer(
                initialZoomLevel: 15,
                initialFocalLatLng: loc,
                initialMarkersCount: 1,
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                markerBuilder: (BuildContext context, int index) {
                  return MapMarker(
                    latitude: loc.latitude,
                    longitude: loc.longitude,
                    child: Icon(Icons.location_on,
                        color: Color.fromARGB(255, 220, 0, 0)),
                  );
                },
              )
            ]),
          )
        ],
      )),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:location/location.dart';
import 'package:running_tracker_berlari/models/database/database_instance.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  bool isRunning = false;
  late int lariId;
  late Timer timer;
  List<LocationData?> locations = [];

  Future<LocationData?> _currentLocation() async {
    bool serviceEnable;
    PermissionStatus permissionGranted;

    Location location = new Location();

    serviceEnable = await location.serviceEnabled();

    if (!serviceEnable) {
      serviceEnable = await location.requestService();
      if (!serviceEnable) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  }

  @override
  void initState() {
    // TODO: implement initState
    databaseInstance.database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Berlari",
      )),
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            if (isRunning)
              Text(
                "Sedang Berlari",
                style: TextStyle(fontSize: 20),
              ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (isRunning) {
                    isRunning = false;
                    timer.cancel();
                    await databaseInstance.updateLari(
                        lariId, {'selesai': DateTime.now().toString()});
                    Navigator.pop(context);
                  } else {
                    lariId = await databaseInstance
                        .insertLari({'mulai': DateTime.now().toString()});

                    timer = Timer.periodic(Duration(seconds: 5), (timer) async {
                      LocationData? loc = await _currentLocation();

                      locations.add(loc);

                      int lariDetailId =
                          await databaseInstance.insertLariDetail({
                        'lari_id': lariId,
                        'latitude': loc?.latitude,
                        'longitude': loc?.longitude,
                        'waktu': DateTime.now().toString()
                      });
                      setState(() {});
                    });

                    isRunning = true;
                  }

                  setState(() {});
                },
                child: isRunning ? Text("Berhenti") : Text("Mulai")),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: locations.length,
                  itemBuilder: ((context, index) => Text("Latitude: " +
                      locations[index]!.latitude.toString() +
                      "Longitude: " +
                      locations[index]!.latitude.toString()))),
            )
          ],
        ),
      )),
    );
  }
}

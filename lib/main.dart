import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:running_tracker_berlari/about.dart';
import 'package:running_tracker_berlari/create_page.dart';
import 'package:running_tracker_berlari/detail_page.dart';
import 'package:running_tracker_berlari/models/database/database_instance.dart';
import 'package:running_tracker_berlari/models/lari_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseInstance databaseInstance = DatabaseInstance();

  @override
  void initState() {
    // TODO: implement initState
    databaseInstance.database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Catatan Lari")),
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
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()))
                    .then((value) {
                  setState(() {});
                });
              },
              leading: Icon(Icons.home),
              title: Text("Beranda"),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => DetailPage()))
                    .then((value) {
                  setState(() {});
                });
              },
              leading: Icon(Icons.location_on_outlined),
              title: Text("Peta"),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => About()))
                    .then((value) {
                  setState(() {});
                });
              },
              leading: Icon(Icons.person),
              title: Text("Tentang Saya"),
            )
          ],
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          FutureBuilder<List<BerlariModel>>(
              future: databaseInstance.getAllLari(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) => Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (context) => DetailPage()))
                                  .then((value) {
                                setState(() {});
                              });
                            },
                            leading: Icon(Icons.location_pin),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Mulai : " +
                                    DateFormat("dd-MM-yyyy H:mm:ss").format(
                                        DateTime.parse(
                                            snapshot.data![index].mulai))),
                                Text("Selesai : " +
                                    DateFormat("dd-MM-yyyy H:mm:ss").format(
                                        DateTime.parse(
                                            snapshot.data![index].selesai))),
                                Text("Durasi : " +
                                    DateTime.parse(
                                            snapshot.data![index].selesai)
                                        .difference(DateTime.parse(
                                            snapshot.data![index].mulai))
                                        .inSeconds
                                        .toString() +
                                    " detik")
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text("Tidak ada data"),
                    );
                  }
                }
              }),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CreatePage()))
              .then((value) {
            setState(() {});
          });
        },
        child: Icon(
          Icons.run_circle_sharp,
          size: 55,
        ),
      ),
    );
  }
}

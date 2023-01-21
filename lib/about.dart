import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(About());
}

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Layout Flutter',
      home: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage('assets/background.jpg'),
                          fit: BoxFit.cover),
                      border: Border.all(color: Colors.black26)),
                  child: Center(
                    child: Column(
                      children: const [
                        SizedBox(
                          height: 52,
                        ),
                        CircleAvatar(
                          radius: 57,
                          backgroundImage: AssetImage('assets/profile.jpeg'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Fajar Gufron Ismail',
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '43A87006190272',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 60, left: 60),
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.school,
                            color: Colors.blue,
                            size: 25,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Teknik Informatika',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.email,
                            color: Colors.blue,
                            size: 25,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'fajar190272@stmik-banisaleh.ac.id',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.phone_android,
                            color: Colors.blue,
                            size: 25,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '+62 813 94587837',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

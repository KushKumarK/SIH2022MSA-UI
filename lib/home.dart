import 'package:flutter/material.dart';
import 'scan_appl.dart';
import 'scan_assts.dart';
import 'result_pg.dart';

// ignore: non_constant_identifier_names

// ignore: non_constant_identifier_names
// ignore: non_constant_identifier_names
var Pages = [
  Scanner(
    title: "Application First Page Scan",
    file_name: "page_1.json",
  ),
  Scanner(
    title: "Second page Scan",
    file_name: "page_2.json",
  ),
  LandScanner(),
  SeeResult()
];

// ignore: non_constant_identifier_names
List<String> Classes = [
  "Scan First Page MGNREGS Application",
  "Scan Second Page of MGNREGS Application",
  "Scan Land Assets",
  "See Results Stored"
];
double? width;
// ignore: non_constant_identifier_names
Widget Box(index) {
  return Material(
      elevation: 10.0,
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
      child: Center(
        child: Container(
          child: Text(
            Classes[index],
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontFamily: "Roboto"),
          ),
          height: 100.0,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
        ),
      ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "MGNREGA SMART APP",
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                background: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  child: Image.network(
                    "https://mgnregs.ap.gov.in/Nregs/_images/about.jpg",
                    fit: BoxFit.cover,
                  ),
                )),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (_, int index) {
              return Column(
                children: [
                  const SizedBox(
                    height: 8.0,
                  ),
                  GestureDetector(
                    child: Box(index),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Pages[index]));
                    },
                  ),
                  const SizedBox(
                    height: 8.0,
                  )
                ],
              );
            },
            childCount: Classes.length,
          ))
        ],
      ),
    );
  }
}

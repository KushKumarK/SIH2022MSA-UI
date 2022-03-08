import 'package:flutter/material.dart';

List<String> Classes = [
  "Scan Your MGNREGS Application",
  "Scan Land Assets",
  "See Results Stored"
];
double? width;
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
          const SliverAppBar(
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Home",
                textScaleFactor: 1,
              ),
              centerTitle: true,
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (_, int index) {
              return Column(
                children: [
                  SizedBox(
                    height: 8.0,
                  ),
                  Box(index),
                  SizedBox(
                    height: 8.0,
                  )
                ],
              );
            },
            childCount: 3,
          ))
        ],
      ),
    );
  }
}

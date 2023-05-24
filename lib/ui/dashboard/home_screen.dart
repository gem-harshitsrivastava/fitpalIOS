import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 30, right: 20, top: 10),
                child: const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/gemfitpal-c1978.appspot.com/o/profile_one.png?alt=media&token=b8e420dd-4da9-4940-9f9f-1f58c86d8748'),
                ),
              ),
              Column(
                children: const <Widget>[Text("data"), Text("data")],
              )
            ],
          ),
        ],
      ),
    );
  }
}

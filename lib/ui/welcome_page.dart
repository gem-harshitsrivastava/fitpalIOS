import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gem_fitpal/ui/biodata/biodata_screen.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/welcome.gif'), fit: BoxFit.cover)),
        child: Column(children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 70),
            child: const Text(
              'Welcome To FitPal',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 45, left: 10, right: 10),
            child: const Center(
              child: Text(
                'Lorem ipsum dolor sit amet consectetur.Aliquam platea rhoncus dolor sagittis id.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                left: 24.0, top: 40.0, right: 24.0, bottom: 0.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BioDataScreen()));
              },
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
                fixedSize: const MaterialStatePropertyAll(Size(400, 50)),
                backgroundColor:
                    const MaterialStatePropertyAll(Color(0xff004FB8)),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

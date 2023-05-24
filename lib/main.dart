import 'package:flutter/material.dart';
import 'package:gem_fitpal/ui/splash_screen.dart';
import 'package:gem_fitpal/ui/welcome_page.dart';
import 'package:gem_fitpal/ui/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "AppEnvironment.appConfig.appName",
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const SplashScreen(),
      //initialRoute: '/',
      routes: {
        // '/': (context) =>
        //     const SplashScreen(), //const MyHomePage(title: 'Welcome to FitPal'),
        '/welcomePage': (context) => const WelcomePage(),
        '/loginPage': (context) => const LoginPage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "You have pushed the button this many times: ",
            ),
            Text(
              'hello',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/welcomePage');
                },
                child: const Text('Getting Started Again'))
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the second screen using a named route.
          Navigator.pushNamed(context, '/loginPage');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

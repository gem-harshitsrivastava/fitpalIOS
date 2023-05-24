import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gem_fitpal/config/env.dart';
import 'package:gem_fitpal/ui/mobile_login.dart';
import 'package:gem_fitpal/ui/register_page.dart';
import 'package:gem_fitpal/ui/welcome_page.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/app_config.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AppConfig appConfig; // declare the appConfig field as late
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final credential = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool _passwordVisible = false;
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    appConfig =
        AppConfig(apiUrl: '', appName: ''); // initialize the appConfig field
    appConfig = AppEnvironment.appConfig;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
        children: [
          SafeArea(
            child: Column(children: [
              const SizedBox(
                width: double.infinity,
                height: 30,
              ),
              const Text(
                'Welcome Back!',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 40.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      width: 370.0,
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'your@example.com',
                          fillColor: const Color(0xffE8F0FE),
                          prefixIcon: const Icon(
                            color: Color(0xff2F2E41),
                            Icons.email_outlined,
                          ),
                          filled: true,
                          // contentPadding:
                          //     const EdgeInsets.fromLTRB(40, 10, 20, 10),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide:
                                  const BorderSide(color: Color(0xff0066EE))),
                          enabledBorder: InputBorder.none,
                        ),
                        autofocus: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          return value!.isEmpty ? 'Please provide email' : null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: 370.0,
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          fillColor: const Color(0xffE8F0FE),
                          filled: true,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            icon: Icon(_passwordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                            color: const Color(0xff2F2E41),
                          ),
                          prefixIcon: const Icon(
                            color: Color(0xff2F2E41),
                            Icons.lock_outline,
                          ),
                          contentPadding:
                              const EdgeInsets.fromLTRB(40, 10, 20, 10),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide:
                                  const BorderSide(color: Color(0xff0066EE))),
                          enabledBorder: InputBorder.none,
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          return value!.isEmpty
                              ? 'Please provide password'
                              : null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                      width: 370.0,
                      child: Align(
                        // margin: EdgeInsets.only(top: 20, left: 260),
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                              color: Colors.blue,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 24.0, top: 40.0, right: 24.0, bottom: 0.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          String message = '';

                          dynamic res;
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            await credential
                                .signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text)
                                .then((value) async => {
                                      res = await FirebaseFirestore.instance
                                          .collection('userdatas')
                                          .doc(value.user!.uid)
                                          .get(),
                                      message =
                                          '${res.data()['name'].toString().toUpperCase()} LoggedIn Successfully',
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const WelcomePage()))
                                    })
                                .onError((error, stackTrace) =>
                                    {message = 'Invalid Password'})
                                .whenComplete(() => {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(content: Text(message)),
                                      ),
                                      setState(() {
                                        isLoading = false;
                                      })
                                    });
                          } else {
                            message = 'Enter Valid Details';
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(message)),
                            );
                          }
                        },
                        style: const ButtonStyle(
                          fixedSize: MaterialStatePropertyAll(Size(400, 50)),
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xff0066EE)),
                        ),
                        child: Text(
                          'Login',
                          style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                                color: Color(0xffFFFFFF)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Container(
                            margin: const EdgeInsets.only(left: 24, right: 24),
                            child: const Divider(
                              color: Colors.black,
                            ),
                          )),
                          const Text("OR"),
                          Expanded(
                              child: Container(
                            margin: const EdgeInsets.only(left: 24, right: 24),
                            child: const Divider(
                              color: Colors.black,
                            ),
                          ))
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 24)),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MobileLogin()));
                      },
                      child: const Text(
                        'Continue with Mobile Number',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            color: Color(0xff0066EE)),
                      ),
                    ),
                    Visibility(
                      visible: isLoading,
                      child: const CircularProgressIndicator(),
                    )
                  ],
                ),
              )
            ]),
          )
        ],
      )),
      bottomNavigationBar: BottomAppBar(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(padding: EdgeInsets.only(bottom: 50)),
          const Text('Don\'t have an account?'),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterPage()));
            },
            child: const Text(
              'Register',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Color(0xff0066EE)),
            ),
          ),
        ],
      )),
    );
  }
}

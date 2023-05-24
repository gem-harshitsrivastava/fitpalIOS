import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gem_fitpal/ui/login_page.dart';
import 'package:gem_fitpal/ui/mobile_login.dart';
import 'package:gem_fitpal/ui/welcome_page.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formRKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      extendBodyBehindAppBar: true,
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
                'Registration',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 40.0),
              Form(
                key: _formRKey,
                child: Column(
                  children: [
                    SizedBox(
                      width: 370.0,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Name',
                          fillColor: const Color(0xffE8F0FE),
                          prefixIcon: const Icon(
                            color: Color(0xff2F2E41),
                            Icons.person_outline,
                          ),
                          filled: true,
                          // contentPadding:
                          //     const EdgeInsets.fromLTRB(10, 10, 20, 10),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide:
                                  const BorderSide(color: Color(0xff0066EE))),
                          enabledBorder: InputBorder.none,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp("[a-zA-Z ]")),
                        ],
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: 370.0,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Email";
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return "Please Enter a Valid Email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'your@example.com',
                          fillColor: const Color(0xffE8F0FE),
                          prefixIcon: const Icon(
                            color: Color(0xff2F2E41),
                            Icons.email_outlined,
                          ),
                          filled: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(40, 10, 20, 10),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide:
                                  const BorderSide(color: Color(0xff0066EE))),
                          enabledBorder: InputBorder.none,
                        ),
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: 370.0,
                      child: TextFormField(
                        obscureText: !_passwordVisible,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Password";
                          } else if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(value)) {
                            return "Please Enter a Valid Password";
                          }
                          return null;
                        },
                        controller: _pass,
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
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: 370.0,
                      child: TextFormField(
                        obscureText: !_confirmPasswordVisible,
                        controller: _confirmPass,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Password";
                          } else if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(value)) {
                            return "Please Enter a Valid Password";
                          }
                          if (value != _pass.text) {
                            return 'Please Enter Same Password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          fillColor: const Color(0xffE8F0FE),
                          filled: true,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _confirmPasswordVisible =
                                    !_confirmPasswordVisible;
                              });
                            },
                            icon: Icon(_confirmPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                            color: const Color(0xff2F2E41),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: Color(0xff2F2E41),
                          ),
                          contentPadding:
                              const EdgeInsets.fromLTRB(40, 10, 20, 10),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide:
                                  const BorderSide(color: Color(0xff0066EE))),
                          enabledBorder: InputBorder.none,
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: const SizedBox(
                        height: 47.0,
                        width: 370.0,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Use 8 or more characters with a mix of atleast one uppercase, one lowercase, one special character and a number',
                            style: TextStyle(color: Color(0xff949494)),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 24.0, top: 40.0, right: 24.0, bottom: 0.0),
                      child: ElevatedButton(
                        onPressed: () {
                          var message = '';
                          if (_formRKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            auth
                                .createUserWithEmailAndPassword(
                                  email: _email.text,
                                  password: _pass.text,
                                )
                                .then((value) async => {
                                      message = 'Registered Successfully',
                                      await FirebaseFirestore.instance
                                          .collection('userdatas')
                                          .doc(value.user!.uid.toString())
                                          .set({
                                        'email': _email.text,
                                        "uid": value.user!.uid.toString(),
                                        'name': _name.text,
                                        'password': _pass.text,
                                      }),
                                      setState(() {
                                        isLoading = false;
                                      }),
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage()))
                                    })
                                .onError((error, stackTrace) => {
                                      message =
                                          'The account already exists for that email.'
                                    })
                                .whenComplete(
                                  () => ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    SnackBar(content: Text(message)),
                                  ),
                                );
                          } else {
                            message = 'Enter Valid Details';
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(message)),
                            );
                          }
                        },
                        style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          fixedSize:
                              const MaterialStatePropertyAll(Size(400, 50)),
                          backgroundColor:
                              const MaterialStatePropertyAll(Color(0xff0066EE)),
                        ),
                        child: Text(
                          'Register',
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
                      margin: const EdgeInsets.only(top: 36),
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
          const Text('Have an account?'),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            child: const Text(
              'Sign In',
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

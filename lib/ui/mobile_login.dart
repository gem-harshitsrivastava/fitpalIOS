import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gem_fitpal/ui/verify_otp.dart';
import 'package:google_fonts/google_fonts.dart';

class MobileLogin extends StatefulWidget {
  const MobileLogin({super.key});

  @override
  State<MobileLogin> createState() => _MobileLoginState();
}

class _MobileLoginState extends State<MobileLogin> {
  final countryCode = TextEditingController(text: '+91');
  final phoneNumber = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  void dispose() {
    countryCode.dispose();
    phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 90),
              child: const Text(
                'Your Mobile Number',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 34,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50, bottom: 5),
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: const Text(
                'We will send you a 4-digit verification code',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                ),
              ),
            ),
            Container(
              height: 56,
              margin: const EdgeInsets.only(
                  left: 24, right: 24, top: 40, bottom: 40),
              padding: const EdgeInsets.all(10),
              color: const Color(0xffE8F0FE),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.phone_android),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 40,
                    child: TextField(
                      controller: countryCode,
                      maxLength: 3,
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        if (value.length == 3) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      decoration: const InputDecoration(
                          hintText: '+00',
                          border: InputBorder.none,
                          counterText: ''),
                    ),
                  ),
                  const Text(
                    "|",
                    style: TextStyle(fontSize: 33, color: Colors.grey),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextField(
                    maxLength: 10,
                    controller: phoneNumber,
                    onChanged: (value) {
                      if (value.length == 10) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      counterText: '',
                      hintText: "Phone",
                    ),
                  ))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 24.0, top: 10.0, right: 24.0, bottom: 0.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  auth.verifyPhoneNumber(
                      phoneNumber: countryCode.text + phoneNumber.text,
                      verificationCompleted: (_) {},
                      verificationFailed: (e) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Error Sending OTP'),
                        ));
                      },
                      codeSent: (String verificationId, int? token) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('OTP sent'),
                        ));
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerifyOTP(
                                    verificationId: verificationId,
                                    phoneNumber:
                                        '${countryCode.text}-${phoneNumber.text}')));
                      },
                      codeAutoRetrievalTimeout: (e) {});
                },
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
                  fixedSize: const MaterialStatePropertyAll(Size(400, 50)),
                  backgroundColor:
                      const MaterialStatePropertyAll(Color(0xff0066EE)),
                ),
                child: Text(
                  'Generate OTP',
                  style: GoogleFonts.manrope(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                        color: Color(0xffFFFFFF)),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

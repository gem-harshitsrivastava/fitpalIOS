import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gem_fitpal/ui/mobile_login.dart';
import 'package:gem_fitpal/ui/welcome_page.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyOTP extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const VerifyOTP(
      {super.key, required this.verificationId, required this.phoneNumber});

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  final otpReceived = TextEditingController();
  final auth = FirebaseAuth.instance;
  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(6, (index) => TextEditingController());
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 70.0),
              child: const Text('OTP Verification',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700)),
            ),
            Container(
              margin: const EdgeInsets.only(top: 47),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Enter the OTP sent to ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                  Text(widget.phoneNumber,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w400)),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MobileLogin()));
                      },
                      icon: const Icon(Icons.edit))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 0; i < 6; i++)
                    SizedBox(
                      width: 40,
                      height: 60,
                      child: TextField(
                        controller: controllers[i],
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 30,
                          color: Color(0xff0066EE),
                        ),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide:
                                    const BorderSide(color: Color(0xffFFFFFF))),
                            fillColor: const Color(0xffE8F0FE),
                            filled: true,
                            hintText: '0',
                            contentPadding: const EdgeInsets.all(4),
                            border: InputBorder.none,
                            counterText: ''),
                      ),
                    )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    "Didn't receive OTP?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  Text(' Resend',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 24.0, top: 40.0, right: 24.0, bottom: 0.0),
              child: ElevatedButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        content: Text('Verifying'),
                      );
                    },
                  );
                  final credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: controllers[0].text +
                          controllers[1].text +
                          controllers[2].text +
                          controllers[3].text +
                          controllers[4].text +
                          controllers[5].text);

                  try {
                    await auth
                        .signInWithCredential(credential)
                        .then((value) async => {})
                        .whenComplete(() => {});

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Phone Number Verified Successfully'),
                      ));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WelcomePage()));
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Phone Number Verified Failed'),
                    ));
                  }
                },
                style: ButtonStyle(
                  fixedSize: const MaterialStatePropertyAll(Size(400, 50)),
                  backgroundColor:
                      const MaterialStatePropertyAll(Color(0xff0066EE)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
                ),
                child: Text(
                  'Verify & Continue',
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
        ),
      ),
    );
  }
}

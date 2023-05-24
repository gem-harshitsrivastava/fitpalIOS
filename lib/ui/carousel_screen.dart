import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gem_fitpal/constants/carousel_data.dart';
import 'package:gem_fitpal/ui/login_page.dart';
import 'package:google_fonts/google_fonts.dart';

class CarouselScreen extends StatefulWidget {
  const CarouselScreen({super.key});

  @override
  State<CarouselScreen> createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  final carouselImage = Constants.imageCarousel;
  int _pageIndex = 0;
  var isVisible = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      extendBody: true,
      body: Container(
        margin: const EdgeInsets.only(bottom: 40),
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: CarouselSlider(
                items: carouselImage.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 30),
                            child: Image(
                              image: AssetImage(i),
                              height: 286,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 40, left: 40, right: 40),
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: Constants.mainHeading[_pageIndex],
                                    style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 25,
                                            color: Color(0xff121521))),
                                    children: [
                                      TextSpan(
                                          text: 'FitPal',
                                          style: GoogleFonts.manrope(
                                              textStyle: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 25,
                                                  color: Color(0xff121521))))
                                    ])),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 16, left: 45, right: 45),
                            child: Text(
                              Constants.subHeading[carouselImage.indexOf(i)],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.manrope(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Color(0xff121521)),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 700,
                  enableInfiniteScroll: false,
                  initialPage: 0,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) => {
                    setState(() {
                      _pageIndex = index;
                      isVisible = index == 2 ? true : false;
                    })
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.circle_rounded,
                  color: ((_pageIndex == 0)
                      ? const Color(0xff0066EE)
                      : const Color(0xffE8F0FE)),
                  size: 12,
                ),
                const Padding(padding: EdgeInsets.only(right: 10)),
                // const Spacer(),
                Icon(
                  Icons.circle_rounded,
                  color: ((_pageIndex == 1)
                      ? const Color(0xff0066EE)
                      : const Color(0xffE8F0FE)),
                  size: 12,
                ),
                const Padding(padding: EdgeInsets.only(right: 10)),
                // const Spacer(),
                Icon(
                  Icons.circle_rounded,
                  color: ((_pageIndex == 2)
                      ? const Color(0xff0066EE)
                      : const Color(0xffE8F0FE)),
                  size: 12,
                ),
              ],
            ),
            Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: isVisible,
              child: Container(
                margin: const EdgeInsets.only(left: 24, right: 24, top: 24),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        //side: const BorderSide(color: Colors.red)
                      )),
                      fixedSize: const MaterialStatePropertyAll(Size(400, 50)),
                      backgroundColor:
                          const MaterialStatePropertyAll(Color(0xff0066EE)),
                    ),
                    child: Text('Next',
                        style: GoogleFonts.manrope(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Color(0xffFFFFFF)),
                        ))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

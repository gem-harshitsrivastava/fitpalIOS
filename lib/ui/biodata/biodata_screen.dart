import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gem_fitpal/ui/biodata/linear_stepper.dart';
import 'package:google_fonts/google_fonts.dart';

class BioDataScreen extends StatefulWidget {
  const BioDataScreen({super.key});

  @override
  State<BioDataScreen> createState() => _BioDataScreenState();
}

class _BioDataScreenState extends State<BioDataScreen> {
  CarouselController carouselController = CarouselController();
  int stepper = 1;
  int prevIndex = 1;
  final listOfWidgets = const [
    GenderWidget(),
    DateOfBirth(),
    BloodGroup(),
    WeightScreen(),
    HeightScreen()
  ];

  void _stepUp() {
    setState(() {
      ++stepper;
    });
  }

  void _stepDown() {
    setState(() {
      if (stepper != 1) --stepper;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return Center(
      child: Scaffold(
          extendBody: true,
          body: SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          carouselController.previousPage();
                        },
                        icon: const Icon(Icons.arrow_back_ios)),
                    LinearStepper(
                      progress: stepper,
                    ),
                    IconButton(
                        onPressed: () {
                          carouselController.nextPage();
                        },
                        icon: const Icon(Icons.arrow_forward_ios))
                  ],
                ),
                Expanded(
                  child: CarouselSlider(
                      carouselController: carouselController,
                      items: listOfWidgets.map((i) {
                        return Builder(builder: (BuildContext context) {
                          return i;
                        });
                      }).toList(),
                      options: CarouselOptions(
                        scrollPhysics: const NeverScrollableScrollPhysics(),
                        enableInfiniteScroll: false,
                        height: double.infinity,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          if (prevIndex <= index) {
                            _stepUp();
                            prevIndex = index;
                          } else {
                            _stepDown();
                            prevIndex = index;
                          }
                        },
                      )),
                )
              ],
            ),
          )),
    );
  }
}

class WeightWidget extends StatefulWidget {
  const WeightWidget({super.key});

  @override
  State<WeightWidget> createState() => _WeightWidgetState();
}

class _WeightWidgetState extends State<WeightWidget> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Weight'),
    );
  }
}

class DateOfBirth extends StatefulWidget {
  const DateOfBirth({super.key});

  @override
  State<DateOfBirth> createState() => _DateOfBirthState();
}

class _DateOfBirthState extends State<DateOfBirth> {
  late FixedExtentScrollController controller_date;
  late FixedExtentScrollController controller_month;
  late FixedExtentScrollController controller_year;
  List<String> yearList = [
    for (var i = 1900; i < DateTime.now().year; i++) i.toString()
  ];
  int selectedDate = 0;
  int selectedMonth = 0;
  int selectedYear = 0;
  List<int> dateList = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  List<int> dayList = List.generate(31, (index) => (index + 1));
  List<String> monthList = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  String dateOfBirth = '01 Jan 1900';
  String selectedDateText = '01',
      selectedMonthText = 'Jan',
      selectedYearText = '1900';
  @override
  void initState() {
    controller_date = FixedExtentScrollController(initialItem: 0);
    controller_month = FixedExtentScrollController(initialItem: 0);
    controller_year = FixedExtentScrollController(initialItem: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 88),
            child: Text(
              'I was born on',
              style: GoogleFonts.manrope(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                      color: Color(0xff121521))),
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 24, right: 24, top: 40, bottom: 40),
            height: 56,
            color: const Color(0xffE8F0FE),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.calendar_month,
                    color: Color(0xff004FB8),
                    size: 24,
                  ),
                ),
                Text('$selectedDateText $selectedMonthText $selectedYearText',
                    style: GoogleFonts.manrope(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Color(0xff121521))))
              ],
            ),
          ),
          const Divider(
            color: Colors.black,
            indent: 24,
            endIndent: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 70,
                height: 100,
                child: ListWheelScrollView.useDelegate(
                  childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) => Text(
                            dayList[index].toString(),
                            style: GoogleFonts.manrope(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25,
                                    color: (selectedDate == index)
                                        ? const Color(0xff121521)
                                        : const Color(0xffC7C7C7))),
                          ),
                      childCount: dayList.length),
                  controller: controller_date,
                  useMagnifier: true,
                  itemExtent: 30,
                  perspective: 0.005,
                  diameterRatio: 1.2,
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (value) {
                    setState(() {
                      selectedDate = controller_date.selectedItem;
                      selectedDateText = dayList[selectedDate].toString();
                    });
                  },
                  //children: dayList.map((item) => Text(item)).toList()
                ),
              ),
              SizedBox(
                width: 70,
                height: 200,
                child: ListWheelScrollView.useDelegate(
                  childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) => Text(
                            monthList[index],
                            style: GoogleFonts.manrope(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25,
                                    color: (selectedMonth == index)
                                        ? const Color(0xff121521)
                                        : const Color(0xffC7C7C7))),
                          ),
                      childCount: 12),
                  controller: controller_month,
                  itemExtent: 30,
                  perspective: 0.005,
                  diameterRatio: 1.2,
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (value) {
                    setState(() {
                      selectedMonth = controller_month.selectedItem;
                      selectedMonthText = monthList[selectedMonth];
                      dayList = List.generate(
                          dateList[selectedMonth], (index) => (index + 1));
                    });
                  },
                ),
              ),
              SizedBox(
                width: 70,
                height: 100,
                child: ListWheelScrollView.useDelegate(
                  childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) => Text(
                            yearList[index],
                            style: GoogleFonts.manrope(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25,
                                    color: (selectedYear == index)
                                        ? const Color(0xff121521)
                                        : const Color(0xffC7C7C7))),
                          ),
                      childCount: (DateTime.now().year - 1900)),
                  controller: controller_year,
                  itemExtent: 30,
                  perspective: 0.005,
                  diameterRatio: 1.2,
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (value) {
                    setState(() {
                      selectedYear = controller_year.selectedItem;
                      selectedYearText = yearList[selectedYear];

                      dateList[1] = ((int.parse(selectedYearText) % 4 == 0) &&
                              ((int.parse(selectedYearText) % 100 != 0) ||
                                  (int.parse(selectedYearText) % 400 == 0)))
                          ? 29
                          : 28;
                      dayList = List.generate(
                          dateList[selectedMonth], (index) => (index + 1));
                    });
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  List<int> weightList = List.generate(120, (index) => index);
  List<int> weightListDec = List.generate(10, (index) => index);
  late FixedExtentScrollController controllerWeight;
  late FixedExtentScrollController ccontrollerWeightDec;
  int selectedWeight = 0;
  String selectedWeightText = '';
  int selectedWeightDec = 0;
  String selectedWeightDecText = '';
  @override
  void initState() {
    controllerWeight = FixedExtentScrollController(initialItem: 0);
    ccontrollerWeightDec = FixedExtentScrollController(initialItem: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 88),
              child: Text(
                'My Body weight is',
                style: GoogleFonts.manrope(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: Color(0xff121521))),
              ),
            ),
            //Text('$selectedWeightText .$selectedWeightDecText  '),
            Container(
              margin: const EdgeInsets.only(top: 24),
              child: const CircleAvatar(
                radius: 32,
                backgroundColor: Color(0xffE8F0FE),
                foregroundColor: Color(0xff004FB8),
                child: Icon(
                  Icons.monitor_weight_sharp,
                  size: 32,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 70,
                  height: 200,
                  child: ListWheelScrollView.useDelegate(
                    childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) => Text(
                              weightList[index].toString(),
                              style: GoogleFonts.manrope(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25,
                                      color: (selectedWeight == index)
                                          ? const Color(0xff121521)
                                          : const Color(0xffC7C7C7))),
                            ),
                        childCount: weightList.length),
                    controller: controllerWeight,
                    itemExtent: 30,
                    perspective: 0.005,
                    diameterRatio: 1.2,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (value) {
                      setState(() {
                        selectedWeight = controllerWeight.selectedItem;
                        selectedWeightText =
                            weightList[selectedWeight].toString();
                      });
                    },
                    //children: monthList.map((item) => Text(item)).toList()
                  ),
                ),
                const Text(
                  '.',
                  style: TextStyle(
                      color: Color(0xff000000), fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 70,
                  height: 200,
                  child: ListWheelScrollView.useDelegate(
                    childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) => Text(
                              weightListDec[index].toString(),
                              style: GoogleFonts.manrope(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25,
                                      color: (selectedWeightDec == index)
                                          ? const Color(0xff121521)
                                          : const Color(0xffC7C7C7))),
                            ),
                        childCount: weightListDec.length),
                    controller: ccontrollerWeightDec,
                    itemExtent: 30,
                    perspective: 0.005,
                    diameterRatio: 1.2,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (value) {
                      setState(() {
                        selectedWeightDec = ccontrollerWeightDec.selectedItem;
                        selectedWeightDecText =
                            weightListDec[selectedWeightDec].toString();
                      });
                    },
                    //children: monthList.map((item) => Text(item)).toList()
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HeightScreen extends StatefulWidget {
  const HeightScreen({super.key});

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  List<int> heightList = [for (int i = 30; i < 275; i++) i];
  List<int> heightListDec = List.generate(10, (index) => index);
  late FixedExtentScrollController controllerHeight;
  late FixedExtentScrollController controllerHeightDec;
  int selectedheight = 0;
  String selectedheightText = '';
  int selectedheightDec = 0;
  String selectedheightDecText = '';
  @override
  void initState() {
    controllerHeight = FixedExtentScrollController(initialItem: 0);
    controllerHeightDec = FixedExtentScrollController(initialItem: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 88),
              child: Text(
                'My Body height is',
                style: GoogleFonts.manrope(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: Color(0xff121521))),
              ),
            ),
            //Text('$selectedheightText .$selectedheightDecText  '),
            Container(
              margin: const EdgeInsets.only(top: 24),
              child: const CircleAvatar(
                radius: 32,
                backgroundColor: Color(0xffE8F0FE),
                foregroundColor: Color(0xff004FB8),
                child: Icon(
                  Icons.height,
                  size: 32,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 70,
                  height: 200,
                  child: ListWheelScrollView.useDelegate(
                    childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) => Text(
                              heightList[index].toString(),
                              style: GoogleFonts.manrope(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25,
                                      color: (selectedheight == index)
                                          ? const Color(0xff121521)
                                          : const Color(0xffC7C7C7))),
                            ),
                        childCount: heightList.length),
                    controller: controllerHeight,
                    itemExtent: 30,
                    perspective: 0.005,
                    diameterRatio: 1.2,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (value) {
                      setState(() {
                        selectedheight = controllerHeight.selectedItem;
                        selectedheightText =
                            heightList[selectedheight].toString();
                      });
                    },
                    //children: monthList.map((item) => Text(item)).toList()
                  ),
                ),
                const Text(
                  '.',
                  style: TextStyle(
                      color: Color(0xff000000), fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 70,
                  height: 200,
                  child: ListWheelScrollView.useDelegate(
                    childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) => Text(
                              heightListDec[index].toString(),
                              style: GoogleFonts.manrope(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25,
                                      color: (selectedheightDec == index)
                                          ? const Color(0xff121521)
                                          : const Color(0xffC7C7C7))),
                            ),
                        childCount: heightListDec.length),
                    controller: controllerHeightDec,
                    itemExtent: 30,
                    perspective: 0.005,
                    diameterRatio: 1.2,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (value) {
                      setState(() {
                        selectedheightDec = controllerHeightDec.selectedItem;
                        selectedheightDecText =
                            heightListDec[selectedheightDec].toString();
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BloodGroup extends StatefulWidget {
  const BloodGroup({super.key});

  @override
  State<BloodGroup> createState() => _BloodGroupState();
}

class _BloodGroupState extends State<BloodGroup> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 88),
          child: Text(
            'My blood group is',
            style: GoogleFonts.manrope(
                textStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: Color(0xff121521))),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 24),
          child: const CircleAvatar(
            radius: 32,
            backgroundColor: Color(0xffE8F0FE),
            foregroundColor: Color(0xffB80000),
            child: Icon(
              Icons.bloodtype,
              size: 32,
            ),
          ),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.only(left: 24, top: 24),
            height: 300,
            width: double.infinity,
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 20, bottom: 24),
                  color: const Color(0xffe8f0fe),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return const Color(0xff93D3F2);
                            }
                            return const Color(0xffe8f0fe);
                          },
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('A+')),
                ),
                Container(
                  color: const Color(0xffe8f0fe),
                  margin: const EdgeInsets.only(right: 20, bottom: 24),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return const Color(0xff93D3F2);
                            }
                            return const Color(0xffe8f0fe);
                          },
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('B+')),
                ),
                Container(
                  color: const Color(0xffe8f0fe),
                  margin: const EdgeInsets.only(right: 20, bottom: 24),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return const Color(0xff93D3F2);
                            }
                            return const Color(0xffe8f0fe);
                          },
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('O+')),
                ),
                Container(
                  color: const Color(0xffe8f0fe),
                  margin: const EdgeInsets.only(right: 20, bottom: 24),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return const Color(0xff93D3F2);
                            }
                            return const Color(0xffe8f0fe);
                          },
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('AB+')),
                ),
                Container(
                  color: const Color(0xffe8f0fe),
                  margin: const EdgeInsets.only(right: 20, bottom: 24),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return const Color(0xff93D3F2);
                            }
                            return const Color(0xffe8f0fe);
                          },
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('A-')),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20, bottom: 24),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return const Color(0xff93D3F2);
                            }
                            return const Color(0xffe8f0fe);
                          },
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('B-')),
                ),
                Container(
                  color: const Color(0xffe8f0fe),
                  margin: const EdgeInsets.only(right: 20, bottom: 24),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return const Color(0xff93D3F2);
                            }
                            return const Color(0xffe8f0fe);
                          },
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('O-')),
                ),
                Container(
                  color: const Color(0xffe8f0fe),
                  margin: const EdgeInsets.only(right: 20, bottom: 24),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return const Color(0xff93D3F2);
                            }
                            return const Color(0xffe8f0fe);
                          },
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('AB-')),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class GenderWidget extends StatefulWidget {
  const GenderWidget({super.key});

  @override
  State<GenderWidget> createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderWidget> {
  String maleUrl = '';
  String femaleUrl = '';
  String otherUrl = '';
  String unselectedMaleURL =
      'https://firebasestorage.googleapis.com/v0/b/gemfitpal-c1978.appspot.com/o/unselectedMale.png?alt=media&token=a391b464-2da2-472a-b920-1747aa85ec1e';
  String selectedMaleURL =
      'https://firebasestorage.googleapis.com/v0/b/gemfitpal-c1978.appspot.com/o/selectedMale.png?alt=media&token=ecb1fb2c-80ab-44b3-9f83-2b1c075cbfa6';
  String unselectedFemaleURL =
      'https://firebasestorage.googleapis.com/v0/b/gemfitpal-c1978.appspot.com/o/unselectedFemale.png?alt=media&token=2ac06c50-26a3-4f28-a000-144c2c287175';
  String selectedFemaleURL =
      'https://firebasestorage.googleapis.com/v0/b/gemfitpal-c1978.appspot.com/o/selectedFemale.png?alt=media&token=75d5e38b-80d8-4e74-9a33-ac0f7c5d64a4';
  String unselectedOtherURL =
      'https://firebasestorage.googleapis.com/v0/b/gemfitpal-c1978.appspot.com/o/TransUnselected.png?alt=media&token=b8aa041a-9e50-4040-86ac-12a950442ecc';
  String selectedOtherURL =
      'https://firebasestorage.googleapis.com/v0/b/gemfitpal-c1978.appspot.com/o/Trans.png?alt=media&token=5c1d9542-5bf6-4902-8463-f9e9687d3134';

  @override
  void initState() {
    maleUrl = unselectedMaleURL;
    femaleUrl = unselectedFemaleURL;
    otherUrl = unselectedOtherURL;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        const SizedBox(
          width: double.infinity,
          height: 30,
        ),
        const Text(
          'I am a',
          style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 40.0),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      maleUrl = maleUrl == unselectedMaleURL
                          ? selectedMaleURL
                          : unselectedMaleURL;
                      femaleUrl = unselectedFemaleURL;
                      otherUrl = unselectedOtherURL;
                    });
                  },
                  iconSize: 180,
                  icon: Image.network(maleUrl)),
              IconButton(
                  onPressed: () {
                    setState(() {
                      maleUrl = unselectedMaleURL;
                      femaleUrl = femaleUrl == unselectedFemaleURL
                          ? selectedFemaleURL
                          : unselectedFemaleURL;
                      otherUrl = unselectedOtherURL;
                    });
                  },
                  iconSize: 180,
                  icon: Image.network(femaleUrl))
            ],
          ),
        ),
        const SizedBox(height: 40.0),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
              onPressed: () {
                setState(() {
                  femaleUrl = unselectedFemaleURL;
                  maleUrl = unselectedMaleURL;
                  otherUrl = otherUrl == unselectedOtherURL
                      ? selectedOtherURL
                      : unselectedOtherURL;
                });
              },
              iconSize: 180,
              icon: Image.network(otherUrl)),
        ]),
      ],
    )));
  }
}

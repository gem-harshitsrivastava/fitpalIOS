import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListWheel extends StatefulWidget {
  final List<dynamic> dataList;
  const ListWheel(this.dataList, {super.key});

  @override
  State<ListWheel> createState() => _ListWheelState();
}

class _ListWheelState extends State<ListWheel> {
  int selectedData = 0;
  late FixedExtentScrollController controller;
  String selectedDataText = '';
  @override
  void initState() {
    controller = FixedExtentScrollController(initialItem: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 100,
      child: ListWheelScrollView.useDelegate(
        childDelegate: ListWheelChildBuilderDelegate(
            builder: (context, index) => Text(
                  widget.dataList[index].toString(),
                  style: GoogleFonts.manrope(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
                          color: (selectedData == index)
                              ? const Color(0xff121521)
                              : const Color(0xffC7C7C7))),
                ),
            childCount: widget.dataList.length),
        controller: controller,
        useMagnifier: true,
        itemExtent: 30,
        perspective: 0.005,
        diameterRatio: 1.2,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (value) {
          setState(() {
            selectedData = controller.selectedItem;
            selectedDataText = widget.dataList[selectedData].toString();
          });
        },
      ),
    );
  }
}

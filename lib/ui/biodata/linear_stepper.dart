import 'package:flutter/material.dart';

class LinearStepper extends StatelessWidget {
  const LinearStepper({super.key, required this.progress});
  final int progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 10,
      decoration: BoxDecoration(
          color: const Color(0xffE8F0FE),
          borderRadius: BorderRadius.circular(8)),
      child: Stack(
        children: [
          Container(
            width: progress * 25,
            decoration: BoxDecoration(
                color: const Color(0xff0066EE),
                borderRadius: BorderRadius.circular(8)),
          )
        ],
      ),
    );
  }
}

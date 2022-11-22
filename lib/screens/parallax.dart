import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class ParallaxScreen extends StatefulWidget {
  const ParallaxScreen({Key? key}) : super(key: key);

  @override
  State<ParallaxScreen> createState() => _ParallaxScreenState();
}

class _ParallaxScreenState extends State<ParallaxScreen> {
  late AccelerometerEvent acceleration;
  late StreamSubscription<AccelerometerEvent> _streamSubscription;

  int planetMotionSensitivity = 2;
  int bgMotionSensitivity = 6;
  int bgMotionSensitivityL2 = 8;

  @override
  void initState() {
    super.initState();
    _streamSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        acceleration = event;
      });
    });
  }
  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            top: acceleration.y * bgMotionSensitivityL2,
            bottom: acceleration.y * -bgMotionSensitivityL2,
            right: acceleration.x * -bgMotionSensitivityL2,
            left: acceleration.x * bgMotionSensitivityL2,
            child: Align(
              child: Image.asset(
                "assets/images/stars_layer_2.png",
                height: 1920,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            top: acceleration.y * bgMotionSensitivity,
            bottom: acceleration.y * -bgMotionSensitivity,
            right: acceleration.x * -bgMotionSensitivity,
            left: acceleration.x * bgMotionSensitivity,
            child: Align(
              child: Image.asset(
                "assets/images/stars_layer_1.png",
                height: 1920,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            top: acceleration.y * planetMotionSensitivity,
            bottom: acceleration.y * -planetMotionSensitivity,
            right: acceleration.x * -planetMotionSensitivity,
            left: acceleration.x * planetMotionSensitivity,
            child: Align(
              child: Image.asset(
                "assets/images/earth.png",
                width: 250,
                height: 250,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:maps/custom/custom.dart';

class TestMarker extends StatelessWidget {
  const TestMarker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          height: 150,
          child: CustomPaint(
            painter: MarkerDestinationPainter(
              'Destino por algún lado del mundo jbskjbsjb jkadiudh hwhwh',
              2500,
            ),
          ),
        ),
      ),
    );
  }
}

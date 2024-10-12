// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class BuildSymbolDialogWidget extends StatelessWidget {
  final double distance;
  final Symbol symbol;
  final String batteryStatus;
  final void Function() onPressedHelp;
  const BuildSymbolDialogWidget(
      {required this.distance,
      required this.symbol,
      required this.batteryStatus,
      required this.onPressedHelp,
      super.key});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      height: _height * 0.21,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
        children: [
          Text(
            'Name: ${symbol.options.textField}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),

          Text(
            "Distance: ${distance.toStringAsFixed(2)} m",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87, // Text color
            ),
          ),
          const SizedBox(height: 8.0), // Space between title and details
          Text(
            'Location: ${symbol.options.geometry!.latitude}, ${symbol.options.geometry!.longitude}',
            style: const TextStyle(
              color: Colors.blueGrey, // Text color for details
            ),
          ),
          const SizedBox(height: 4.0), // Space between lines

          Text(
            'Battery Status: $batteryStatus',
            style: const TextStyle(
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(
            height: 12,
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
                width: _width,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFFD9B3),
                    ),
                    onPressed: onPressedHelp,
                    child: const Text("Help"))),
          )
        ],
      ),
    );
  }
}

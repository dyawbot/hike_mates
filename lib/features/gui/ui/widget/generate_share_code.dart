// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:flutter/material.dart';

class GenerateShareCodeWidget extends StatelessWidget {
  final String hikeCode;
  final bool isGenerated;
  final bool isEnterCode;
  final TextEditingController controller;
  final void Function() submitFunction;
  final void Function() generateCardFunction;
  final void Function() enterCodeFunction;
  const GenerateShareCodeWidget(this.hikeCode,
      {required this.controller,
      required this.isGenerated,
      this.isEnterCode = false,
      required this.submitFunction,
      required this.generateCardFunction,
      required this.enterCodeFunction,
      super.key});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              width: 300,
              height: 210,
            ),

            Positioned(
                right: 0,
                top: -8,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      fill: 1,
                      Icons.close,
                      color: Colors.red,
                    ))),

            //! GENERATED CODE
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: isEnterCode ? Curves.easeIn : Curves.easeOut,
              right: 0,
              left: 0,
              bottom: !isEnterCode ? 130 : -1000,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  width: _width,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xFFEEEBE8),
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    hikeCode,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

            //!ENTERED CODE
            AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                curve: isEnterCode ? Curves.easeIn : Curves.easeOut,
                right: 0,
                left: 0,
                bottom: isGenerated
                    ? 1000
                    : !isEnterCode
                        ? 500
                        : 110,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextFormField(
                    maxLength: 4,
                    textAlign: TextAlign.center,
                    controller: controller,
                    textCapitalization: TextCapitalization.characters,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Hike Code",
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length != 4) {
                        return 'Please enter a valid 4-character code';
                      }
                      return null;
                    },
                  ),
                )),

            AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                curve: isGenerated ? Curves.easeIn : Curves.easeOut,
                right: 0,
                left: 0,
                bottom: !isGenerated ? 60 : -1000,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        backgroundColor: const Color(0xFFC16918)),
                    onPressed: enterCodeFunction,
                    child: const Text("Enter Code",
                        style: TextStyle(color: Colors.white)),
                    // trailing: Icon(Icons.login),
                  ),
                )),

            AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                curve: isGenerated ? Curves.easeIn : Curves.easeOut,
                right: 0,
                left: 0,
                bottom: isEnterCode
                    ? 10
                    : !isGenerated
                        ? -1000
                        : 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor: const Color(0xFFC33218)),
                      onPressed: submitFunction,
                      child: const Text("Submit",
                          style: TextStyle(color: Colors.white))),
                )),

            AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                curve: isGenerated ? Curves.easeIn : Curves.easeOut,
                right: 0,
                left: 0,
                bottom: isEnterCode
                    ? -1000
                    : !isGenerated
                        ? 10
                        : 60,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor: const Color(0xFF0000FF)),
                      onPressed: generateCardFunction,
                      child: Text(
                          hikeCode == "Hike Code"
                              ? "Generate"
                              : isGenerated
                                  ? "Re-generate"
                                  : "Generate",
                          style: const TextStyle(color: Colors.white))),
                )),
          ],
        ),
      ),
    );
  }
}

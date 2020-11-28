import 'package:flutter/material.dart';

class OylamaWidgeti {
  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: CustomSlider(context),
          );
        });
  }
}

class CustomSlider extends StatefulWidget {
  BuildContext context;
  CustomSlider(this.context);

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double baslangic;
  @override
  Widget build(BuildContext context) {
    context = widget.context;
    return Slider(
      activeColor: Colors.black,
      inactiveColor: Colors.black12,
      min: 0,
      max: 100,
      value: 0,
      onChanged: (double value) {
        setState(() {
          baslangic = value;
        });
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  BuildContext context;
  double baslangic;
  CustomSlider(this.context, this.baslangic);
  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double baslangic;
  int intBaslangic = 0;
  @override
  Widget build(BuildContext context) {
    baslangic = widget.baslangic;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(intBaslangic.toString()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("0"),
            Text("100"),
          ],
        ),
        CupertinoSlider(
          activeColor: Colors.black,
          min: 0,
          max: 100,
          value: intBaslangic.toDouble(),
          onChanged: (double value) {
            setState(() {
              baslangic = value;
              intBaslangic = baslangic.toInt();
            });
            print(intBaslangic);
          },
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: (Text("Vote",style: TextStyle(color: Colors.blue),)))
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class CustomSlider extends StatefulWidget {
  BuildContext context;
  double baslangic;
  String uid;
  String top_category_name;
  String rate_name;
  String rate_value;
  String total_num_of_rates;
  CustomSlider(this.context, this.baslangic,this.uid,this.top_category_name,this.rate_name,this.rate_value,this.total_num_of_rates);
  @override
  _CustomSliderState createState() => _CustomSliderState(uid,top_category_name,rate_name,rate_value,total_num_of_rates);
}

class _CustomSliderState extends State<CustomSlider> {
  double baslangic;
  int intBaslangic = 0;
  String uid;
  String top_category_name;
  String rate_name;
  String rate_value;
  String total_num_of_rates;
  _CustomSliderState(this.uid, this.top_category_name, this.rate_name,this.rate_value,this.total_num_of_rates);



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

                  rateCategory(uid, top_category_name, rate_name, intBaslangic.toString(),rate_value, total_num_of_rates);
                  Navigator.of(context).pop();
                },
                child: (Text("Vote",style: TextStyle(color: Colors.blue),)))
          ],
        ),
      ],
    );
  }
  Future rateCategory(String uid,String top_category_name,String rate_name,String new_rate_value,String old_rate_value,String total_num_of_rates) async {

    int newratevalue=int.parse(new_rate_value);
    int oldratevalue=int.parse(old_rate_value);
    int totalnumofrates=int.parse(total_num_of_rates);
    double totalrate=((totalnumofrates*oldratevalue)+newratevalue)/(totalnumofrates+1);
    int totalrates_int=totalrate.floor();
    var url = 'http://www.taybtu.com/oyla/PostRateForMain.php?uid='+uid+'&TopCategoryName='+top_category_name+'&RateName='+rate_name+'&RateValue='+new_rate_value+'&NewRateValue='+totalrates_int.toString()+'&TotalNumberOfRates='+(totalnumofrates+1).toString();
    http.Response response = await http.get(url);
    print('done');
  }
}

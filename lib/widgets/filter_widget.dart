import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:petty_app/screens/bottom_navigation/nav_matches.dart';

class FilterWidget extends StatefulWidget {
  FilterWidget({Key key}) : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  @override
  Widget build(BuildContext context) {
    print('build called');
    return Container(
      height: 270.0,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 8, top: 5, bottom: 5, right: 8),
      child: Column(
        children: [
          Divider(
            thickness: 2.0,
            color: Colors.black,
          ),
          SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Age text
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text("Age",
                    style: TextStyle(
                        color: Color(0xff444444),
                        fontFamily: "SFUIDisplay",
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
              ),
              SizedBox(
                height: 30.0,
              ),

              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  "${NavMatches.minAge.toInt()} - ${NavMatches.maxAge.toInt()}",
                  style: TextStyle(
                      color: Color(0xffADACAC),
                      fontFamily: "SFUIDisplay",
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
            ],
          ),
          FlutterSlider(
            values: [NavMatches.minAge, NavMatches.maxAge],
            max: 99,
            min: 18,
            rangeSlider: true,
            handlerHeight: 20,
            handlerWidth: 20,
            trackBar: FlutterSliderTrackBar(
              activeTrackBar: BoxDecoration(color: Color(0xffED6963)),
              inactiveTrackBar: BoxDecoration(color: Colors.grey),
            ),
            onDragging: (handlerIndex, lowerValue, upperValue) {
              setState(() {
                NavMatches.minAge = lowerValue;
                NavMatches.maxAge = upperValue;
              });
            },
            handler: FlutterSliderHandler(
              foregroundDecoration: BoxDecoration(
                  color: Color(0xffED6963), shape: BoxShape.circle),
            ),
            rightHandler: FlutterSliderHandler(
              foregroundDecoration: BoxDecoration(
                  color: Color(0xffED6963), shape: BoxShape.circle),
            ),
          ),
          Divider(
            thickness: 2.0,
            color: Color(0xffEDEDED),
          ),
          SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Age text
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text("Distance",
                    style: TextStyle(
                        color: Color(0xff444444),
                        fontFamily: "SFUIDisplay",
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
              ),
              SizedBox(
                height: 30.0,
              ),

              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  "${NavMatches.minDistance.toInt()} - ${NavMatches.maxDistance.toInt()}",
                  style: TextStyle(
                      color: Color(0xffADACAC),
                      fontFamily: "SFUIDisplay",
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: FlutterSlider(
                  disabled: !NavMatches.isCheckBoxEnabled,
                  values: [NavMatches.minDistance, NavMatches.maxDistance],
                  max: 500,
                  min: 0,
                  rangeSlider: true,
                  handlerHeight: 20,
                  handlerWidth: 20,
                  trackBar: FlutterSliderTrackBar(
                    activeTrackBar: BoxDecoration(color: Color(0xffED6963)),
                    inactiveTrackBar: BoxDecoration(color: Colors.grey),
                  ),
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    setState(() {
                      NavMatches.minDistance = lowerValue;
                      NavMatches.maxDistance = upperValue;
                    });
                  },
                  handler: FlutterSliderHandler(
                    foregroundDecoration: BoxDecoration(
                        color: Color(0xffED6963), shape: BoxShape.circle),
                  ),
                  rightHandler: FlutterSliderHandler(
                    foregroundDecoration: BoxDecoration(
                        color: Color(0xffED6963), shape: BoxShape.circle),
                  ),
                ),
              ),
              Checkbox(
                  value: NavMatches.isCheckBoxEnabled,
                  onChanged: (isChecked) {
                    setState(() {
                      NavMatches.isCheckBoxEnabled = isChecked ? true : false;
                    });
                  }),
            ],
          ),
          Divider(
            thickness: 2.0,
            color: Color(0xffEDEDED),
          ),
        ],
      ),
    );
  }
}

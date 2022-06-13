import 'package:flutter/material.dart';
import 'package:lost_tracking/widget/popup_value_widget.dart';
import 'package:relative_scale/relative_scale.dart';

class DistancePopUpWidget extends StatefulWidget {
  final TextEditingController distanceController;
  DistancePopUpWidget(this.distanceController);
  @override
  _DistancePopUpWidgetState createState() => _DistancePopUpWidgetState();
}

class _DistancePopUpWidgetState extends State<DistancePopUpWidget> {
  void active(String val) {
    setState(() {
      widget.distanceController.text = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return AlertDialog(
        scrollable: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                  shape:
                      BoxShape.circle, // BoxShape.circle or BoxShape.retangle
                  //color: const Color(0xFF66BB6A),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.transparent,
                      blurRadius: 50.0,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.grey,
                  size: sy(15),
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            height: sy(180),
            // width: sy(140),
            // height: ScreenUtil().setHeight(650),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // SizedBox(
                //   height: 10,
                // ),
                // Center(
                //   child: Container(
                //       height: ScreenUtil().setHeight(100),
                //       child: Image.asset("assets/images/workout_popup.png")),
                // ),
                // SizedBox(
                //   height: ScreenUtil().setHeight(20),
                // ),
                Container(
                  child: Text(
                    "DISTANCE",
                    style: TextStyle(
                        fontSize: sy(18), fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: sy(10),
                ),
                Container(
                  width: sy(20),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: sy(20),
                ),
                Container(
                  alignment: Alignment.center,
                  child: PopUpValueWidget(
                    action: active, //pass data from child to parent
                    tag: "Miles", //specifies attribute of button
                    active: widget.distanceController.text == "Miles"
                        ? true
                        : false, //set button active based on value in this parent
                    name: "MILES",
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: PopUpValueWidget(
                    action: active, //pass data from child to parent
                    tag: "Km", //specifies attribute of button
                    active: widget.distanceController.text == "Km"
                        ? true
                        : false, //set button active based on value in this parent
                    name: "Kilometers",
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

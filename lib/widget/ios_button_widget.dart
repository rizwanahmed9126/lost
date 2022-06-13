import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:relative_scale/relative_scale.dart';

class IosButtonsWidget extends StatefulWidget {
  @override
  _IosButtonsWidgetState createState() => _IosButtonsWidgetState();
}

class _IosButtonsWidgetState extends State<IosButtonsWidget> {
  var isLoadingProgress = false;
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                // padding: EdgeInsets.all(ScreenUtil().setWidth(16)),
                height: sy(35),
                width: sx(100),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: const Color(0x11000000), blurRadius: 10.0)
                  ],
                  color: Color.fromRGBO(57, 86, 156, 1),
                ),
                child: Center(
                  child: IconButton(
                    icon: ImageIcon(
                      AssetImage("assets/images/Login-Facebook.png"),
                      size: 20,
                      color: Colors.white,
                    ),
                    onPressed: () async {},
                  ),
                ),
              ),
              Container(
                // padding: EdgeInsets.all(ScreenUtil().setWidth(16)),
                height: sy(35),
                width: sx(100),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: const Color(0x11000000), blurRadius: 10.0)
                  ],
                  color: Colors.grey.shade300,
                ),
                child: Center(
                  child: IconButton(
                    icon: Image(
                      image: AssetImage(
                        "assets/images/Google.png",
                      ),
                      height: 25,
                    ),
                    onPressed: () async {},
                  ),
                ),
              ),
              Container(
                // padding: EdgeInsets.all(ScreenUtil().setWidth(16)),
                height: sy(35),
                width: sx(100),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: const Color(0x11000000), blurRadius: 10.0)
                  ],
                  color: Colors.black,
                ),
                child: Center(
                  child: IconButton(
                    icon: Image.asset('assets/images/Login-Apple.png',
                        height: 25, color: Colors.white, scale: 4),
                    // color: Colors.lightBlueAccent[300],
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

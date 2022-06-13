import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lost_tracking/models/user.dart';
import 'package:lost_tracking/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import 'package:relative_scale/relative_scale.dart';

class AndroidButtonsWidget extends StatefulWidget {
  @override
  _AndroidButtonsWidgetState createState() => _AndroidButtonsWidgetState();
}

class _AndroidButtonsWidgetState extends State<AndroidButtonsWidget> {

  var isLoadingProgress = false;
  AppUser? user;

  @override
  void initState() { 
    user = Provider.of<AuthProvider>(context, listen:false).user;
    super.initState();
    
  }
  
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: sx(202),
                height: sy(35),
                // ignore: deprecated_member_use
                child: RaisedButton.icon(
                    color: Colors.blue[900],
                    elevation: 0,
                    onPressed: () async {},
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.blue.shade900,
                        ),
                        borderRadius: BorderRadius.circular(sy(2))),
                    icon: ImageIcon(
                      AssetImage('assets/images/Facebook.png'),
                      size: sy(14),
                      color: Colors.white,
                    ),
                    label: Text(
                      "FACEBOOK",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: sy(10),
                        fontWeight: FontWeight.w700,
                      ),
                    )),
              ),
              SizedBox(width: sx(2)),
              SizedBox(
                width: sx(200),
                height: sy(35),
                // ignore: deprecated_member_use
                child: RaisedButton(
                  elevation: 0,
                  color: Colors.white,
                  padding: EdgeInsets.only(
                    top: sy(10),
                    bottom: sy(10),
                    left: sx(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/Google.png',
                        height: sy(18),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: sx(10), right: sx(10)),
                          child: new Text(
                            "GOOGLE",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: sy(10),
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                    ],
                  ),
                  onPressed: () async {},
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                      borderRadius: BorderRadius.circular(sy(2))),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // _showLocationPopUp() async {
  //   setState(() {
  //     isLoadingProgress = false;
  //   });
  //   Location location = new Location();
  //   var _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted != PermissionStatus.granted) {
  //     return LocationRestrictedScreen();
  //     // showDialog(
  //     //     context: context,
  //     //     builder: (_) {
  //     //       return LocationRestricted();
  //     //     });
  //   }
  // }
}

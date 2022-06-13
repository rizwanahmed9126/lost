import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lost_tracking/widget/distance_popup_widget.dart';
import 'package:relative_scale/relative_scale.dart';
import '../services/navigation_service.dart';
import '../utils/routes.dart';
import '../utils/service_locator.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var navigationService = locator<NavigationService>();
  TextEditingController distanceController = TextEditingController();
  var distance = "";
  bool value = false;
  @override
  void initState() {
    distanceController.addListener(() {
      setState(() {
        distance = distanceController.text;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: AppBar(
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    navigationService.navigateTo(HomeScreenRoute);
                  }),
              // automaticallyImplyLeading: false,
              title: Text('Settings'),
              bottomOpacity: 0.0,
              backgroundColor: Theme.of(context).backgroundColor,
              elevation: 0,
            ),
          ),
          body: Stack(children: [
            Container(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: sy(12), right: sy(12)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  // SizedBox(
                                  //   height: sy(25),
                                  // ),
                                  // Container(
                                  //   child: Column(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.start,
                                  //     crossAxisAlignment:
                                  //         CrossAxisAlignment.start,
                                  //     children: [
                                  //       Container(
                                  //         height: sy(20),
                                  //         child: Row(
                                  //           children: [
                                  //             Expanded(
                                  //               flex: 10,
                                  //               child: Container(
                                  //                 child: Text(
                                  //                   "Notifications",
                                  //                   style: TextStyle(
                                  //                     fontSize: sy(12),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //             Expanded(
                                  //               child: Container(
                                  //                   child: Transform.scale(
                                  //                 scale: 0.7,
                                  //                 child: CupertinoSwitch(
                                  //                     value: value,
                                  //                     onChanged: (v) =>
                                  //                         setState(
                                  //                             () => value = v),
                                  //                     activeColor: Colors.red),
                                  //               )),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: sy(10),
                                  // ),
                                  // Divider(
                                  //   color: Colors.grey[300],
                                  //   height: 18,
                                  // ),
                                  SizedBox(
                                    height: sy(10),
                                  ),
                                  // Container(
                                  //   child: Column(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.start,
                                  //     crossAxisAlignment:
                                  //         CrossAxisAlignment.start,
                                  //     children: [
                                  //       GestureDetector(
                                  //         onTap: () => showDialog(
                                  //             context: context,
                                  //             builder: (_) {
                                  //               return DistancePopUpWidget(
                                  //                   distanceController);
                                  //             }),
                                  //         child: Container(
                                  //           height: sy(20),
                                  //           child: Row(
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment
                                  //                     .spaceBetween,
                                  //             children: [
                                  //               Expanded(
                                  //                 flex: 23,
                                  //                 child: Container(
                                  //                   child: Text(
                                  //                     "Distance Unit",
                                  //                     style: TextStyle(
                                  //                       fontSize: sy(12),
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //               Expanded(
                                  //                 flex:
                                  //                     distance == "Km" ? 9 : 5,
                                  //                 child: Container(
                                  //                   child: Text(
                                  //                     distance == "Km"
                                  //                         ? "Kilometer"
                                  //                         : distance,
                                  //                     overflow:
                                  //                         TextOverflow.visible,
                                  //                     style: TextStyle(
                                  //                         fontSize: sy(10),
                                  //                         color: Colors.red),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //               Expanded(
                                  //                 flex: 2,
                                  //                 child: Container(
                                  //                   margin: EdgeInsets.only(
                                  //                       right: sy(15)),
                                  //                   child: Icon(
                                  //                     Icons.arrow_forward_ios,
                                  //                     color: Colors.red,
                                  //                     size: 15,
                                  //                   ),
                                  //                 ),
                                  //               )
                                  //             ],
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: sy(10),
                                  // ),
                                  // Divider(
                                  //   color: Colors.grey[300],
                                  //   height: 18,
                                  // ),
                                  SizedBox(
                                    height: sy(10),
                                  ),
                                  InkWell(
                                    onTap: ()  {
                                        navigationService.navigateTo(
                                                    ResetScreenRoute);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 15),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 27,
                                            child: Container(
                                              child: Text("Change Password",
                                                  style: TextStyle(
                                                    fontSize: sy(12),
                                                  )),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  right: sy(15)),
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.red,
                                                size: 15,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: sy(10),
                                  ),
                                  // Divider(
                                  //   color: Colors.grey[300],
                                  //   height: 18,
                                  // ),
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // if (isLoadingProgress)
            //   Positioned(
            //       child: Align(
            //     alignment: Alignment.center,
            //     child: CircularProgressIndicator(),
            //   )),
          ]));
    });
  }
}

import 'package:flutter/material.dart';
import 'package:lost_tracking/services/navigation_service.dart';
import 'package:lost_tracking/utils/routes.dart';
import '.././services/navigation_service.dart';
import '.././utils/routes.dart';
import '.././utils/service_locator.dart';
import '.././widget/package_widget.dart';
import 'package:relative_scale/relative_scale.dart';

class PackagesScreen extends StatefulWidget {
  PackagesScreen({Key? key}) : super(key: key);

  @override
  _PackagesScreenState createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  List<Map<String, dynamic>> packageItem = [
    {
      "id": "1",
      "label": "Best value",
      "title": "Basic package",
      "mtitle": "5 users for 1 month ",
      "amount": "25",
    },
    {
      "id": "2",
      "label": "Most popular ",
      "title": "Standard Package",
      "mtitle": "12 Users for 1 month ",
      "amount": "65",
    },
    {
      "id": "3",
      "label": "Pro",
      "title": "Ultimate Package",
      "mtitle": "25 Users for 6 month ",
      "amount": "84",
    },
  ];
  NavigationService? navigationService = locator<NavigationService>();

  String tagId = ' ';
  void active(String val) {
    setState(() {
      tagId = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: missing_required_param
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      // ignore: missing_required_param
      return WillPopScope(
        onWillPop: () => navigationService!
            .navigateTo(HomeScreenRoute)
            .then((value) => value as bool),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        // gradient: LinearGradient(
                        //     begin: Alignment.topLeft,
                        //     end: Alignment.bottomRight,
                        //     colors: [
                        //       Color.fromRGBO(2, 16, 55, 1),
                        //       Color.fromRGBO(6, 28, 85, 1)
                        //     ]),
                        image: DecorationImage(
                          image: AssetImage("assets/images/blue_rounded.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 15),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          navigationService!
                                              .navigateTo(HomeScreenRoute);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // width: MediaQuery.of(context).size.width / 3,
                                  child: Center(
                                    child: Image.asset(
                                      'assets/images/pack.png',
                                      fit: BoxFit.fill,
                                      height: 70,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: sy(18),
                                ),
                                Text(
                                  "Membership",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: sy(15)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.3,
                                  child: Text(
                                    'Lorem Ipsum dollar sit amet, consectetur adipiscing elit, sed do eiusmod tempor ',
                                    style: TextStyle(
                                        fontSize: sy(7),
                                        fontWeight: FontWeight.w200,
                                        color:
                                            Color.fromRGBO(157, 158, 164, 1)),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: sy(20),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(' Select Package',
                                        style: TextStyle(
                                          fontSize: sy(10),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                          padding: EdgeInsets.all(0),
                                          itemCount: packageItem.length,
                                          itemBuilder: (context, i) {
                                            return Column(
                                              children: [
                                                PackageItemWidget(
                                                  data: packageItem[i],
                                                  action: active,
                                                  tag: packageItem[i]['id'],
                                                  active: tagId ==
                                                          packageItem[i]['id']
                                                      ? true
                                                      : false,
                                                ),
                                              ],
                                            );
                                          }),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),

                                        // color: Colors.blue,
                                        gradient: LinearGradient(
                                          begin: Alignment(-0.4, -5.1),
                                          end: Alignment(0.1, 13.0),
                                          colors: [
                                            Colors.red.shade900,
                                            Colors.red.shade900,
                                          ],
                                        ),
                                      ),
                                      // ignore: deprecated_member_use
                                      child: RaisedButton(
                                        color: Colors.red,
                                        splashColor: Colors.transparent,
                                        elevation: 5.0,
                                        onPressed: () {
                                          // if (nameController.text == "" ||
                                          //     emailController.text == "" ||
                                          //     phoneController.text == "" ||
                                          //     passwordController.text == "" ||
                                          //     confirmPasswordController.text == "") {
                                          //   utilService.showToast("Please fill all fields");
                                          // }
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                sy(80.0))),
                                        padding: EdgeInsets.all(0.0),
                                        child: Ink(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      sy(30.0))),
                                          child: Container(
                                            constraints: BoxConstraints(
                                              minHeight: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  7.2,
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Pay Now",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: sy(11),
                                                fontFamily: "Oxygen",
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          // ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ],
                      )),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

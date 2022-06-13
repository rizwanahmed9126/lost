import 'package:flutter/material.dart';
import 'package:lost_tracking/providers/auth_provider.dart';
import 'package:lost_tracking/services/navigation_service.dart';
import 'package:lost_tracking/utils/routes.dart';
import 'package:lost_tracking/utils/service_locator.dart';
import 'package:provider/provider.dart';
import 'package:relative_scale/relative_scale.dart';

class MyContactsScreen extends StatefulWidget {
  MyContactsScreen({Key? key}) : super(key: key);

  @override
  _MyContactsScreenState createState() => _MyContactsScreenState();
}

class _MyContactsScreenState extends State<MyContactsScreen> {
  var navigationService = locator<NavigationService>();
 

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            elevation: 0,
            leading: IconButton(
              iconSize: 25,
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                navigationService.navigateTo(HomeScreenRoute);
              },
            ),
            title: Text(
              "My Contacts",
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
        ),
        body: Container(
          // height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
          child: Container(
            width: double.infinity,
            // height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage("assets/images/person.png"),
                  fit: BoxFit.fill,
                  height: 100,
                  color: Color.fromRGBO(204, 207, 212, 1),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 300,
                  child: Text(
                    "Lorem Ipsum dollar sit amet, consectetur adpiscing elit, sed",
                    style: TextStyle(
                      color: Color.fromRGBO(204, 207, 212, 1),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 250,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.shade200,
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 3),
                      )
                    ],
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
                    color: Theme.of(context).accentColor,
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
                      navigationService.navigateTo(AddContactScreenRoute);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(sy(80.0))),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(sy(30.0))),
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.width / 7.2,
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage("assets/images/add.png"),
                              height: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Add User",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: sy(10),
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

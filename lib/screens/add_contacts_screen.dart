import 'package:flutter/material.dart';
import 'package:lost_tracking/models/user_contact.dart';
import 'package:lost_tracking/models/user.dart';
import 'package:lost_tracking/providers/auth_provider.dart';
import 'package:lost_tracking/services/navigation_service.dart';
import 'package:lost_tracking/services/storage_service.dart';
import 'package:lost_tracking/services/util_service.dart';
import 'package:lost_tracking/utils/routes.dart';
import 'package:provider/provider.dart';
import '../utils/service_locator.dart';
import '../widget/dropdown_menu_widget.dart';

import 'package:relative_scale/relative_scale.dart';

class AddContactsScreen extends StatefulWidget {
  AddContactsScreen({Key? key}) : super(key: key);

  @override
  _AddContactsScreenState createState() => _AddContactsScreenState();
}

class _AddContactsScreenState extends State<AddContactsScreen> {
  bool isLoadingProgress = false;
  var navigationService = locator<NavigationService>();
  StorageService? storageService = locator<StorageService>();
  var utilService = locator<UtilService>();
  var data;
  final GlobalKey<FormState> _formKey = GlobalKey();
  AddContact? user1;
  TextEditingController nameController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  String? memberChoose;
  List? memberItems = ["Friend", "Family"];
  var relation;
  void locationOfPainCallback(String lop) {
    setState(() => relation = lop);
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();

    super.dispose();
  }

  // loadData() async {
  //   user1 = Provider.of<AuthProvider>(context, listen: false).userContactInfo;
  //   if (user1 != null) {
  //     nameController.text = user1!.name!;
  //     addressController.text = user1!.address!;
  //     phoneNumberController.text = user1!.phoneNumber!;
  //     memberChoose = user1!.relation!;
  //   }
  // }

  @override
  void initState() {
    // loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 25,
              ),
              onPressed: () {
                navigationService.navigateTo(SendMessageScreenRoute);
              },
            ),
            title: Text(
              "Add Contact",
              style: TextStyle(color: Colors.black),
            )),
        body: AbsorbPointer(
          absorbing: isLoadingProgress,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        height: sy(420),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Container(
                                      child: TextFormField(
                                        controller: nameController,
                                        autocorrect: true,
                                        decoration: InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .accentColor)),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade400)),
                                          helperStyle:
                                              TextStyle(color: Colors.grey),
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 4.0,
                                                  horizontal: 10),
                                          hintText: 'Name',
                                          hintStyle: TextStyle(
                                              fontSize: sy(9),
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .accentColor),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: sy(20),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: sx(4)),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              width: 1.0,
                                              color: Theme.of(context)
                                                  .accentColor),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          DropdownButton(
                                            dropdownColor: Colors.white,
                                            menuMaxHeight: 200,

                                            hint: Padding(
                                              padding:
                                                  EdgeInsets.only(left: sx(10)),
                                              child: Text(
                                                "Relation",
                                                style: TextStyle(
                                                    fontSize: sy(9),
                                                    fontWeight: FontWeight.w600,
                                                    color: Theme.of(context)
                                                        .accentColor),
                                              ),
                                            ),

                                            // isExpanded: true,
                                            style: TextStyle(
                                                fontSize: sy(12),
                                                color: Colors.white),
                                            value: memberChoose,
                                            underline: SizedBox(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                memberChoose =
                                                    newValue.toString();
                                              });
                                            },
                                            items:
                                                memberItems!.map((valueItem) {
                                              return DropdownMenuItem(
                                                value: valueItem,
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.3,
                                                  child: Text(
                                                    "$valueItem",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: sy(11)),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Container(
                                    //   child: TextFormField(
                                    //     controller: relationController,
                                    //     autocorrect: true,
                                    //     // readOnly: true,
                                    //     keyboardType: TextInputType.text,
                                    //     onTap: () =>
                                    //         FocusScope.of(context).unfocus(),
                                    //     decoration: InputDecoration(
                                    //       enabledBorder: UnderlineInputBorder(
                                    //         borderSide:
                                    //             BorderSide(color: Colors.grey),
                                    //       ),
                                    //       focusedBorder: UnderlineInputBorder(
                                    //           borderSide:
                                    //               BorderSide(color: Colors.red)),
                                    //       isDense: true,
                                    //       contentPadding:
                                    //           const EdgeInsets.symmetric(
                                    //               vertical: 4.0),
                                    //       // prefixIcon: Row(
                                    //       //   children: [
                                    //       //     SizedBox(
                                    //       //       width: 10,
                                    //       //     ),
                                    //       //     Expanded(
                                    //       //         child: Column(
                                    //       //       children: [
                                    //       //         Row(
                                    //       //           children: [
                                    //       //             Text(
                                    //       //               "Relation",
                                    //       //               style: TextStyle(
                                    //       //                   height: 1,
                                    //       //                   fontSize: sy(8),
                                    //       //                   color: Colors.red[900],
                                    //       //                   fontWeight:
                                    //       //                       FontWeight.w500),
                                    //       //               textAlign: TextAlign.start,
                                    //       //             ),
                                    //       //           ],
                                    //       //         ),
                                    //       //         Padding(
                                    //       //           padding: const EdgeInsets.only(
                                    //       //               right: 20.0),
                                    //       //           child: DropDownMenuWidget([
                                    //       //             'Family',
                                    //       //             'Friend',
                                    //       //           ], relation,
                                    //       //               locationOfPainCallback),
                                    //       //         ),
                                    //       //       ],
                                    //       //     )),
                                    //       //   ],
                                    //       // ),
                                    //     ),
                                    //   ),
                                    // ),
                                    SizedBox(
                                      height: sy(20),
                                    ),
                                    Container(
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: phoneNumberController,
                                        autocorrect: true,
                                        decoration: InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .accentColor)),
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 12.0,
                                                  horizontal: 10),
                                          hintText: 'Phone',
                                          hintStyle: TextStyle(
                                              fontSize: sy(9),
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .accentColor),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: sy(20),
                                    ),
                                    Container(
                                      child: TextFormField(
                                        controller: addressController,

                                        autovalidateMode: AutovalidateMode
                                            .onUserInteraction, //when user click the field
                                        autocorrect: true,
                                        decoration: InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .accentColor)),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey)),
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 12.0,
                                                  horizontal: 10),
                                          hintText: 'Address',
                                          hintStyle: TextStyle(
                                              fontSize: sy(9),
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .accentColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),

                                    // color: Colors.blue,
                                    gradient: LinearGradient(
                                      begin: Alignment(-0.4, -5.1),
                                      end: Alignment(0.1, 13.0),
                                      colors: [
                                        Theme.of(context).accentColor,
                                        Theme.of(context).accentColor,
                                      ],
                                    ),
                                  ),
                                  // ignore: deprecated_member_use
                                  child: RaisedButton(
                                    color: Theme.of(context).accentColor,
                                    splashColor: Colors.transparent,
                                    elevation: 5.0,
                                    onPressed: () async {
                                      try {
                                        setState(() {
                                          isLoadingProgress = true;
                                        });

                                        if (phoneNumberController.text.length <
                                            8) {
                                          setState(() {
                                            isLoadingProgress = false;
                                          });
                                          return utilService.showToast(
                                              'Phone number must be greater than 7');
                                        } else {
                                          setState(() {
                                            isLoadingProgress = true;
                                          });
                                          await Provider.of<AuthProvider>(
                                                  context,
                                                  listen: false)
                                              .addUserContact(
                                            nameController.text,
                                            phoneNumberController.text,
                                            addressController.text,
                                            memberChoose!,
                                          );
                                          setState(() {
                                            isLoadingProgress = false;
                                          });
                                        }
                                      } catch (er) {
                                        setState(() {
                                          isLoadingProgress = false;
                                        });
                                        utilService.showToast(er.toString());
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(sy(80.0))),
                                    padding: EdgeInsets.all(0.0),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(sy(30.0))),
                                      child: Container(
                                        constraints: BoxConstraints(
                                          minHeight: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              7.2,
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Save Contact",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: sy(11),
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      // ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (isLoadingProgress == true)
                Positioned(
                    child: Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator()))
            ],
          ),
        ),
      );
    });
  }
}
import 'package:flutter/material.dart';
import 'package:lost_tracking/models/user.dart';
import 'package:lost_tracking/providers/auth_provider.dart';
import 'package:lost_tracking/services/navigation_service.dart';
import 'package:lost_tracking/services/storage_service.dart';
import 'package:lost_tracking/services/util_service.dart';
import 'package:lost_tracking/utils/routes.dart';
import 'package:lost_tracking/utils/service_locator.dart';
import 'package:lost_tracking/widget/cache_image.dart';
import 'package:lost_tracking/widget/column_scroll_view.dart';
import 'package:provider/provider.dart';
import 'package:relative_scale/relative_scale.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isLoadingProgress = false;
  var imageUrl = '';
  var navigationService = locator<NavigationService>();
  StorageService? storageService = locator<StorageService>();
  var utilService = locator<UtilService>();
  var data;
  AppUser? user;
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _address = TextEditingController();

  @override
  void dispose() {
    _address.dispose();
    _email.dispose();
    _phone.dispose();
    _name.dispose();
    super.dispose();
  }

  loadData() async {
    user = Provider.of<AuthProvider>(context, listen: false).user;
    if (user != null) {
      _name.text = user!.displayName!;
      _email.text = user!.email!;
      _phone.text = user!.phoneNumber!;
      _address.text = user!.address!;
      imageUrl = user!.profileImageUrl!;
    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return WillPopScope(
        onWillPop: () => navigationService
            .navigateTo(ProfileScreenRoute)
            .then((value) => value as bool),
        child: AbsorbPointer(
          absorbing: isLoadingProgress,
          child: Scaffold(
              appBar: AppBar(
                title: Text("Edit Profile"),
                leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () =>
                        navigationService.navigateTo(ProfileScreenRoute)),
                backgroundColor: Theme.of(context).backgroundColor,
                elevation: 0,
              ),
              body: Container(
                width: double.infinity,
                color: Theme.of(context).backgroundColor,
                child: Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(sy(10)),
                          topLeft: Radius.circular(sy(10)),
                        )),
                    child: Stack(
                      children: [
                        ColumnScrollView(
                          child: Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.85,
                                decoration: BoxDecoration(),
                                child: Column(
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: sy(10)),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          imageUrl != ''
                                              ? Stack(children: [
                                                  Center(
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 20),
                                                      child: CircleAvatar(
                                                        backgroundColor: Theme
                                                                .of(context)
                                                            .backgroundColor,
                                                        child: CacheImage(
                                                          imageUrl: imageUrl,
                                                          radius: 200,
                                                          height: 120,
                                                          width: 120,
                                                        ),
                                                        radius: 50,
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 80, left: 80),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          _settingModalBottomSheet(
                                                              context);
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  "assets/images/Camera.png"),
                                                          radius: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ])
                                              : Stack(children: [
                                                  Center(
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 20),
                                                      child: CircleAvatar(
                                                        backgroundColor: Theme
                                                                .of(context)
                                                            .backgroundColor,
                                                        child: Icon(
                                                          Icons.person,
                                                          size: 35,
                                                        ),
                                                        //  imageUrl:
                                                        //     imageUrl != '' && imageUrl != null
                                                        //         ? imageUrl
                                                        //         : user['profileImageUrl'],
                                                        radius: 50,
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 80, left: 80),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          _settingModalBottomSheet(
                                                              context);
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  "assets/images/Camera.png"),
                                                          radius: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              if (user!.country != "")
                                                Icon(Icons.location_pin,
                                                    color: Colors.grey,
                                                    size: sy(10)),
                                              Text(user!.country!,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .backgroundColor,
                                                      fontSize: sy(8))),
                                            ],
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
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20))),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: sx(20),
                                                        right: sx(20),
                                                        top: sy(0)),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Form(
                                                          key: _formKey,
                                                          child: Column(
                                                            children: [
                                                              TextFormField(
                                                                controller:
                                                                    _name,
                                                                // readOnly: true,

                                                                style: TextStyle(
                                                                    fontSize:
                                                                        sy(9),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                                autocorrect:
                                                                    true,
                                                                decoration:
                                                                    InputDecoration(
                                                                  labelText:
                                                                      "Name",
                                                                  labelStyle: TextStyle(
                                                                      height:
                                                                          0.7,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .accentColor,
                                                                      fontSize:
                                                                          sy(10)),
                                                                  isDense: true,
                                                                  contentPadding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          4.0,
                                                                      horizontal:
                                                                          10),
                                                                  focusedBorder:
                                                                      UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(color: Theme.of(context).accentColor)),
                                                                  enabledBorder:
                                                                      UnderlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade300),
                                                                  ),
                                                                  hintStyle: TextStyle(
                                                                      color: Colors
                                                                              .grey[
                                                                          400],
                                                                      fontSize:
                                                                          sy(9),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height:
                                                                      sy(20)),
                                                              TextFormField(
                                                                controller:
                                                                    _email,
                                                                readOnly: true,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        sy(9),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                                autocorrect:
                                                                    true,
                                                                decoration:
                                                                    InputDecoration(
                                                                  labelText:
                                                                      "Email",
                                                                  labelStyle: TextStyle(
                                                                      height:
                                                                          0.7,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .accentColor,
                                                                      fontSize:
                                                                          sy(10)),
                                                                  isDense: true,
                                                                  contentPadding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          4.0,
                                                                      horizontal:
                                                                          10),
                                                                  focusedBorder:
                                                                      UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(color: Theme.of(context).accentColor)),
                                                                  enabledBorder:
                                                                      UnderlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade300),
                                                                  ),
                                                                  hintStyle: TextStyle(
                                                                      color: Colors
                                                                              .grey[
                                                                          400],
                                                                      fontSize:
                                                                          sy(9),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height:
                                                                      sy(20)),
                                                              TextFormField(
                                                                controller:
                                                                    _phone,
                                                                // readOnly: true,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        sy(9),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                                autocorrect:
                                                                    true,
                                                                decoration:
                                                                    InputDecoration(
                                                                  labelText:
                                                                      "Phone",
                                                                  labelStyle: TextStyle(
                                                                      height:
                                                                          0.7,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .accentColor,
                                                                      fontSize:
                                                                          sy(10)),
                                                                  isDense: true,
                                                                  contentPadding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          4.0,
                                                                      horizontal:
                                                                          10),
                                                                  focusedBorder:
                                                                      UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(color: Theme.of(context).accentColor)),
                                                                  enabledBorder:
                                                                      UnderlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade300),
                                                                  ),
                                                                  hintStyle: TextStyle(
                                                                      color: Colors
                                                                              .grey[
                                                                          400],
                                                                      fontSize:
                                                                          sy(9),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height:
                                                                      sy(20)),
                                                              TextFormField(
                                                                controller:
                                                                    _address,
                                                                // readOnly: true,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        sy(9),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                                autocorrect:
                                                                    true,
                                                                decoration:
                                                                    InputDecoration(
                                                                  labelText:
                                                                      "Address",
                                                                  labelStyle: TextStyle(
                                                                      height:
                                                                          0.7,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .accentColor,
                                                                      fontSize:
                                                                          sy(10)),
                                                                  isDense: true,
                                                                  contentPadding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          4.0,
                                                                      horizontal:
                                                                          10),
                                                                  focusedBorder:
                                                                      UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(color: Theme.of(context).accentColor)),
                                                                  enabledBorder:
                                                                      UnderlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade300),
                                                                  ),
                                                                  hintStyle: TextStyle(
                                                                      color: Colors
                                                                              .grey[
                                                                          400],
                                                                      fontSize:
                                                                          sy(9),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: sy(2),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                          child: RaisedButton(
                                                            color: Theme.of(
                                                                    context)
                                                                .accentColor,
                                                            splashColor: Colors
                                                                .transparent,
                                                            elevation: 5.0,
                                                            onPressed:
                                                                () async {
                                                              try {
                                                                setState(() {
                                                                  isLoadingProgress =
                                                                      true;
                                                                });
                                                                if (_phone.text
                                                                        .length <
                                                                    8) {
                                                                  setState(() {
                                                                    isLoadingProgress =
                                                                        false;
                                                                  });
                                                                  return utilService
                                                                      .showToast(
                                                                          'Phone number must be greater than 7');
                                                                } else {
                                                                  setState(() {
                                                                    isLoadingProgress =
                                                                        true;
                                                                  });
                                                                  FocusScope.of(
                                                                          context)
                                                                      .requestFocus(
                                                                          FocusNode());
                                                                  await Provider.of<
                                                                              AuthProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .editProfileInformation(
                                                                    _name.text,
                                                                    _phone.text,
                                                                    _address
                                                                        .text,
                                                                    _email.text,
                                                                    imageUrl ==
                                                                            ''
                                                                        ? user!
                                                                            .profileImageUrl!
                                                                        : imageUrl,
                                                                  );
                                                                  setState(() {
                                                                    isLoadingProgress =
                                                                        false;
                                                                  });
                                                                }
                                                              } catch (er) {
                                                                setState(() {
                                                                  isLoadingProgress =
                                                                      false;
                                                                });
                                                                utilService
                                                                    .showToast(er
                                                                        .toString());
                                                              }
                                                            },
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            sy(80.0))),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    0.0),
                                                            child: Ink(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              sy(30.0))),
                                                              child: Container(
                                                                constraints:
                                                                    BoxConstraints(
                                                                  minHeight: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      7.2,
                                                                ),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  "Save Changes",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        sy(10),
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                              // ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ))),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        if (isLoadingProgress)
                          Positioned(
                              child: Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          )),
                      ],
                    )),
              )),
        ),
      );
    });
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 200,
            child: new Wrap(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Upload Profile Picture",
                      //'Upload Profile Picture',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Divider(),
                new ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: LinearGradient(
                            begin: (Alignment.bottomCenter),
                            end: (Alignment.bottomLeft),
                            colors: [
                              Colors.purple,
                              Colors.purpleAccent,
                            ])),
                    child: new Icon(
                      Icons.camera,
                      color: Colors.white,
                    ),
                  ),
                  title: new Text("Take Photo",
                      // 'Take Photo',
                      style: Theme.of(context).textTheme.subtitle2),
                  onTap: () {
                    setState(() {
                      isLoadingProgress = true;

                      utilService
                          .captureImage(user!.id!)
                          .then((String value) => setState(() {
                                data = imageUrl = value;
                                isLoadingProgress = false;
                              }));
                    });

                    isLoadingProgress = false;
                    Navigator.of(context).pop();
                  },
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: new ListTile(
                    leading: Container(
                      margin: EdgeInsets.only(top: 3),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(
                              begin: (Alignment.bottomCenter),
                              end: (Alignment.bottomLeft),
                              colors: [
                                Colors.pink,
                                Colors.pinkAccent,
                              ])),
                      child: new Icon(
                        Icons.image,
                        color: Colors.white,
                      ),
                    ),
                    title: new Text("Browse",
                        // 'Browse',
                        style: Theme.of(context).textTheme.subtitle2),
                    onTap: () {
                      setState(() {
                        isLoadingProgress = true;

                        utilService
                            .browseImage(user!.id!)
                            .then((String value) => setState(() {
                                  data = imageUrl = value;
                                  isLoadingProgress = false;
                                }));
                      });

                      isLoadingProgress = false;
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}

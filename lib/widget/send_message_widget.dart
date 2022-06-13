import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lost_tracking/models/user_contact.dart';

import 'package:relative_scale/relative_scale.dart';

// import 'package:provider/provider.dart';
// import 'package:sportrehapp/locale/app_localization.dart';
// import 'package:sportrehapp/providers/app_language_provider.dart';
// import 'package:sportrehapp/screens/main_dashboard_screen.dart';

// ignore: must_be_immutable
class SendMessageWidget extends StatefulWidget {
  final data;
  bool? active;
  ValueChanged<AddContact>? action;
  final String? tag;
  SendMessageWidget({
    this.data,
    this.action,
    this.active,
    this.tag,
  });

  @override
  _SendMessageWidgetState createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget> {
  bool? isactive = false;
  void handleTap() {
    setState(() {
      widget.action!(widget.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Padding(
          padding: EdgeInsets.only(
            left: sx(5),
            right: sx(5),
            bottom: sy(5),
          ),
          child: GestureDetector(
            onTap: () {
              handleTap();
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                height: sy(60),
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: widget.active!
                          ? Colors.grey.shade300
                          : Colors.grey.shade300,
                      width: sx(1)),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      color: widget.active!
                          ? Colors.grey.shade100
                          : Colors.grey.shade100,
                      spreadRadius: 5,
                    )
                  ],
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            child: Image(
                              image:
                                  AssetImage("assets/images/place_holder.png"),
                              fit: BoxFit.fill,
                            ),
                            radius: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.data.relation,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  widget.data.name,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_pin,
                                      color: Colors.grey.shade300,
                                      size: sy(7),
                                    ),
                                    Text(widget.data.address,
                                        style: TextStyle(
                                            fontSize: sy(6),
                                            color: Colors.grey.shade400)),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.check_circle,
                          color: widget.active!
                              ? Colors.green
                              : Colors.grey.shade300,
                          size: sy(20),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}

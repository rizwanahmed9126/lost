import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lost_tracking/services/navigation_service.dart';
import 'package:relative_scale/relative_scale.dart';
import '../utils/service_locator.dart';

// ignore: must_be_immutable
class PackageItemWidget extends StatefulWidget {
  final data;
  final payment;
  bool? active;
  ValueChanged<String>? action;
  final String? tag;
  final duration;
  PackageItemWidget(
      {this.payment,
      this.action,
      this.active,
      this.tag,
      this.duration,
      this.data});

  @override
  _PackageItemWidgetState createState() => _PackageItemWidgetState();
}

class _PackageItemWidgetState extends State<PackageItemWidget> {
  var navigationService = locator<NavigationService>();
  void handleTap() {
    setState(() {
      widget.action!(widget.tag!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return GestureDetector(
        onTap: () {
          handleTap();

          // Timer(Duration(milliseconds: 200), () {
          //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
          //     return ImpactTabDescriptionScreen(widget.data);
          //   }));
          // });
          //navigationService.navigateTo(ImpactTabDescriptionScreenRoute);
        },
        child: Container(
          padding: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: <BoxShadow>[
              new BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 5.0,
                offset: new Offset(0.0, 0.3),
              ),
            ],
          ),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: widget.active!
                    ? Theme.of(context).backgroundColor
                    : Colors.white,
                width: 1.0,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 8, 10),
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // SizedBox(
                      //   height: ScreenUtil().setSp(30),
                      // ),
                      Row(
                        children: [
                          // SizedBox(
                          //   height: ScreenUtil().setSp(10),
                          // ),

                          Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 160, 34, 1),
                                borderRadius: BorderRadius.circular(4)),

                            // width: 65,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 4.0, left: 4.0, right: 4.0, bottom: 4.0),
                              child: Text(
                                widget.data["label"],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: sy(7),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: sy(2)),
                          Row(
                            children: [
                              Text(
                                widget.data["title"],
                                style: TextStyle(
                                    fontSize: sy(10),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "${widget.data["mtitle"]}",
                                style: TextStyle(
                                    fontSize: sy(7), color: Colors.grey[400]),
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      )),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          '\$${widget.data["amount"]}',
                          style: TextStyle(
                              fontSize: sy(10),
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            color: widget.active!
                                ? Colors.green.shade400
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                          child: IconButton(
                            icon: Icon(
                              Icons.check,
                              size: 18,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              handleTap();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: sy(10),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

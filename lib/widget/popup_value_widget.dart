import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:relative_scale/relative_scale.dart';

class PopUpValueWidget extends StatefulWidget {
  final String? name;
  final HexColor? color;
  final bool? active;
  final ValueChanged<String>? action; //callback value change
  final String? tag;

  PopUpValueWidget(
      {this.name,
      // this.height,
      // this.width,
      this.color,
      this.active,
      this.action,
      this.tag});

  @override
  _PopUpValueWidgetState createState() => _PopUpValueWidgetState();
}

class _PopUpValueWidgetState extends State<PopUpValueWidget> {
  void handleTap() {
    setState(() {
      widget.action!(widget.tag!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return InkWell(
        onTap: () {
          handleTap();
          Navigator.of(context).pop();
        },
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: sy(10), left: sy(20), right: sy(20)),
              width: sy(200),
              height: sy(30),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: widget.active!
                          ? HexColor('#E1E1E1').withOpacity(1.0)
                          : Colors.transparent,
                      spreadRadius: 4,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: [
                      Colors.red,
                      Colors.red.shade400,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.bottomRight,
                  ),
                  color:
                      widget.active! ? HexColor('#9450C9') : Colors.transparent,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(
                    width: 0,
                    color: widget.active! ? HexColor('#9450C9') : Colors.grey,
                  )),
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: null,
                // onPressed: handleTap,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    // Container(
                    //   margin: EdgeInsets.only(top: ScreenUtil().setSp(5)),
                    //   child: Container(
                    //     margin: EdgeInsets.only(bottom: ScreenUtil().setSp(10)),
                    //     child: Image.asset(
                    //       this.widget.image,
                    //       color: widget.active ? Colors.white : Hexcolor('#9450C9'),
                    //       width: ScreenUtil().setHeight(this.widget.width),
                    //       height: ScreenUtil().setHeight(this.widget.height),
                    //       fit: BoxFit.fitWidth,
                    //     ),
                    //   ),
                    // ),
                    Container(
                      child: Text(this.widget.name!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: sy(10),
                            fontWeight: FontWeight.w500,
                            color: widget.active!
                                ? Colors.white
                                : HexColor('#B8BCCB'),
                          )
                          // Theme.of(context).textTheme.bodyText1,

                          ),

                      // margin: EdgeInsets.fromLTRB(0, 13, 0, 13),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

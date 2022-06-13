import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

class NotificationItemWidget extends StatefulWidget {
  NotificationItemWidget({Key? key}) : super(key: key);

  @override
  _NotificationItemWidgetState createState() => _NotificationItemWidgetState();
}

class _NotificationItemWidgetState extends State<NotificationItemWidget> {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: sy(65),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(243, 247, 250, 1),
                    spreadRadius: 9,
                    blurRadius: 7,
                    offset: Offset(0, 3))
              ]),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'FAMLY',
                        style: TextStyle(
                            color: Colors.red[900],
                            fontSize: sy(8),
                            fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: [
                          Text(
                            'Benjamin Frank',
                            style: TextStyle(
                                fontSize: sy(10), fontWeight: FontWeight.w700),
                          ),
                          Text(
                            ' is coming in 30 Mins',
                            style: TextStyle(
                                fontSize: sy(8), fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      SizedBox(height: sy(1)),
                      Container(
                        width: sx(385),
                        child: Text(
                          'Lorem Ipsum is sumply dummy text of the printing ...',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: sy(8),
                              fontWeight: FontWeight.w300,
                              color: Colors.grey[500]),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  width: sy(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '2 mins',
                        style:
                            TextStyle(fontSize: sy(6), color: Colors.grey[500]),
                      ),
                    ],
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

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DropDownMenuWidget extends StatefulWidget {
  final List<String> items;
  var selectedItem;
  ValueChanged<String> action; //callback value change

  DropDownMenuWidget(this.items, this.selectedItem, this.action);
  @override
  _DropDownMenuWidgetState createState() => _DropDownMenuWidgetState();
}

class _DropDownMenuWidgetState extends State<DropDownMenuWidget> {
  String? dropdownValue;

  @override
  void didChangeDependencies() {
    dropdownValue = widget.selectedItem == null || widget.selectedItem == ''
        ? 'Select Relation'
        : widget.selectedItem;
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(DropDownMenuWidget oldWidget) {
    if (dropdownValue == "Select Relation") {
      dropdownValue = widget.selectedItem == null || widget.selectedItem == ''
          ? "Select Relation"
          : widget.selectedItem;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: DropdownButton<String>(
        underline: Container(),
        focusColor: Colors.black,

        // value: dropdownValue ,
        hint: dropdownValue == ''
            ? Text(
                '$dropdownValue',
                style: TextStyle(color: Colors.black),
              )
            : Text("$dropdownValue",
                style: "$dropdownValue" == "Select Relation"
                    ? TextStyle(
                        // color: Colors.grey,
                        // fontFamily: "Gotham",
                        fontSize: 12,
                      )
                    : TextStyle(
                        color: Colors.black,
                        // fontFamily: "Gotham",
                        fontSize: 13,
                      )),
        isDense: true,
        isExpanded: true,
        items: widget.items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: (var v) {
          setState(() {
            dropdownValue = v!;
            widget.action(v);
          });
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:music_app/widgets/dropdown_item.dart';

class DropDownList extends StatelessWidget {
  const DropDownList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black38,
          width: 1,
        ),
      ),
      margin: const EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          DropDownItem(text: "Play"),
          Divider(
            height: 2,
            color: Colors.black38,
          ),
          DropDownItem(text: "Add to queue"),
          Divider(
            height: 2,
            color: Colors.black38,
          ),
          DropDownItem(text: "Add to playlist"),
          Divider(
            height: 2,
            color: Colors.black38,
          ),
          DropDownItem(text: "Delete"),
          Divider(
            height: 2,
            color: Colors.black38,
          ),
          DropDownItem(text: "Share"),
          Divider(
            height: 2,
            color: Colors.black38,
          ),
        ],
      ),
    );
  }
}

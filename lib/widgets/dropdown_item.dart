// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropDownItem extends StatelessWidget {
  final String text;
  final Function? function;
  const DropDownItem({
    Key? key,
    required this.text,
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 2,
          vertical: 4,
        ),
        margin: const EdgeInsets.only(
          left: 18,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            fontFamily: GoogleFonts.syne().fontFamily,
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:music_app/styles/colors.dart' as app_colors;

class SearchBarWidgget extends StatefulWidget {
  String searchString;
  VoidCallback? searchUpdate;
  SearchBarWidgget({
    Key? key,
    this.searchString = "",
    this.searchUpdate,
  }) : super(key: key);

  @override
  State<SearchBarWidgget> createState() => _SearchBarWidggetState();
}

class _SearchBarWidggetState extends State<SearchBarWidgget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 12,
      ),
      child: TextField(
        autofocus: false,
        onChanged: (value) {
          setState(() {
            widget.searchString = value;
          });
        },
        style: TextStyle(
          color: app_colors.backgroundLight,
          fontFamily: GoogleFonts.syne().fontFamily,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white10,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          hintText: "eg. Love Me Like You Do...",
          hintStyle: TextStyle(
            color: app_colors.backgroundLight,
            fontFamily: GoogleFonts.syne().fontFamily,
            fontSize: 16,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

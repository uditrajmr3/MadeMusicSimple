// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:music_app/styles/colors.dart' as app_colors;
import 'package:music_app/widgets/dropdownlist.dart';

class SongListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  const SongListItem({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: app_colors.audioBlueBackgroundLight,
        ),
        child: const Icon(
          Icons.music_note_rounded,
          color: app_colors.backgroundLight,
        ),
      ),
      title: RichText(
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          text: title,
          style: TextStyle(
            fontSize: 16,
            fontFamily: GoogleFonts.syne().fontFamily,
            color: app_colors.backgroundLight,
          ),
        ),
      ),
      subtitle: RichText(
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          text: subtitle,
          style: TextStyle(
            fontSize: 12,
            fontFamily: GoogleFonts.syne().fontFamily,
            color: app_colors.backgroundLight,
          ),
        ),
      ),
      trailing: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return const Dialog(
                  child: DropDownList(),
                );
              });
        },
        child: const Icon(
          Icons.more_vert_rounded,
          color: app_colors.backgroundLight,
        ),
      ),
    );
  }
}

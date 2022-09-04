import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:music_app/styles/colors.dart' as app_colors;
import 'package:music_app/widgets/audio_file.dart';

class PlayerScreen extends StatefulWidget {
  final songName;
  final songDesc;
  final songData;

  const PlayerScreen({
    super.key,
    required this.songData,
    required this.songName,
    required this.songDesc,
  });

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        _audioPlayer.stop();
        return true;
      },
      child: Scaffold(
        backgroundColor: app_colors.audioBluishBackgroundLight,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: h / 3,
              child: Container(
                color: app_colors.audioBlueBackgroundLight,
              ),
            ),
            Positioned(
              top: 0,
              left: 15,
              right: 10,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    _audioPlayer.stop();
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search_rounded,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: h * 0.2,
              height: h * 0.36,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: app_colors.backgroundLight,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2,
                      ),
                      child: Marquee(
                        text: widget.songName!.toString(),
                        scrollAxis: Axis.horizontal,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          fontFamily: GoogleFonts.syne().fontFamily,
                        ),
                      ),
                    ),
                    Text(
                      widget.songDesc!,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w200,
                        fontFamily: GoogleFonts.syne().fontFamily,
                      ),
                    ),
                    AudioFile(
                      player: _audioPlayer,
                      path: widget.songData!,
                      name: widget.songName!,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: h * 0.12,
              height: h * 0.16,
              left: w / 6,
              right: w / 6,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.transparent,
                      width: 2,
                    ),
                    color: app_colors.audioGreyBackgroundLight),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: app_colors.loveColorLight,
                        width: 5,
                      ),
                      image: const DecorationImage(
                        image:
                            AssetImage("assets/images/Music Player-logos.jpeg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

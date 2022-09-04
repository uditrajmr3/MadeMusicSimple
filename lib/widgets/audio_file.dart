// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:music_app/styles/colors.dart' as app_colors;
import 'package:music_app/widgets/toast_widget.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer player;
  final path;
  final String name;

  const AudioFile({
    Key? key,
    required this.player,
    required this.path,
    required this.name,
  }) : super(key: key);

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = const Duration();
  Duration _position = const Duration();

  bool isPlaying = false;
  bool isPaused = false;
  bool isLoop = false;
  final List<IconData> _icons = [
    Icons.play_circle_fill_rounded,
    Icons.pause_circle_filled_rounded,
  ];
  double playBackRate = 1.0;
  late String path;

  Future setAudio() async {
    final file = File(widget.path);
    widget.player.setSourceUrl(file.path);
    path = file.path;
  }

  @override
  void initState() {
    super.initState();
    widget.player.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });
    widget.player.onPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });
    setAudio();
    // widget.player.setSourceUrl(widget.path);
    // widget.player.setSource(UrlSource(widget.path));
    widget.player.onPlayerComplete.listen((event) {
      setState(() {
        if (isLoop) {
          isPlaying = true;
        } else {
          _position = const Duration(seconds: 0);
          isPlaying = false;
        }
      });
    });
  }

  Widget slider() {
    return Slider(
        activeColor: Colors.redAccent,
        inactiveColor: Colors.grey,
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            changeToSecond(value.toInt());
            value = value;
          });
        });
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    widget.player.seek(newDuration);
  }

  Widget btnStart() {
    return IconButton(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      onPressed: () {
        isPlaying ? widget.player.pause() : widget.player.play(UrlSource(path));
        setState(() {
          isPlaying = !isPlaying;
        });
      },
      icon: Icon(
        isPlaying ? _icons[1] : _icons[0],
        size: 50,
        color: app_colors.audioBlueBackgroundLight,
      ),
    );
  }

  Widget btnfast() {
    return IconButton(
      onPressed: () {
        if (playBackRate < 2.0) {
          playBackRate = playBackRate + 0.5;
          widget.player.setPlaybackRate(playBackRate);
        }
        ToastClass()
            .successToast(context, "PlayBack: ${playBackRate.toString()}");
      },
      icon: ImageIcon(
        const AssetImage(
          "assets/images/forward.png",
        ),
        size: 15,
        color: (playBackRate > 1.0)
            ? app_colors.audioBlueBackgroundLight
            : Colors.black,
      ),
    );
  }

  Widget btnSlow() {
    return IconButton(
      onPressed: () {
        if (playBackRate > 0.5) {
          playBackRate = playBackRate - 0.5;
          widget.player.setPlaybackRate(playBackRate);
        }
        ToastClass()
            .successToast(context, "PlayBack: ${playBackRate.toString()}");
      },
      icon: ImageIcon(
        const AssetImage(
          "assets/images/backward.png",
        ),
        size: 15,
        color: (playBackRate < 1.0)
            ? app_colors.audioBlueBackgroundLight
            : Colors.black,
      ),
    );
  }

  Widget btnShuffle() {
    return IconButton(
      onPressed: () {},
      icon: const ImageIcon(
        AssetImage(
          "assets/images/loop.png",
        ),
        size: 18,
        color: Colors.black,
      ),
    );
  }

  Widget btnRepeat() {
    return IconButton(
      onPressed: () {
        if (!isLoop) {
          widget.player.setReleaseMode(ReleaseMode.loop);
          setState(() {
            isLoop = true;
          });
        } else {
          setState(() {
            widget.player.setReleaseMode(ReleaseMode.release);
            isLoop = false;
          });
        }
      },
      icon: ImageIcon(
        const AssetImage(
          "assets/images/repeat.png",
        ),
        size: 18,
        color: isLoop ? app_colors.audioBlueBackgroundLight : Colors.black,
      ),
    );
  }

  Widget loadAsset() {
    return Container(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          btnRepeat(),
          btnSlow(),
          btnStart(),
          btnfast(),
          btnShuffle(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: slider(),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _position.toString().split(".")[0],
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: GoogleFonts.syneMono().fontFamily,
                  ),
                ),
                Text(
                  _duration.toString().split(".")[0],
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: GoogleFonts.syneMono().fontFamily,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          loadAsset(),
        ],
      ),
    );
  }
}

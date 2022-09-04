import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/screens/player.dart';
import 'package:music_app/widgets/gradient_widget.dart';
import 'package:music_app/widgets/songs_lists.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:music_app/styles/colors.dart' as app_colors;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _audioQuery = OnAudioQuery();
  String searchString = "";
  String message = "";
  bool isPermitted = true;

  @override
  void initState() {
    super.initState();
    requestPermission();
    setState(() {});
  }

  void requestPermission() async {
    var storagePermission = await Permission.storage.status;
    if (storagePermission.isDenied || storagePermission.isRestricted) {
      Permission.storage.request();
      isPermitted = false;
    } else {
      isPermitted = true;
    }
  }

  void updateList(String value) {
    // this function is responsible for search query
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Container(
          margin: const EdgeInsets.only(
            left: 10,
          ),
          child: IconButton(
            onPressed: () {},
            icon: const ImageIcon(
              AssetImage(
                "assets/images/menu.png",
              ),
              size: 40,
              color: app_colors.audioBluishBackgroundLight,
            ),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(
              right: 12,
            ),
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.sort_rounded,
                color: app_colors.audioGreyBackgroundLight,
                size: 30,
              ),
            ),
          ),
        ],
      ),

      // body starts here
      body: Container(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              ),
              child: TextField(
                autofocus: false,
                onChanged: (value) {
                  setState(() {
                    searchString = value;
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
            ),

            // recently played
            Container(
              margin: const EdgeInsets.only(
                left: 8,
                right: 2,
                top: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Recently Played",
                    style: TextStyle(
                      fontFamily: GoogleFonts.syne().fontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 21,
                      color: app_colors.backgroundLight,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 1,
              ),
              height: 160,
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: StreamBuilder<List<SongModel>>(
                    stream: _audioQuery
                        .querySongs(
                          sortType: SongSortType.DATE_ADDED,
                          orderType: OrderType.DESC_OR_GREATER,
                          uriType: UriType.EXTERNAL,
                          ignoreCase: true,
                        )
                        .asStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return PlayerScreen(
                                    songName:
                                        snapshot.data![index].displayNameWOExt,
                                    songData: snapshot.data![index].data,
                                    songDesc: snapshot.data![index].artist,
                                  );
                                }));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  12,
                                ),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 15,
                                    sigmaY: 15,
                                  ),
                                  child: Container(
                                    height: 140,
                                    width: 230,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: CustomGradient()
                                            .gradientCustom(index),
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomCenter,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        20,
                                      ),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(
                                        16,
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          textDirection: TextDirection.ltr,
                                          children: [
                                            RichText(
                                              overflow: (snapshot
                                                          .data![index]
                                                          .displayNameWOExt
                                                          .length >
                                                      50)
                                                  ? TextOverflow.ellipsis
                                                  : TextOverflow.visible,
                                              text: TextSpan(
                                                text: snapshot.data![index]
                                                    .displayNameWOExt,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: GoogleFonts.syne()
                                                      .fontFamily,
                                                  color: Colors.white70,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            RichText(
                                              overflow: TextOverflow.ellipsis,
                                              text: TextSpan(
                                                text:
                                                    "${snapshot.data![index].artist!} ${snapshot.data![index].album}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: GoogleFonts.syne()
                                                      .fontFamily,
                                                  color: app_colors
                                                      .audioGreyBackgroundLight,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return Container(
                        height: 20,
                      );
                    },
                  ),
                ),
              ),
            ),
            // *********
            const SizedBox(
              height: 10,
            ),
            isPermitted
                ? Expanded(
                    child: SongsList(
                      audioQuery: _audioQuery,
                      searchQuery: searchString,
                    ),
                  )
                : Center(
                    child: Text(
                      "Please Allow access to storage in 'Settings' first.",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: GoogleFonts.syne().fontFamily,
                        color: app_colors.backgroundLight,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

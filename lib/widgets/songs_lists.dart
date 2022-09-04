// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/widgets/song_list_item.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:music_app/screens/player.dart';
import 'package:music_app/styles/colors.dart' as app_colors;
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SongsList extends StatefulWidget {
  final OnAudioQuery audioQuery;
  final searchQuery;

  const SongsList({
    Key? key,
    required this.audioQuery,
    this.searchQuery = "",
  }) : super(key: key);

  @override
  State<SongsList> createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {
  final itemScrollController = ItemScrollController();
  String s = "";

  Future scrollToItem() async {}

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SongModel>>(
      stream: widget.audioQuery
          .querySongs(
            sortType: SongSortType.DISPLAY_NAME,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true,
          )
          .asStream(),
      builder: (context, snapshot) {
        // if data is loading
        if (snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.limeAccent),
          );
        }
        // if there is no data
        if (snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              "No Songs Available to show. Try Downloading Something.",
              style: TextStyle(
                fontSize: 12,
                fontFamily: GoogleFonts.syne().fontFamily,
                color: app_colors.backgroundLight,
              ),
            ),
          );
        }

        // if no issue show songs: code here
        return ScrollablePositionedList.builder(
            itemScrollController: itemScrollController,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return snapshot.data![index].displayNameWOExt
                      .toLowerCase()
                      .contains(widget.searchQuery)
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return PlayerScreen(
                            songName: snapshot.data![index].displayNameWOExt,
                            songData: snapshot.data![index].data,
                            songDesc: snapshot.data![index].artist,
                          );
                        }));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 2,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 2,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: app_colors.loveColorLight,
                            ),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                            )),
                        child: SongListItem(
                          title: snapshot.data![index].displayNameWOExt,
                          subtitle:
                              "${snapshot.data![index].artist!} ${snapshot.data![index].album}",
                        ),
                      ),
                    )
                  : Container();
            });
      },
    );
  }
}

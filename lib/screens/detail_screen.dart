import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toonflix/services/api/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/webtoon.model.dart';
import '../models/webtoon_detail_model.dart';
import '../models/webtoon_episode_model.dart';

class DetailScreen extends StatefulWidget {
  final WebtoonModel webtoon;

  const DetailScreen({super.key, required this.webtoon});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> detail;
  late Future<List<WebtoonEpisodeModel>> episodes;
  late SharedPreferences prefs;
  bool isLiked = false;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList('likedToons');

    if (likedToons != null) {
      if (likedToons.contains(widget.webtoon.id) == true) {
        setState(() {
          isLiked = true;
        });
      }
    } else {
      prefs.setStringList('likedToons', []);
    }
  }

  @override
  void initState() {
    super.initState();
    detail = ApiService.getToonById(widget.webtoon.id);
    episodes = ApiService.getLatestEpisodeById(widget.webtoon.id);
    initPrefs();
  }

  void onButtonTap(String id, String no) {
    final url =
        Uri.parse('https://comic.naver.com/webtoon/detail?titleId=$id&no=$no');
    launchUrl(url);
    print('onpress');
  }

  onHeartTap() async {
    final likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      if (isLiked) {
        likedToons.remove(widget.webtoon.id);
      } else {
        likedToons.add(widget.webtoon.id);
      }
      await prefs.setStringList('likedToons', likedToons);
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: onHeartTap,
                icon: Icon(isLiked ? Icons.favorite : Icons.favorite_outline))
          ],
          elevation: 2,
          title: Text(
            widget.webtoon.title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.teal,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: widget.webtoon.id,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(10, 10),
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 7)
                            ]),
                        clipBehavior: Clip.hardEdge,
                        width: 250,
                        child: Image.network(
                          widget.webtoon.thumb,
                          headers: const {
                            "User-Agent":
                                "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                FutureBuilder(
                  future: detail,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Text(
                            snapshot.data!.about,
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(snapshot.data!.genre),
                          Text(snapshot.data!.age)
                        ],
                      );
                    }

                    return Text('...');
                  },
                ),
                FutureBuilder(
                    future: episodes,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            for (var episode in snapshot.data!)
                              GestureDetector(
                                onTap: () {
                                  onButtonTap(widget.webtoon.id, episode.id);
                                },
                                child: Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.teal,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          episode.title,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                        Icon(
                                          Icons.chevron_right_rounded,
                                          color: Colors.white,
                                        )
                                      ],
                                    )),
                              )
                          ],
                        );
                      }

                      return Container();
                    })
              ],
            ),
          ),
        ));
  }
}

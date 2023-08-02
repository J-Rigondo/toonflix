import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon.model.dart';
import 'package:toonflix/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final WebtoonModel webtoon;

  const Webtoon({
    super.key,
    required this.webtoon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailScreen(
                      webtoon: webtoon,
                    )));
      },
      child: Column(
        children: [
          Hero(
            tag: webtoon.id,
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
                webtoon.thumb,
                headers: const {
                  "User-Agent":
                      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                },
              ),
            ),
          ),
          Text(webtoon.title),
        ],
      ),
    );
  }
}

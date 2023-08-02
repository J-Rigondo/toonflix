import 'package:flutter/material.dart';
import 'package:toonflix/services/api/api_service.dart';
import 'package:toonflix/widgets/webtoon.dart';

import '../models/webtoon.model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(
          '투데이 웹툰',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: FutureBuilder(
              future: webtoons,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Expanded(
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            print(index);
                            var wt = snapshot.data![index];
                            return Webtoon(webtoon: wt);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(width: 40);
                          },
                        ),
                      ),
                    ],
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            )),
      ),
    );
  }
}

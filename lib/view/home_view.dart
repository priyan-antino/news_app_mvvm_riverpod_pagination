import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pagination/features/states/status_enum.dart';
import 'package:pagination/model_view/news_provider.dart';

import 'list_view.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> abc() async {
      await ref.read(newsProvider.notifier).fetchArticles();
    }

    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "The Hindu",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.newspaper,
                      size: 50,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Breaking news for today....",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            Divider(
              color: Colors.black,
              // indent: 50,
            ),
            Expanded(child: NewsList()),
          ],
        ),
      ),
    );
  }
}

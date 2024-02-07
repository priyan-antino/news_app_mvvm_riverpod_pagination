import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/states/status_enum.dart';
import '../model_view/news_provider.dart';

class NewsList extends StatelessWidget {
  const NewsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        Future<void> abc() async {
          await ref.read(newsProvider.notifier).fetchArticles();
        }

        switch (ref.watch(newsProvider).status) {
          case Status.LOADING:
            {
              abc();
              return const Center(child: CircularProgressIndicator());
            }
          case Status.DATA:
            {
              return NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollEndNotification &&
                      notification.metrics.extentAfter == 0) {
                    // User has reached the end of the list
                    // Load more data or trigger pagination in flutter
                    ref.read(newsProvider.notifier).fetchArticles();
                  }
                  return false;
                },
                child: ListView.builder(
                  itemCount: ref.read(newsProvider).data.length + 1,
                  itemBuilder: (context, index) {
                    final article = ref.read(newsProvider).data;
                    // print(article);
                    if (index < ref.read(newsProvider).data.length) {
                      final title = article[index]["title"] ?? 'No Title';

                      return Container(
                          margin: const EdgeInsets.all(40),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(border: Border.all()),
                          child: Text(title));
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              );
            }
          case Status.FAILED:
            {
              return Text(ref.read(newsProvider).message ?? 'some error');
            }
          default:
            {
              return const Center(child: Text("something failed"));
            }
        }
      },
    );
  }
}

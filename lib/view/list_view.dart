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
                    if (ref.read(newsProvider).hasPartialerror == true) {
                      return false;
                    } else {
                      ref.read(newsProvider.notifier).fetchArticles();
                    }
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

                      return Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        elevation: 10,
                        child: Container(
                            margin: const EdgeInsets.all(20),
                            padding: const EdgeInsets.all(20),
                            // decoration: BoxDecoration(border: Border.all()),
                            child: Text(
                              title,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            )),
                      );
                    } else {
                      return ref.read(newsProvider).hasPartialerror == true
                          ? Center(
                              child: Container(
                                margin: const EdgeInsets.all(20),
                                child: const Text(
                                  "Failed to load more articles.\nPlease check back later...",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            )
                          : const Center(
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

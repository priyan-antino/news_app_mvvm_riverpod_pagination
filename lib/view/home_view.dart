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

    return Scaffold(
      body: Column(
        children: [
          const Expanded(child: NewsList()),
          ref.watch(newsProvider).status == Status.FAILED
              ? Container(
                  child: Text(ref.read(newsProvider).message.toString()),
                )
              : Container(),
        ],
      ),
    );
  }
}

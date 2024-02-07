import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:pagination/features/states/api_response_states.dart';

// _hasNextPage = (_page < body['totalResults'] ~/ _pageSize);
// bool _hasNextPage = true;
// bool _isLoading = false;

// class hasNextNotifier extends StateNotifier<bool> {
//   hasNextNotifier(): super(true);

// }

// final hasNextProvider = StateNotifierProvider<>((ref) {
//   return
// });

class NewsNotifier extends StateNotifier<ApiResponseState<List<dynamic>>> {
  NewsNotifier() : super(ApiResponseState.loading());

  // final baseUrl = baseUrlProvider;
  final _baseUrl =
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=4bb161bec2744bd7a2c97d412db3e59f';

  int _page = 1;
  final int _pageSize = 5;

  // ignore: prefer_final_fields
  List<dynamic> _articles = [];

  Future<void> fetchArticles() async {
    try {
      final url = '$_baseUrl&page=$_page&pageSize=$_pageSize';
      final response = await http.get(Uri.parse(url));
      final body = json.decode(response.body);
      if (_articles.length >= 14) {
        state = ApiResponseState.data(_articles, true);
        return;
      }
      _articles.addAll(body['articles']);
      _articles.isNotEmpty
          ? {print("got data")}
          : print("data fetching error provider");

      print("page number is $_page");
      _page++;
      print("Number of articles are ${_articles.length}");

      _articles.isNotEmpty
          ? state = ApiResponseState.data(_articles, false)
          : null;
    } catch (e) {
      if (_articles.isNotEmpty) {
        state = ApiResponseState.data(_articles, true);
      } else {
        state = ApiResponseState.failed(e.toString());
      }
    }
  }
}

final newsProvider =
    StateNotifierProvider<NewsNotifier, ApiResponseState>((ref) {
  return NewsNotifier();
});

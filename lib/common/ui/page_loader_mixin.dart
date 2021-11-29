import 'package:flutter/cupertino.dart';

mixin PageLoaderMixin<T extends StatefulWidget> on State<T> {
  final pageLoaderScrollController = ScrollController();

  bool get isScrolledToEnd => pageLoaderScrollController.offset == pageLoaderScrollController.position.maxScrollExtent;

  @override
  void initState() {
    pageLoaderScrollController.addListener(() {
      if (isScrolledToEnd) {
        loadNextPage();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    pageLoaderScrollController.dispose();
    super.dispose();
  }

  void loadNextPage();
}

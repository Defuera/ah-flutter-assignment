import 'package:flutter/cupertino.dart';

/// Use `pageLoaderScrollController` as a controller of your ScrollView.
/// [PageLoaderMixin.loadNextPage] will be invoked every time page is scrolled to an end
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

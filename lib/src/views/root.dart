import 'package:dynamic_pageviews/src/views/root_views/single_page.dart';
import 'package:flutter/material.dart';

import 'package:rxdart/rxdart.dart';

import 'package:dynamic_pageviews/src/models/page_data.dart';

import 'package:dynamic_pageviews/src/services/paging.dart';

import 'package:dynamic_pageviews/src/views/root_views/welcome.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final PagingService _service = PagingService();
  final PageController _pageController = PageController(initialPage: 0);
  final BehaviorSubject<List<Widget>> _pages = BehaviorSubject<List<Widget>>.seeded([]);

  void _setInitialPage() {
    this._pages.sink.add([
      WelcomePage(
        onClick: this._naviateToNextPage,
      ),
    ]);
  }

  Future<void> _removeLastPage() async {
    await this._pageController.previousPage(
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 200),
        );
    // waiting for transition to complete
    final List<Widget> currentPages = this._pages.value;
    currentPages.removeLast();
    this._pages.sink.add(currentPages);
  }

  // your logic for navigation
  bool isOktoNextPage({PageData pageData, bool feedbackValue}) {
    return pageData.condition == feedbackValue;
  }

  Future<void> _naviateToNextPage([int pageId = 0]) async {
    final PageData pageData = await this._service.getPageData(pageId);
    final List<Widget> currentPages = this._pages.value;
    currentPages.add(
      SinglePage(
        pageData: pageData,
        feedback: (bool feedback) {
          final bool isOktoProceed = this.isOktoNextPage(
            feedbackValue: feedback,
            pageData: pageData,
          );

          if (isOktoProceed) {
            this._naviateToNextPage(pageId + 1);
          } else {
            // condition failed! do something.
          }
        },
        goBack: this._removeLastPage,
      ),
    );
    this._pages.sink.add(currentPages);
    this._pageController.nextPage(
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 200),
        );
  }

  @override
  void initState() {
    // adding welcome page as first page as soon as the state get initiated.
    this._setInitialPage();
    super.initState();
  }

  @override
  void dispose() {
    _pages.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [],
        body: StreamBuilder<List<Widget>>(
          stream: this._pages,
          initialData: this._pages.value,
          builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
            return PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              controller: this._pageController,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) => snapshot.data[index],
            );
          },
        ),
      ),
    );
  }
}

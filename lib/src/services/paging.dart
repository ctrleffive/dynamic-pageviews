import 'package:dynamic_pageviews/src/models/page_data.dart';

class PagingService {
  /// get data from api and return
  Future<PageData> getPageData(int pageId) async {
    final PageData pageData = PageData(
      title: 'Page Title $pageId',
      description: 'Some long description goes here.',
      condition: true,
    );
    return pageData;
  }
}

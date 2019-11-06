import 'package:dynamic_pageviews/src/models/page_data.dart';
import 'package:flutter/material.dart';

class SinglePage extends StatelessWidget {
  final PageData pageData;
  final Function() goBack;
  final Function(bool) feedback;

  SinglePage({
    this.goBack,
    this.pageData,
    this.feedback,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          this.pageData.title,
          style: Theme.of(context).textTheme.display1,
        ),
        SizedBox(height: 10),
        Text(
          this.pageData.description,
          style: Theme.of(context).textTheme.subhead,
        ),
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              color: Colors.green,
              textColor: Colors.white,
              onPressed: () => this.feedback(true),
              child: Text('TRUE'),
            ),
            SizedBox(width: 10),
            MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () => this.feedback(false),
              child: Text('FALSE'),
            ),
          ],
        ),
        SizedBox(height: 10),
        MaterialButton(
          color: Colors.blueAccent,
          textColor: Colors.white,
          onPressed: this.goBack,
          child: Text('GO BACK'),
        ),
      ],
    );
  }
}

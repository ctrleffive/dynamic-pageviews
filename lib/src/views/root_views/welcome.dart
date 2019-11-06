import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  final Function() onClick;

  const WelcomePage({Key key, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Hi!',
          style: Theme.of(context).textTheme.display2,
        ),
        SizedBox(height: 10),
        Text(
          'Welcome',
          style: Theme.of(context).textTheme.display1,
        ),
        SizedBox(height: 50),
        MaterialButton(
          color: Colors.blueAccent,
          textColor: Colors.white,
          onPressed: this.onClick,
          child: Text('START!'),
        ),
      ],
    );
  }
}

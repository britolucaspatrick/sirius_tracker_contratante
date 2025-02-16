import 'package:flutter/cupertino.dart';

class NoData extends StatelessWidget{
  final String labelText;

  const NoData({Key key, this.labelText}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Center(
        child: Column(
          children: <Widget>[
            Image(
              image: AssetImage("assets/images/nodata.png"),
              height: 90,
              width: 90,
            ),
            Text(labelText)
          ],
        )
    );
  }

}
import 'package:covid_frontline/ui/nks_constants.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class NksCard extends StatelessWidget {
  final String header;
  final String data;
  final String btnText;
  final color;
  final func;

  NksCard(
      {@required this.color,
      @required this.header,
      @required this.data,
      @required this.btnText,
      @required this.func});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
                spreadRadius: 5.0, color: Colors.blueGrey, blurRadius: 10.0)
          ],
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Text(
                      header,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, bottom: 10.0),
                    child: Center(
                      child: Text(
                        data,
                        style: kOptionStyle.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(width: 100),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: FlatButton.icon(
                          icon: Icon(LineIcons.money),
                          color: Colors.greenAccent[100],
                          textColor: Colors.black,
                          onPressed: func,
                          label: Text(btnText),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

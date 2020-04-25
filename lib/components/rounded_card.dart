import 'package:flutter/material.dart';

class RoundedCard extends StatelessWidget {
  RoundedCard(
      {this.title,
      this.subtitle,
      this.icon,
      this.color,
      @required this.onPressed});

  final Color color;
  final String title;
  final Function onPressed;
  final icon;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
      child: Material(
        elevation: 5.0,
        color: color == null ? Theme.of(context).accentColor : color,
        borderRadius: BorderRadius.circular(10.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 150.0,
          child: Row(
            children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    icon == null ? Icons.check : icon,
                    size: 55,
                    color: Colors.white,
                  )),
              SizedBox(width: 30),
              Flexible(
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[200],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:covid_frontline/ui/nks_constants.dart';

class NksNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            child: Icon(
              LineIcons.shield,
              size: 30.0,
              color: kBgcolor,
            ),
            backgroundColor: kFgcolor,
            radius: 30.0,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            'Covid Frontline',
            style: TextStyle(
              color: kFgcolor,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

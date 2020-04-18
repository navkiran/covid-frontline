import 'package:flutter/material.dart';

class Card extends StatefulWidget {
  final String filledName,
      filledContact,
      filledAddress,
      filledNeed,
      filledJob,
      filledState,
      filledDistrict;

  Card(
      {this.filledAddress,
      this.filledName,
      this.filledContact,
      this.filledNeed,
      this.filledJob,
      this.filledDistrict,
      this.filledState});

  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<Card> {
  bool reviewed = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
            color: Colors.red[100],
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text('Name', style: TextStyle(fontWeight: FontWeight.w500)),
              Text(
                widget.filledName,
              ),
              widget.filledNeed != null
                  ? Text('Need', style: TextStyle(fontWeight: FontWeight.w500))
                  : SizedBox(),
              widget.filledNeed != null
                  ? Text(
                      widget.filledNeed,
                    )
                  : SizedBox(),
              widget.filledJob != null
                  ? Text('Service',
                      style: TextStyle(fontWeight: FontWeight.w500))
                  : SizedBox(),
              widget.filledJob != null
                  ? Text(
                      widget.filledJob,
                    )
                  : SizedBox(),
              Text('Contact', style: TextStyle(fontWeight: FontWeight.w500)),
              Text(
                widget.filledContact,
              ),
              Text(
                  'Address in ' +
                      widget.filledDistrict +
                      ' ' +
                      widget.filledState,
                  style: TextStyle(fontWeight: FontWeight.w500)),
              Text(
                widget.filledAddress,
              ),
              reviewed == true
                  ? FlatButton.icon(
                      onPressed: () {
                        setState(() {
                          reviewed = !reviewed;
                        });
                      },
                      icon: Icon(Icons.check),
                      label: Text('Reviewed'))
                  : FlatButton.icon(
                      onPressed: () {
                        setState(() {
                          reviewed = !reviewed;
                        });
                      },
                      icon: Icon(Icons.cancel),
                      label: Text('Not reviewed yet'))
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AlertMessage {
  showAlert (BuildContext context, message, status) {
    Color? coloring;
    Color linecolor;
    if (status) {
      coloring = Colors.green[200];
      linecolor = Colors.green;
    } else {
      coloring = Colors.pink[200];
      linecolor = Colors.red;
    }

    SnackBar snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: coloring,
          border: Border.all(color: linecolor, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              spreadRadius: 2.0,
              blurRadius: 8.0,
              offset: Offset(2, 4)
            )
          ], //Box Shadow
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Icon(Icons.favorite, color: Colors.green,),
            Padding(padding: EdgeInsets.only(left: 8),
            child: Text(message,
              style: TextStyle(
                color: Colors.black
              ))),
              const Spacer(),
              TextButton(
                onPressed: () => {debugPrint("Undid")}, 
                child: Text('X'))
          ],
        ),
      ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future showAlertDialog(BuildContext context) {
    Widget cancelButton = MaterialButton(
      shape: BeveledRectangleBorder(side: BorderSide()),
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop({'status': false});
      },
    );
    Widget continueButton = MaterialButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.of(context).pop({'status': true});
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text(
          "Would you like to continue learning how to use Flutter alerts?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}

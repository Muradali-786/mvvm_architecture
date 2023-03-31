import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{

  static void onFcousChange(BuildContext context,FocusNode current ,FocusNode nextFocus){

    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);


  }


  static toastMessage(String message){

    Fluttertoast.showToast(

      msg: message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
    );


  }

  static void flushBarErrorMessage(String message ,BuildContext context){

    showFlushbar(context: context, flushbar: Flushbar(
      message: message,
      backgroundColor: Colors.red,
      borderRadius: BorderRadius.circular(20),
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
      duration: Duration(seconds: 2),
      forwardAnimationCurve: Curves.slowMiddle,
      reverseAnimationCurve: Curves.bounceOut,
      flushbarPosition: FlushbarPosition.TOP,
      positionOffset: 30,

    )..show(context)

    );


  }
  static snackBar(String message,BuildContext context){

    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(

        duration: Duration(seconds: 4),
          content: Text(message,style: TextStyle(color: Colors.green),),
      backgroundColor: Colors.red,
        padding: EdgeInsets.all(15),


      )
    );


  }





}
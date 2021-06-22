// Progress indicator widget to show loading.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget loadingView() {
 return Center(
    child: CircularProgressIndicator(backgroundColor: Colors.white,),
  );
}

// View to empty data message
Widget noDataView(String msg) {
  return Center(
    child: Text(
      msg,
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black),
    ),
  );
}

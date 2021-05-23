import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget vinousCircleProgressBarScaffold(TickerProvider tickerProvider){
  return Scaffold(
    body: Padding(
      padding: EdgeInsets.all(10),
      child: Center(
        child: Container(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            valueColor:
            ColorTween(begin:Color.fromRGBO(110, 53, 76, 1),
                end: Color.fromRGBO(130, 147, 153, 1))
                .animate(
              AnimationController(
                  duration: const Duration(microseconds: 10),
                  vsync: tickerProvider),
            ),
          ),
        ),
      ),
    ),
  );
}
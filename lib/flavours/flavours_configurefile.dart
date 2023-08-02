import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FlavoursConfig{
 static  FlavoursConfig? _instance;
 FlavoursConfig._();
 static FlavoursConfig getInstance(){
   if(_instance==null){
    _instance= FlavoursConfig._();
   }
   return _instance??FlavoursConfig._();
 }
  Color? color;
  String?apptitle;
  ThemeData?apptheme;
  String? apiEndapoints;
  dynamic context;
  FlavoursConfig({this.apptitle,this.apiEndapoints="default",this.apptheme,
  required this.context,this.color}){
    this.apptitle="Flutter_Weather";
    this.apptheme=ThemeData(primaryColor: color,
      textTheme: GoogleFonts.rajdhaniTextTheme(),
      appBarTheme: AppBarTheme(
        titleTextStyle: GoogleFonts.rajdhaniTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white)
            .titleLarge,
      ),);
  }
}
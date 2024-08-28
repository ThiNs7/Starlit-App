import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';

TextStyle txtNunitoBold(double tamanho){
    return GoogleFonts.nunitoSans(
      fontSize: tamanho,
      fontWeight: FontWeight.w700
    );
}
TextStyle txtNunito300(double tamanho){
    return GoogleFonts.nunitoSans(
      fontSize: tamanho,
      fontWeight: FontWeight.w300
    );
}

TextStyle txtNunitoBoldWhite(double tamanho){
    return GoogleFonts.nunitoSans(
      fontSize: tamanho,
      color: Colors.white,
      fontWeight: FontWeight.w700
    );
}

TextStyle txtNunitoGreen(double tamanho){
    return GoogleFonts.nunitoSans(
      fontSize: tamanho,
      color: Colors.green,
      fontWeight: FontWeight.w700
    );
}

TextStyle txtSans(double tamanho, color){
    return GoogleFonts.ptSans(
      fontSize: tamanho,
      fontWeight: FontWeight.w700,
      color: color
    );
  }

TextStyle txtSansation(double tamanho) {
  return TextStyle(
    fontFamily: 'Sansation',
    fontWeight: FontWeight.w700, 
    fontSize: tamanho,
    color: Colors.white, 
  );
}




import 'package:flutter/material.dart';

BottomNavigationBarItem bottomNavigationBarItem( IconData icon, String txt){
return BottomNavigationBarItem(
 
  icon: Icon(icon, color: Colors.black),
  label: txt
  );
}
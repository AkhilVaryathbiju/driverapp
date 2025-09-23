

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationServices{
  static Future<void> getCurrentLocation()async{
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();  
    if(!serviceEnabled) throw Text('Location Services are enabled');
     LocationPermission permission = await Geolocator.checkPermission();
     if(permission==LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission==LocationPermission.denied){
        throw  Text('Location access denied');
      }
     }
      if(permission==LocationPermission.deniedForever){
        throw Text('Location access has been denied forever');
      }
     await  Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      
      
     }
     static Stream<Position> getLocationStream(){
      return Geolocator.getPositionStream(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 0,
          
        ),
      );
     }
     
  }

 

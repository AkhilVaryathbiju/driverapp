


import 'dart:async';

import 'package:driver_app/models/order.dart';
import 'package:driver_app/services/location_services.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {


Position?driverPosition;
double distanceToRestaurant=0;
double distanceToCustomer=0;
Timer? _timer;

@override
  void initState() {
    
    super.initState();
    
_updateLocation();
_timer=Timer.periodic(Duration(seconds: 1), (timer){
  _updateLocation();
});

// driverPosition =Position(longitude: order.customerLat,
//  latitude: order.customerLng,
//   timestamp: DateTime.now(),
//    accuracy: 1.0,
//     altitude: 0.0,
//      altitudeAccuracy: 1.0,
//       heading: 0.0,
//        headingAccuracy: 0.0, 
//        speed: 0.0,
//         speedAccuracy: 0.0);






  }
  void _updateLocation()async{
    Position position= await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );
setState(() {
  driverPosition=position;
  distanceToRestaurant = Geolocator.distanceBetween(
    position.latitude, position.longitude, order.restaurantLat, order.restaurantLng);
distanceToCustomer = Geolocator.distanceBetween(
    position.latitude, position.longitude, order.customerLat, order.customerLng);

});
  }
@override
void dispose(){
  _timer?.cancel();
  super.dispose();
}


  TextStyle styles=TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 15
  );

orderStatus status=orderStatus.notStarted;


  final order = Order(id: 211, 
  restaurantNAme: 'Chinese Restaurant',
   restaurantLat: 23.2599,
    customerLng: 77.4180,
     amount: 150,
      customerLat: 23.2621, 
      customerName: 'sam',
       restaurantLng: 77.4126
       );






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        title: Text('Order',style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 28
        ),),
      ),
      body: SingleChildScrollView(
        
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Center(
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Container(
                height: 257,
                width: 300,
                child: Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Row(
                           children: [
                             Text('ID  ',style: TextStyle(fontWeight: FontWeight.bold),),
                             Text(' : ${order.id}',style: styles,)
                           ],
                         ),
                       ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.restaurant),
                        Text(' : ${order.restaurantNAme}',style: styles,)
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.location_on_rounded),
                        Text(' : ${order.restaurantLat}:${order.restaurantLng}',style: styles)
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.person),
                        Text(' : ${order.customerName}',style: styles)
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                       Icon(Icons.person_pin_circle_rounded),
                        Text(' : ${order.customerLat}:${order.customerLng}',style: styles)
                      ],
                    ),
                  ),
                    ],
                  ),
                ),
               decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20)),
               ),
             ),
           ),
            SizedBox(height: 30,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
                fixedSize: Size(300, 40)
              ),
              onPressed: status==orderStatus.notStarted?(){
              setState(() {
                status=orderStatus.onTheWay;
              });
            }:null, child: Text('Start trip',style: styles,)),
            SizedBox(height: 10,),
            ElevatedButton(
              style:  ElevatedButton.styleFrom(
                fixedSize: Size(300, 40),
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10))
              ),
              onPressed: status==orderStatus.onTheWay&&distanceToRestaurant<=50?(){
              setState(() {
                status=orderStatus.atTheRestaurant;
              });
            }:null, child: Text(distanceToRestaurant<=50?'Arrived at the Restaurant':'You are ${distanceToRestaurant.toStringAsFixed(1)}m away'
            ,style: styles,)),
            SizedBox(height: 10,),
            ElevatedButton(
              style:  ElevatedButton.styleFrom(
                fixedSize: Size(300, 40),
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10))
              ),
              onPressed: status==orderStatus.atTheRestaurant?(){
              setState(() {
                status=orderStatus.pickedUp;
              });
            }:null, child: Text('Picked Up',style: styles,)),
            SizedBox(height: 10,),
            ElevatedButton(
              style:  ElevatedButton.styleFrom(
                fixedSize: Size(300, 40),
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10))
              ),
              onPressed: status==orderStatus.pickedUp&&distanceToCustomer<=50?(){
              setState(() {
                status=orderStatus.atCustomer;
              });
            }:null, child: Text(distanceToCustomer<=50?'Arrived at the Customer':'You are ${distanceToCustomer.toStringAsFixed(1)} m away'
            ,style: styles,)),
            SizedBox(height: 10,),
            ElevatedButton(
              style:  ElevatedButton.styleFrom(
                fixedSize: Size(300, 40),
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10))
              ),
              
              onPressed: status==orderStatus.atCustomer?(){
              setState(() {
                status=orderStatus.delivered;
              });
            }:null, child: Text('Delivered',style: styles,)),
            SizedBox(height: 10,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
        
              ),
              onPressed: ()async{
              double lat=(status==orderStatus.pickedUp||status==orderStatus.atCustomer)?order.customerLat:order.restaurantLat;
              double lng=(status==orderStatus.pickedUp||status==orderStatus.atCustomer)?order.customerLng:order.restaurantLng;
                 
        
        
            final Url ='https://www.google.com/maps/dir/?api=1&destination=${lat},${lng}';
            await launchUrl(Uri.parse(Url));
            }, child: Text(status == orderStatus.pickedUp || status == orderStatus.atCustomer
                      ? 'Navigate to Customer'
                                 : 'Navigate to Restaurant',style: styles,)),
            SizedBox(height: 10,),
           Text(
          'Current Status: ${status.toString().split('.').last}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
        
          ],
        ),
      ),
    );
  }
}
enum orderStatus{
  notStarted,
  onTheWay,
  atTheRestaurant,
  pickedUp,
  atCustomer,
  delivered
}

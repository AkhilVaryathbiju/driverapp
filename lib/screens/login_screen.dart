
import 'package:driverapp/screens/order_screen.dart';
import 'package:driverapp/widgets/custom_textfeild.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController passController = TextEditingController();
    return Scaffold(
      body: Container(
        color: Colors.orange,
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50,bottom: 0,left: 10,right: 10),
              child: Text('Driver App',style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Colors.white
              ),),
            ),
              SizedBox(height: 80,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextfeildCustom(
                controller: nameController,
                
                hintText: 'Username',
              )
            ),
          
            Padding(padding: EdgeInsets.all(8.0),
            child: TextfeildCustom(
              controller: passController,
              hintText: 'Password',
            ),),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextButton(onPressed: (){
               if(nameController.text=='user'&&passController.text=='1234'){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OrderScreen()));
               }else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enter correct username and password')));
               }
              }, child: Container(height: 40,
              width: 80,
                child: Center(child: Text('Login',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),),),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.red,
                    Colors.red
                  ]),
                  borderRadius: BorderRadius.circular(10)
                ),
              )),
            )
            
        
          ],
        ),
      ),
    );
  }
}
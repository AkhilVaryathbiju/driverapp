import 'package:flutter/material.dart';

class TextfeildCustom extends StatelessWidget {
  String ?hintText;
  TextEditingController controller=TextEditingController();
   TextfeildCustom({super.key,this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.transparent,
        hintText: hintText,
        
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15)
        )
      ),
      
    );
  }
}
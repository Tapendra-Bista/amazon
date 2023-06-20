  import 'package:flashtoast/flash_toast.dart';
import 'package:flutter/material.dart';
void flashfunction(context,String mytitle,String mymessage,FlashType flashType) {
    FlashToast.showFlashToast( 
      
        padding: const EdgeInsets.all(9),
        height: 70,
        width: 370,
    
        context: context,
        title:mytitle,
        message: mymessage,
        flashType: flashType,
        flashPosition: FlashPosition.center);
  }
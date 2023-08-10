import 'package:flutter/material.dart';
class Go {

  move({required BuildContext context, required Widget target,bool clear = false,Function(dynamic)? callback}) async{
    if(clear){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>target), (route) => false);
    } else{
      final data = await Navigator.push(context, MaterialPageRoute(builder: (context)=> target));
      if(callback != null){
        callback(data);
      }
    }

  }
}
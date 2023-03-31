

import 'package:flutter/cupertino.dart';
import 'package:mvvm/model/signup_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpViewModel with ChangeNotifier{


  Future<bool> saveUser(SignUpModel sign)async{

    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('id', sign.id.toString());
    sp.setString('key',sign.token.toString());
    notifyListeners();
    return true ;
  }

  Future<SignUpModel> getUser()async{

    final SharedPreferences sp = await SharedPreferences.getInstance();
     dynamic id=sp.getString('id');
    final String? token = sp.getString('key');

    return SignUpModel(
        token: token.toString(),
        id: id

    );
  }

  Future<bool> remove()async{

    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('key');
    sp.remove('id');
    return true;

  }


}
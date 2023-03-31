
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm/model/signup_model.dart';
import 'package:mvvm/model/user_model.dart';
import 'package:mvvm/repository/auth_repository.dart';
import 'package:mvvm/utils/routes/routes_names.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/signup_view_model.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier{


  final _myRepo=AuthRepository();

  bool _loading=false;
  bool get loading=>_loading;

  bool _signloading=false;
  bool get signloading=>_signloading;
  void getLoading(bool value){
    _loading=value;
    notifyListeners();

  }
  void SignUpLoading(bool value){
    _signloading=value;
    notifyListeners();

  }



  Future<void> loginApi(dynamic data,BuildContext context)async{
          getLoading(true);
     _myRepo.loginAPi(data).then((value){
       getLoading(false);
       final userPref=Provider.of<UserViewModel>(context,listen: false);
       userPref.saveUser(
         UserModel(
           token: value['token'].toString()
         )
       );
       Utils.flushBarErrorMessage('Login Successful', context);
       Navigator.pushNamed(context, RoutesName.home);
       if(kDebugMode){
         print(value.toString());
       }
     }).onError((error, stackTrace){
       getLoading(false);
     if(kDebugMode){
       Utils.flushBarErrorMessage(error.toString(), context);
       print(error.toString());
     }

     });


   }

  Future<void> SignUpApi(dynamic data,BuildContext context)async{
    SignUpLoading(true);
    _myRepo.SignUpAPi(data).then((value){
      SignUpLoading(false);
      final userPref=Provider.of<SignUpViewModel>(context,listen: false);
      userPref.saveUser(
        SignUpModel(
          token: value['token'],
          id: value['id']
        )
      );
      Utils.flushBarErrorMessage('Account Created Successful', context);
      Navigator.pushNamed(context, RoutesName.home);
      if(kDebugMode){
        print(value.toString());
      }
    }).onError((error, stackTrace){
      SignUpLoading(false);
      if(kDebugMode){
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }

    });


  }


}
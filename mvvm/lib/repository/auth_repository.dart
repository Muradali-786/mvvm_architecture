

import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:mvvm/data/network/NetworkApiServices.dart';
import 'package:mvvm/res/components/app_url.dart';

class AuthRepository{
  
  BaseApiServices _apiServices=NewtworkApiServices();
  
  Future<dynamic> loginAPi(dynamic data)async{
    
    try{
      
      dynamic response=await _apiServices.getPostApiResponse(AppUrl.loginEndpoint, data);

      return response;

    }catch(e){
      throw e;
    }
    
  }
  Future<dynamic> SignUpAPi(dynamic data)async{

    try{

      dynamic response=await _apiServices.getPostApiResponse(AppUrl.resgisteApiEndpoint, data);

      return response;

    }catch(e){
      throw e;
    }

  }




}
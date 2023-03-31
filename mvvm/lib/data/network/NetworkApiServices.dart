import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:mvvm/data/app_exception.dart';
import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:http/http.dart' as http;

class NewtworkApiServices extends BaseApiServices{
  @override
  Future getGetApiResponse(String url)async {

    dynamic responseJson;
    try{
      final response=await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson=returnResponse(response);
    }on SocketException{
    throw FetchDataException('No internet connection ');
        }
        return responseJson;
  }

  @override
  Future getPostApiResponse(String url,dynamic data) async{
    dynamic responseJson;
  try{
    Response response =await http.post(Uri.parse(url),
    body: data
    ).timeout(const Duration(seconds: 10));
    responseJson=returnResponse(response);
  }on SocketException{
    throw FetchDataException('No internet connection');
  }
  return responseJson;
  }

  dynamic returnResponse(http.Response response){
    switch(response.statusCode){
      case 200:
        dynamic responseJson=jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException();
      case 404:
        throw UnauthorisedException();
      case 500:
      default:
        throw FetchDataException('Error occurred with communicating with server'+'with status code'+response.statusCode.toString());
    }
  }

}

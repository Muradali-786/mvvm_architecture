import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_names.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final shardProvider=Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Home View'),
          automaticallyImplyLeading: false
          ,
      actions: [
        TextButton(onPressed: (){
          shardProvider.remove().then((value){
            Navigator.pushNamed(context, RoutesName.login);
            Utils.toastMessage('LogOut Successfully');

          }).onError((error, stackTrace){
            Utils.toastMessage('error ');
          });

        }, child: Text('Logout',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),))
     ,SizedBox(

          width: 20,
        )
       ]
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text('Welcome to HOMEsCREEN') ,
          ),




        ],
      ),
    );
  }
}

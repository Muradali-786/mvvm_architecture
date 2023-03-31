import 'package:flutter/material.dart';
import 'package:mvvm/res/round_button.dart';
import 'package:mvvm/utils/routes/routes_names.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailC=TextEditingController();
  TextEditingController passC=TextEditingController();

  FocusNode emailFocus=FocusNode();
  FocusNode passFocus=FocusNode();

  ValueNotifier<bool> _notifier=ValueNotifier<bool>(true);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailC.dispose();
    passC.dispose();
    emailFocus.dispose();
    passFocus.dispose();

    _notifier.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final authProvider=Provider.of<AuthViewModel>(context);
    final height=MediaQuery.of(context).size.height*1;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Login View'),
        automaticallyImplyLeading: false,
        centerTitle:true,),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              TextFormField(
                controller: emailC,
                focusNode: emailFocus,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.alternate_email),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),

                ),
                onFieldSubmitted: (value){
              Utils.onFcousChange(context, emailFocus, passFocus);

                },

              ),
           const   SizedBox(
                height: 10,
              )
              ,
              ValueListenableBuilder(
                  valueListenable: _notifier, builder: (context,value,child){

                    return TextFormField(
                      controller: passC,
                      focusNode: passFocus,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _notifier.value,
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                        hintText: 'Password',
                        labelText: 'Password',
                        suffixIcon: InkWell(
                            onTap: (){

                                _notifier.value=!_notifier.value;

                            },
                            child: Icon(_notifier.value?Icons.visibility_off:Icons.visibility)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        prefixIcon: Icon(Icons.lock_outline)
                      ),

                    );


              }

              ),
              SizedBox(
                height: height*0.085,
              ),
              RoundButton(title: 'Login',
                  loading: authProvider.loading
                  ,onPress: (){

                if(emailC.text.toString().isEmpty){
                  Utils.snackBar('Enter your email', context);

                }else if(passC.text.toString().isEmpty){
                  Utils.snackBar('Enter your password', context);

                }else if(passC.text.length<6){

                  Utils.snackBar('Length is too short', context);
                }else{
                 // Map data={
                 //   'email':emailC.text.toString(),
                 //   'password':passC.text.toString()
                 // };
                 Map data={
                   'email':'eve.holt@reqres.in',
                   'password':'cityslicka'
                 };




                 authProvider.loginApi(data,context);
                 Utils.toastMessage('Login Succes');

                }


              }),
              SizedBox(
                height: height*0.02
              ),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Text("Don't have an account ? "),
               InkWell(
                 onTap: (){
                   Navigator.pushNamed(context, RoutesName.signUp);

                 },
                 child:  Text('Sign Up ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
               )



             ],
           )


            ],
          ),
        ),
      ),
    );
  }
}

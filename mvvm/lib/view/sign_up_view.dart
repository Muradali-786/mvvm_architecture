 import 'package:flutter/material.dart';
import 'package:mvvm/res/round_button.dart';
import 'package:mvvm/utils/routes/routes_names.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
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
        appBar: AppBar(title: Text('Sign Up View'),
        centerTitle: true,),
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
              RoundButton(title: 'Sign Up',
                  loading: authProvider.signloading
                  ,onPress: (){

                    if(emailC.text.toString().isEmpty){
                      Utils.snackBar('Enter your email', context);

                    }else if(passC.text.toString().isEmpty){
                      Utils.snackBar('Enter your password', context);

                    }else if(passC.text.length<6){

                      Utils.snackBar(' passLength is too short', context);
                    }else{
                      Map data={
                        'email':emailC.text.toString(),
                        'password':passC.text.toString()
                      };

                      authProvider.SignUpApi(data,context);

                    }


                  }),
              SizedBox(
                  height: height*0.02
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Do you have already account ? "),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, RoutesName.login);

                    },
                    child:  Text('Login ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
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

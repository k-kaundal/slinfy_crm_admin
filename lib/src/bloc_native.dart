import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slinfy_crm_admin/src/ui/auth/login.dart';
import 'package:slinfy_crm_admin/src/ui/home/home.dart';
import 'bloc/authentication/authentication_bloc.dart';

class BlocNative extends StatelessWidget {
  const BlocNative({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc,AuthenticationState>(builder: (context,state){
      if(state is AuthenticationSuccess){
        return const Home();
      }else{
        return const Login();
      }
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slinfy_crm_admin/src/ui/auth/login.dart';
import 'package:slinfy_crm_admin/src/ui/home/admin_home.dart';
import 'package:slinfy_crm_admin/src/ui/home/home.dart';
import 'package:slinfy_crm_admin/src/ui/home/hr_home.dart';
import 'package:slinfy_crm_admin/src/ui/home/trainer_home.dart';
import 'package:slinfy_crm_admin/src/utils/constants/commons.dart';
import 'bloc/authentication/authentication_bloc.dart';

class BlocNative extends StatelessWidget {
  const BlocNative({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is AuthenticationSuccess) {
        return state.userType == UserType.ADMIN.name
            ? AdminHome()
            : state.userType == UserType.TRAINER.name
                ? TrainerHome()
                : state.userType == UserType.HR.name
                    ? HRHome()
                    : Login();
        if (state.userType == UserType.ADMIN.name) {
          return AdminHome();
        } else if (state.userType == UserType.TRAINER.name) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const TrainerHome()));
        } else if (state.userType == UserType.HR.name) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HRHome()));
        }
        // return const Home();
      } else {
        return const Login();
      }
    });
  }
}

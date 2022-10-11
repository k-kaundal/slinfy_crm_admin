import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slinfy_crm_admin/src/bloc/authentication/authentication_bloc.dart';
import 'package:slinfy_crm_admin/src/bloc/database/database_bloc.dart';
import 'package:slinfy_crm_admin/src/config/observer/app_bloc_observer.dart';
import 'package:slinfy_crm_admin/src/my_app.dart';
import 'package:slinfy_crm_admin/src/repo/repository/authentication_repository.dart';
import 'package:slinfy_crm_admin/src/repo/repository/database_repository.dart';
import 'package:slinfy_crm_admin/src/utils/constants/commons.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  BlocOverrides.runZoned(
      () => runApp(MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    AuthenticationBloc(AuthenticationRepositoryImpl())
                      ..add(AuthenticationChecking()),
              ),
              BlocProvider(
                create: (context) => DatabaseBloc(DatabaseRepositoryImpl()),
              )
            ],
            child: const MyApp(),
          )),
      blocObserver: AppBlocObserver());
}

//
// void main(){
//   runApp(MyApp());
// }
//
//
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Home(),
//     );
//   }
// }
//
//
// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.deepOrange,
//       child: Container(
//         child: Container(),
//       ),
//     );
//   }
// }
//

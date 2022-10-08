import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slinfy_crm_admin/src/bloc/authentication/authentication_bloc.dart';
import 'package:slinfy_crm_admin/src/repo/service/authentication_service.dart';
import 'package:slinfy_crm_admin/src/repo/service/database_service.dart';
import 'package:slinfy_crm_admin/src/ui/auth/login.dart';
import 'package:slinfy_crm_admin/src/ui/batches/all_batches.dart';
import 'package:slinfy_crm_admin/src/ui/colleges/colleges.dart';
import 'package:slinfy_crm_admin/src/ui/dashboard/dashboard.dart';
import 'package:slinfy_crm_admin/src/ui/duration/durations.dart';
import 'package:slinfy_crm_admin/src/ui/home/admin_home.dart';
import 'package:slinfy_crm_admin/src/ui/home/hr_home.dart';
import 'package:slinfy_crm_admin/src/ui/home/trainer_home.dart';
import 'package:slinfy_crm_admin/src/ui/technology/technology.dart';
import 'package:slinfy_crm_admin/src/ui/users/add_user.dart';
import 'package:slinfy_crm_admin/src/ui/users/users.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:slinfy_crm_admin/src/utils/constants/commons.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isUser = false;
  int index = 0;
  List<String> titleList = [
    'Dashboard',
    'Users',
    'Batches',
    'Colleges',
    'Technology',
    'Durations'
  ];
  List<Widget> widgetList = [
    Dashboard(),
    Users(),
    AllBatches(),
    Colleges(),
    Technology(),
    Durations()
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (BuildContext context, state) {
        print('$state state of page' );

        if (state is AuthenticationFailure) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Login()));
        }else if (state is AuthenticationInitial) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Login()));
        }else if(state is AuthenticationSuccess){
          if(state.userType == UserType.ADMIN.name){
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const AdminHome()));
          }else if(state.userType == UserType.TRAINER.name){
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const TrainerHome()));
          }else if(state.userType == UserType.HR.name){
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HRHome()));
          }
        }
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(titleList[index]),
        ),
        drawer: Drawer(
          // backgroundColor: Colors.deepPurple,
          child: Container(
            height: size.height,
            width: size.width,
            child: ListView(
              children: [
                Container(
                  height: 150,
                  width: size.width,
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    setState(() {
                      index = 0;
                      Navigator.pop(context);
                    });
                  },
                  leading: Icon(
                    Icons.dashboard,
                    color: Colors.orange,
                  ),
                  title: Text(
                    'Dashboard',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      index = 1;
                      Navigator.pop(context);
                    });
                  },
                  leading: Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  title: Text(
                    'Users',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      index = 2;
                      Navigator.pop(context);
                    });
                  },
                  leading: Icon(
                    Icons.batch_prediction,
                    color: Colors.deepPurple,
                  ),
                  title: Text(
                    'Batches',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      index = 3;
                      Navigator.pop(context);
                    });
                  },
                  leading: Icon(
                    Icons.home_repair_service_outlined,
                    color: Colors.green,
                  ),
                  title: Text(
                    'Colleges',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      index = 4;
                      Navigator.pop(context);
                    });
                  },
                  leading: Icon(
                    Icons.military_tech,
                    color: Colors.lightBlue,
                  ),
                  title: Text(
                    'Technology',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      index = 5;
                      Navigator.pop(context);
                    });
                  },
                  leading: Icon(
                    Icons.timer,
                    color: Colors.blue,
                  ),
                  title: Text(
                    'Durations',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            alignment: Alignment.center,
                            actionsAlignment: MainAxisAlignment.spaceEvenly,
                            // elevation: 3,
                            title:
                                Text('Do you want to exit this application?'),
                            content: Text('We hate to see you leave...'),
                            // icon: Icon(Icons.info_outline),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    context.read<AuthenticationBloc>().add(AuthenticationSignedOut());
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => Login()));
                                  },
                                  child: Text('Yes')),
                              ElevatedButton(
                                  onPressed: () {
                                   Navigator.of(context).pop();
                                  }, child: Text('No'))
                            ],
                          );
                        },
                      );
                    });
                  },
                  leading: Icon(
                    Icons.info_outline,
                    color: Colors.red,
                  ),
                  title: Text(
                    'Log Out',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: widgetList[index],
        ),
      ),
    );
  }
}

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

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
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
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 430) {
          print("430");
          return Scaffold(
            // resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(titleList[index]),
            ),
            drawer: Drawer(
              // backgroundColor: Colors.deepPurple,
              child: SizedBox(
                height: size.height,
                width: size.width,
                child: ListView(
                  children: [
                    Container(
                      height: 100,
                      width: size.width,
                      child: Center(
                          child: Text(
                        'Admin Home',
                        style: TextStyle(
                            fontSize: 22, fontStyle: FontStyle.italic),
                      )),
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
                                title: Text(
                                    'Do you want to exit this application?'),
                                content: Text('We hate to see you leave...'),
                                // icon: Icon(Icons.info_outline),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<AuthenticationBloc>()
                                            .add(AuthenticationSignedOut());
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) => Login()));
                                      },
                                      child: Text('Yes')),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('No'))
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
          );
        } else if (constraints.maxWidth >= 430 && constraints.maxWidth <= 830) {
          print("830");
          return Scaffold(
            body: Container(
              height: size.height,
              width: size.width,
              child: Row(
                children: [
                  Drawer(
                    width: 200,
                    elevation: 5,
                    // backgroundColor: Colors.deepPurple,
                    child: SizedBox(
                      height: size.height,
                      width: size.width,
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 100,
                            width: size.width,
                            child: Center(
                                child: Text(
                              'Admin Home',
                              style: TextStyle(
                                  fontSize: 22, fontStyle: FontStyle.italic),
                            )),
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
                                      actionsAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      // elevation: 3,
                                      title: Text(
                                          'Do you want to exit this application?'),
                                      content:
                                          Text('We hate to see you leave...'),
                                      // icon: Icon(Icons.info_outline),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              context
                                                  .read<AuthenticationBloc>()
                                                  .add(
                                                      AuthenticationSignedOut());
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Login()));
                                            },
                                            child: Text('Yes')),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('No'))
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
                  SizedBox(
                    height: size.height,
                    width: size.width - 150,
                    child: widgetList[index],
                  ),
                ],
              ),
            ),
          );
        } else {
          print("desktop");
          return Scaffold(
            body: Container(
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  Container(
                    height: 150,
                    child: Column(
                      children: [
                        // Container(),
                        Row(
                          children: [
                            OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    index = 0;
                                    Navigator.pop(context);
                                  });
                                },
                                child: Text('Dashboard')),
                            OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    index = 1;
                                    Navigator.pop(context);
                                  });
                                },
                                child: Text('User')),
                            OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    index = 0;
                                    Navigator.pop(context);
                                  });
                                },
                                child: Text('Batches')),
                            OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    index = 0;
                                    Navigator.pop(context);
                                  });
                                },
                                child: Text('College')),
                            OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    index = 0;
                                    Navigator.pop(context);
                                  });
                                },
                                child: Text('Dashboard'))
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: size.height - 150,
                    width: size.width,
                    child: widgetList[index],
                  ),
                  // Row(
                  //   children: [
                  //     Container(
                  //       height: size.height,
                  //       width: 200,
                  //       child: Drawer(
                  //         elevation: 5,
                  //         // backgroundColor: Colors.deepPurple,
                  //         child: Container(
                  //           height: size.height,
                  //           width: size.width,
                  //           child: ListView(
                  //             children: [
                  //               Container(
                  //                 height: 150,
                  //                 width: size.width,
                  //                 child: Center(
                  //                     child: Text(
                  //                   'Admin Home',
                  //                   style: TextStyle(
                  //                       fontSize: 22,
                  //                       fontStyle: FontStyle.italic),
                  //                 )),
                  //               ),
                  //               Divider(),
                  //               ListTile(
                  //                 onTap: () {
                  //                   setState(() {
                  //                     index = 0;
                  //                     Navigator.pop(context);
                  //                   });
                  //                 },
                  //                 leading: Icon(
                  //                   Icons.dashboard,
                  //                   color: Colors.orange,
                  //                 ),
                  //                 title: Text(
                  //                   'Dashboard',
                  //                   style: TextStyle(fontSize: 20),
                  //                 ),
                  //               ),
                  //               ListTile(
                  //                 onTap: () {
                  //                   setState(() {
                  //                     index = 1;
                  //                     Navigator.pop(context);
                  //                   });
                  //                 },
                  //                 leading: Icon(
                  //                   Icons.person,
                  //                   color: Colors.blue,
                  //                 ),
                  //                 title: Text(
                  //                   'Users',
                  //                   style: TextStyle(fontSize: 20),
                  //                 ),
                  //               ),
                  //               ListTile(
                  //                 onTap: () {
                  //                   setState(() {
                  //                     index = 2;
                  //                     Navigator.pop(context);
                  //                   });
                  //                 },
                  //                 leading: Icon(
                  //                   Icons.batch_prediction,
                  //                   color: Colors.deepPurple,
                  //                 ),
                  //                 title: Text(
                  //                   'Batches',
                  //                   style: TextStyle(fontSize: 20),
                  //                 ),
                  //               ),
                  //               ListTile(
                  //                 onTap: () {
                  //                   setState(() {
                  //                     index = 3;
                  //                     Navigator.pop(context);
                  //                   });
                  //                 },
                  //                 leading: Icon(
                  //                   Icons.home_repair_service_outlined,
                  //                   color: Colors.green,
                  //                 ),
                  //                 title: Text(
                  //                   'Colleges',
                  //                   style: TextStyle(fontSize: 20),
                  //                 ),
                  //               ),
                  //               ListTile(
                  //                 onTap: () {
                  //                   setState(() {
                  //                     index = 4;
                  //                     Navigator.pop(context);
                  //                   });
                  //                 },
                  //                 leading: Icon(
                  //                   Icons.military_tech,
                  //                   color: Colors.lightBlue,
                  //                 ),
                  //                 title: Text(
                  //                   'Technology',
                  //                   style: TextStyle(fontSize: 20),
                  //                 ),
                  //               ),
                  //               ListTile(
                  //                 onTap: () {
                  //                   setState(() {
                  //                     index = 5;
                  //                     Navigator.pop(context);
                  //                   });
                  //                 },
                  //                 leading: Icon(
                  //                   Icons.timer,
                  //                   color: Colors.blue,
                  //                 ),
                  //                 title: Text(
                  //                   'Durations',
                  //                   style: TextStyle(fontSize: 20),
                  //                 ),
                  //               ),
                  //               ListTile(
                  //                 onTap: () {
                  //                   setState(() {
                  //                     showDialog(
                  //                       context: context,
                  //                       builder: (BuildContext context) {
                  //                         return AlertDialog(
                  //                           alignment: Alignment.center,
                  //                           actionsAlignment:
                  //                               MainAxisAlignment.spaceEvenly,
                  //                           // elevation: 3,
                  //                           title: Text(
                  //                               'Do you want to exit this application?'),
                  //                           content: Text(
                  //                               'We hate to see you leave...'),
                  //                           // icon: Icon(Icons.info_outline),
                  //                           actions: [
                  //                             ElevatedButton(
                  //                                 onPressed: () {
                  //                                   context
                  //                                       .read<
                  //                                           AuthenticationBloc>()
                  //                                       .add(
                  //                                           AuthenticationSignedOut());
                  //                                   Navigator.of(context)
                  //                                       .pushReplacement(
                  //                                           MaterialPageRoute(
                  //                                               builder:
                  //                                                   (context) =>
                  //                                                       Login()));
                  //                                 },
                  //                                 child: Text('Yes')),
                  //                             ElevatedButton(
                  //                                 onPressed: () {
                  //                                   Navigator.of(context).pop();
                  //                                 },
                  //                                 child: Text('No'))
                  //                           ],
                  //                         );
                  //                       },
                  //                     );
                  //                   });
                  //                 },
                  //                 leading: Icon(
                  //                   Icons.info_outline,
                  //                   color: Colors.red,
                  //                 ),
                  //                 title: Text(
                  //                   'Log Out',
                  //                   style: TextStyle(fontSize: 20),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

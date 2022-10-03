import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slinfy_crm_admin/src/models/user_model.dart';
import 'package:slinfy_crm_admin/src/repo/service/authentication_service.dart';
import 'package:slinfy_crm_admin/src/repo/service/database_service.dart';
import 'package:slinfy_crm_admin/src/ui/commons/app_background.dart';
import 'package:slinfy_crm_admin/src/utils/constants/commons.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  String userType = '';
  bool isHR = false;
  bool isTrainer = false;
  bool isTrainee = false;
  List selectedTechnology = [];

  @override
  void initState() {
    // TODO: implement initState
    userType = UserType.TRAINEE.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 850) {
        return Scaffold(
            // resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text('Add User'),
            ),
            body: Stack(children: [
              // AppBackground(),
              SizedBox(
                height: size.height,
                width: size.width,
                child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: addUserScreen(size)),
              ),
            ]));
      } else {
        return Container(
          height: size.height,
          width: size.width,
          // child: addUserScreen(),
        );
      }
    });
  }

  Widget addUserScreen(Size size) {
    return ListView(
      children: [
        SizedBox(
          height: 16,
        ),
        TextFormField(
          controller: name,
          decoration: InputDecoration(
              hintText: 'Name', filled: true, border: InputBorder.none),
        ),
        SizedBox(
          height: 16,
        ),
        TextFormField(
          controller: email,
          decoration: InputDecoration(
              hintText: 'Email', filled: true, border: InputBorder.none),
        ),
        SizedBox(
          height: 16,
        ),
        // TextFormField(
        //   decoration: InputDecoration(
        //       hintText: 'Father Name', filled: true, border: InputBorder.none),
        // ),
        // SizedBox(
        //   height: 16,
        // ),
        // TextFormField(
        //   decoration: InputDecoration(
        //       hintText: 'Mother Name', filled: true, border: InputBorder.none),
        // ),
        // SizedBox(
        //   height: 16,
        // ),
        TextFormField(
          controller: phone,
          decoration: InputDecoration(
              hintText: 'Phone', filled: true, border: InputBorder.none),
        ),
        SizedBox(
          height: 16,
        ),

        Container(
          color: Colors.black12,
          child: Row(children: [
            Expanded(
                flex: 3,
                child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('User Type'))),
            Expanded(
              flex: 7,
              child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                value: userType,
                items: [
                  DropdownMenuItem(
                      value: UserType.ADMIN.name,
                      child: Text(UserType.ADMIN.name)),
                  DropdownMenuItem(
                      value: UserType.HR.name, child: Text(UserType.HR.name)),
                  DropdownMenuItem(
                      value: UserType.TRAINER.name,
                      child: Text(UserType.TRAINER.name)),
                  DropdownMenuItem(
                      value: UserType.TRAINEE.name,
                      child: Text(UserType.TRAINEE.name)),
                ],
                onChanged: (String? value) {
                  setState(() {
                    userType = value.toString();
                    if (value == UserType.HR.name) {
                      isHR = true;
                      isTrainer = false;
                      isTrainee = false;
                    } else if (value == UserType.TRAINER.name) {
                      isHR = false;
                      isTrainer = true;
                      isTrainee = false;
                    } else if (value == UserType.TRAINEE.name) {
                      isHR = false;
                      isTrainer = false;
                      isTrainee = true;
                    } else {
                      isHR = false;
                      isTrainer = false;
                      isTrainee = false;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(value.toString())));
                  });
                },
              )),
            ),
          ]),
        ),

        // Trainer

        Visibility(
            visible: isTrainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'ID', filled: true, border: InputBorder.none),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  color: Theme.of(context).inputDecorationTheme.fillColor,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                _showMultiSelectTechnology(context);
                              });
                            },
                            child: Container(
                                color: Colors.black12,
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Technology'),
                                          Icon(Icons.ads_click)
                                        ])))),
                        Container(
                          width: size.width,
                          // height: 50,
                          child: Wrap(
                            children: List.generate(
                                selectedTechnology.length,
                                (index) => Padding(
                                      padding:
                                          EdgeInsets.only(left: 5, right: 5),
                                      child: Chip(
                                          padding: EdgeInsets.only(
                                              left: 5, right: 5),
                                          label: Text(selectedTechnology[index]
                                              .toString())),
                                    )),
                          ),
                        )
                      ]),
                ),
              ],
            )),

        // Trainee

        Visibility(
            visible: isTrainee,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(
                //   height: 16,
                // ),
                // TextFormField(
                //   decoration: InputDecoration(
                //       hintText: 'ID', filled: true, border: InputBorder.none),
                // ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  color: Theme.of(context).inputDecorationTheme.fillColor,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                _showMultiSelectTechnology(context);
                              });
                            },
                            child: Container(
                                color: Colors.black12,
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Technology'),
                                          Icon(Icons.ads_click)
                                        ])))),
                        Container(
                          width: size.width,
                          // height: 50,
                          child: Wrap(
                            children: List.generate(
                                selectedTechnology.length,
                                (index) => Padding(
                                      padding:
                                          EdgeInsets.only(left: 5, right: 5),
                                      child: Chip(
                                          padding: EdgeInsets.only(
                                              left: 5, right: 5),
                                          label: Text(selectedTechnology[index]
                                              .toString())),
                                    )),
                          ),
                        )
                      ]),
                ),
              ],
            )),

        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(onPressed: () {}, child: Text("Clear")),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (name.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Enter Email ID')));
                      return;
                    } else if (email.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Enter Email ID')));
                      return;
                    }else if (phone.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Enter Email ID')));
                      return;
                    }else{
                      UserModel userModel = UserModel(password:'123456',displayName: name.text.trim(),email: email.text.trim(),phone: phone.text.trim(),userType: userType.trim(),);
                      AuthenticationService().signUp(userModel).whenComplete(() async {
                      await DatabaseService().addUserData(userModel);
                      AuthenticationService().reSignIn();
                      Navigator.of(context).pop();
                      });

                    }
                  });
                },
                child: Text("Submitted"))
          ],
        )
      ],
    );
  }

  void _showMultiSelectTechnology(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return StreamBuilder(
          stream: DatabaseService().getBasicData(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Container();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            } else if (snapshot.data == null) {
              return Container();
            } else {
              // print(snapshot.data!.data());
              List data = snapshot.data?.get('Technology');
              return MultiSelectDialog(
                items: List.generate(data.length,
                    (index) => MultiSelectItem(data[index], data[index])),
                initialValue: [],
                onConfirm: (values) {
                  setState(() {
                    selectedTechnology.clear();
                    selectedTechnology.addAll(values);
                  });
                },
              );
            }
          },
        );
      },
    );
  }

  void _showMultiSelectColleges(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return StreamBuilder(
          stream: DatabaseService().getBasicData(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Container();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }
            // else if (snapshot.data == null) {
            //   return Container();
            // }
            else {
              // print(snapshot.data!.data());
              List data = snapshot.data?.get('Technology');
              return MultiSelectDialog(
                items: List.generate(data.length,
                    (index) => MultiSelectItem(data[index], data[index])),
                initialValue: [],
                onConfirm: (values) {},
              );
            }
          },
        );
      },
    );
  }
}

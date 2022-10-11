import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:slinfy_crm_admin/src/models/user_model.dart';
import 'package:slinfy_crm_admin/src/repo/service/authentication_service.dart';
import 'package:slinfy_crm_admin/src/repo/service/database_service.dart';
import 'package:slinfy_crm_admin/src/ui/commons/app_background.dart';
import 'package:slinfy_crm_admin/src/utils/constants/commons.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:intl/intl.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController fatherName = TextEditingController();
  TextEditingController totalFee = TextEditingController();
  TextEditingController registrationFee = TextEditingController();
  TextEditingController dueFee = TextEditingController();
  TextEditingController pendingFee = TextEditingController();

  // TextEditingController college = TextEditingController();
  String userType = '';
  bool isHR = false;
  bool isTrainer = false;
  bool isTrainee = true;
  List selectedTechnology = [];
  String? joiningDate = Commons.getDate();
  String? nextDueDate = Commons.getDate();
  String college = 'Select College';
  String durations = 'Select Duration';
  bool isPendingFee = false;

  // bool isCollege = false;

  @override
  void initState() {
    // TODO: implement initState
    userType = UserType.TRAINEE.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              label: Text('Name'),
              hintText: 'John',
              filled: true,
              border: InputBorder.none),
        ),
        SizedBox(
          height: 16,
        ),
        TextFormField(
          controller: email,
          decoration: InputDecoration(
              label: Text('Email'),
              hintText: 'email@gmail.com',
              filled: true,
              border: InputBorder.none),
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
              label: Text('Phone'),
              hintText: '+91 1234567890',
              filled: true,
              border: InputBorder.none),
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
                  controller: id,
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
                TextFormField(
                  controller: fatherName,
                  decoration: InputDecoration(
                      label: Text('Father Name'),
                      hintText: 'King Jhon',
                      filled: true,
                      border: InputBorder.none),
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
                                _showSelectColleges(context);
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
                                          Text('College: $college'),
                                          Icon(Icons.ads_click)
                                        ])))),
                        // Visibility(
                        //   visible: isCollege,
                        //   child: Container(
                        //       width: size.width,
                        //       // height: 50,
                        //       child: Chip(
                        //         padding: EdgeInsets.only(left: 5, right: 5),
                        //         label: Text(college),
                        //       )),
                        // )
                      ]),
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
                                _showSelectDuration(context);
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
                                          Text('Duration: $durations'),
                                          Icon(Icons.ads_click)
                                        ])))),
                        // Visibility(
                        //   visible: isCollege,
                        //   child: Container(
                        //       width: size.width,
                        //       // height: 50,
                        //       child: Chip(
                        //         padding: EdgeInsets.only(left: 5, right: 5),
                        //         label: Text(college),
                        //       )),
                        // )
                      ]),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: totalFee,
                  decoration: InputDecoration(
                      label: Text('Total Fee'),
                      hintText: '12000.00',
                      filled: true,
                      border: InputBorder.none),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: registrationFee,
                  onChanged: (val){
                    setState(() {
                      pendingFee.text = (int.parse(totalFee.text)-int.parse(registrationFee.text)).toDouble().toString();
                          // -int.parse(dueFee.text)).toDouble().toString();
                    });
                  },
                  decoration: InputDecoration(
                      label: Text('Registration Fee'),
                      hintText: '00.0',
                      filled: true,
                      border: InputBorder.none),
                ),
                // SizedBox(
                //   height: 16,
                // ),
                // TextFormField(
                //   controller: dueFee,
                //   decoration: InputDecoration(
                //       label: Text('Due Fee'),
                //       hintText: '00.0',
                //       filled: true,
                //       border: InputBorder.none),
                // ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  enabled: isPendingFee,
                  controller: pendingFee,
                  decoration: InputDecoration(
                      label: Text('Pending Fee'),
                      hintText: '00.0',
                      filled: true,
                      border: InputBorder.none),
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
                                _nextDueDateDialog(context);
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
                                          Text('Next Due Date: $nextDueDate'),
                                          Icon(Icons.ads_click)
                                        ])))),
                        // Visibility(
                        //   visible: isCollege,
                        //   child: Container(
                        //       width: size.width,
                        //       // height: 50,
                        //       child: Chip(
                        //         padding: EdgeInsets.only(left: 5, right: 5),
                        //         label: Text(college),
                        //       )),
                        // )
                      ]),
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
                                _joiningDateDialog(context);
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
                                          Text('Joining Date: $joiningDate'),
                                          Icon(Icons.ads_click)
                                        ])))),
                        // Visibility(
                        //   visible: isCollege,
                        //   child: Container(
                        //       width: size.width,
                        //       // height: 50,
                        //       child: Chip(
                        //         padding: EdgeInsets.only(left: 5, right: 5),
                        //         label: Text(college),
                        //       )),
                        // )
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
            ElevatedButton(onPressed: () {}, child: const Text("Clear")),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (name.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Enter Name')));
                      return;
                    } else if (email.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Enter Email ID')));
                      return;
                    } else if (phone.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Enter Phone')));
                      return;
                    } else {
                      if (userType == UserType.ADMIN.name) {
                        UserModel userModel = UserModel(
                          password: '123456',
                          displayName: name.text.trim(),
                          email: email.text.trim(),
                          phone: phone.text.trim(),
                          userType: userType.trim(),
                        );
                        AuthenticationService()
                            .signUp(userModel)
                            .whenComplete(() async {
                          await DatabaseService().addUserData(userModel);
                          AuthenticationService().reSignIn();
                        });
                      } else if (userType == UserType.HR.name) {
                        HRModel hrModel = HRModel();
                        UserModel userModel = UserModel(
                          hrModel: hrModel,
                          password: '123456',
                          displayName: name.text.trim(),
                          email: email.text.trim(),
                          phone: phone.text.trim(),
                          userType: userType.trim(),
                        );
                        AuthenticationService()
                            .signUp(userModel)
                            .whenComplete(() async {
                          await DatabaseService().addUserData(userModel);
                          AuthenticationService().reSignIn();
                        });
                      } else if (userType == UserType.TRAINER.name) {
                        TrainerModel trainerModel = TrainerModel(
                            id: id.text.trim().toUpperCase(),
                            technology: selectedTechnology.toList());
                        UserModel userModel = UserModel(
                          trainerModuleMap: trainerModel.toMap(),
                          password: '123456',
                          displayName: name.text.trim(),
                          email: email.text.trim(),
                          phone: phone.text.trim(),
                          userType: userType.trim(),
                        );
                        AuthenticationService()
                            .signUp(userModel)
                            .whenComplete(() async {
                          await DatabaseService().addUserData(userModel);
                          AuthenticationService().reSignIn();
                        });
                      } else if (userType == UserType.TRAINEE.name) {
                        FeeDetailsModel feeDetailsModel = FeeDetailsModel(
                          // dueFee: dueFee.text.trim(),
                          totalFee: totalFee.text.trim(),
                          pendingFee: pendingFee.text.trim(),
                          registrationFee: registrationFee.text.trim(),
                        );
                        TraineeModel traineeModel = TraineeModel(
                            technology: selectedTechnology,
                            college: college,
                            email: email.text.trim(),
                            name: name.text.trim(),
                            feeDetailsModelMap: feeDetailsModel.toMap(),
                            enrollmentDate: Commons.getDate());

                        UserModel userModel = UserModel(
                          traineeModel: traineeModel,
                          password: '123456',
                          displayName: name.text.trim(),
                          email: email.text.trim(),
                          phone: phone.text.trim(),
                          userType: userType.trim(),
                        );
                        AuthenticationService()
                            .signUp(userModel)
                            .whenComplete(() async {
                          await DatabaseService().addUserData(userModel);
                          AuthenticationService().reSignIn();
                        });
                      }
                      Navigator.of(context).pop();
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

  void _showSelectColleges(BuildContext context) async {
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
              print(snapshot.data!.data());
              List data = snapshot.data?.get('Colleges');
              return MultiSelectDialog(
                items: List.generate(data.length,
                    (index) => MultiSelectItem(data[index], data[index])),
                initialValue: [],
                onConfirm: (values) {
                  setState(() {
                    college = values[0];
                    // if (college.text.isNotEmpty) {
                    //   isCollege = true;
                    // } else {
                    //   isCollege = false;
                    // }
                  });
                },
              );
            }
          },
        );
      },
    );
  }

  void _showSelectDuration(BuildContext context) async {
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
              List data = snapshot.data?.get('Durations');
              return MultiSelectDialog(
                items: List.generate(data.length,
                    (index) => MultiSelectItem(data[index], data[index])),
                initialValue: [],
                onConfirm: (values) {
                  setState(() {
                    durations = values[0];
                    // if (college.text.isNotEmpty) {
                    //   isCollege = true;
                    // } else {
                    //   isCollege = false;
                    // }
                  });
                },
              );
            }
          },
        );
      },
    );
  }

  Future<void> _nextDueDateDialog(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        nextDueDate = DateFormat('dd/MM/yy').format(picked);
      });
    }
  }

  Future<void> _joiningDateDialog(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        joiningDate = DateFormat('dd/MM/yy').format(picked);
      });
    }
  }

// void _joiningDateDialog(BuildContext context) {
//   showDatePicker(
//       context: context,
//       initialDate: DateTime(2022),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2030),);
// }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slinfy_crm_admin/src/models/user_model.dart';
import 'package:slinfy_crm_admin/src/repo/service/database_service.dart';
import 'package:slinfy_crm_admin/src/ui/commons/app_background.dart';
import 'package:slinfy_crm_admin/src/ui/users/add_user.dart';

class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(children: [
        // AppBackground(),
        Container(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: size.width,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: TextField(
                            onChanged: (v) {
                              setState(() {});
                            },
                            controller: name,
                            decoration: InputDecoration(
                                hintText: 'Search.....',
                                filled: true,
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    height: size.height - 187,
                    width: size.width,
                    child: StreamBuilder(
                        stream: DatabaseService().getUsers(name.text.trim()),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Container();
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container();
                          } else if (snapshot.data!.docs.isEmpty) {
                            return Container();
                          } else {
                            // print(snapshot.data!.data());
                            List<QueryDocumentSnapshot> data =
                                snapshot.data!.docs;
                            return Container(
                              height: size.height,
                              width: size.width,
                              child: Column(children: [
                                Padding(
                                  padding:
                                  EdgeInsets.only(left: 20, right: 20),
                                  child: Table(
                                      children: const [
                                    TableRow(children: [
                                      Text('Sr.No.'),
                                      Text('Name'),
                                      Text('ID'),
                                      Text('Phone'),
                                      Text('User Type')
                                    ])
                                  ]),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Table(children: [
                                          TableRow(children: [
                                            Text('${index+1}.'),
                                            Text(data[index]
                                                    ['displayName']
                                                .toString()),
                                            Text(data[index]['uid']
                                                .toString()),
                                            Text(data[index]['phone']
                                                .toString()),
                                            Text(data[index]['userType']
                                                .toString())
                                          ])
                                        ]),
                                      ),
                                    );
                                  },
                                ),
                              ]),
                            );
                          }
                        }))
              ],
            ),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddUser()));
        },
        label: Text('Add'),
        icon: Icon(Icons.add),
      ),
    );
  }
}

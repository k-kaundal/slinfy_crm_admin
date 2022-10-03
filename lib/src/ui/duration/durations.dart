import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slinfy_crm_admin/src/repo/service/database_service.dart';
class Durations extends StatefulWidget {
  const Durations({Key? key}) : super(key: key);

  @override
  State<Durations> createState() => _DurationsState();
}

class _DurationsState extends State<Durations> {
  TextEditingController duration = TextEditingController();
  List durationList = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
          children:[
            // AppBackground(),
            Container(
              height: size.height,
              width: size.width,
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
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
                                controller: duration,
                                decoration: InputDecoration(
                                    hintText: 'Duration',
                                    filled: true, border: InputBorder.none),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (duration.text.isEmpty) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                                content: Text("Enter batch name")));
                                      } else {
                                        Set set = durationList.toSet();
                                        set.add(duration.text.trim().toUpperCase());
                                        set.add(duration.text.trim().toUpperCase());
                                        durationList = set.toList();
                                        set.clear();
                                        DatabaseService().addDurations(durationList);
                                        duration.clear();
                                      }
                                    });
                                  },
                                  child: Text("Add"),
                                ),
                              ))
                        ],
                      ),
                    ),
                    Container(
                        height: size.height - 187,
                        width: size.width,
                        child: StreamBuilder(
                            stream: DatabaseService().getBasicData(),
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Container();
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container();
                              } else if (!snapshot.data!.exists) {
                                return Container();
                              } else {
                                // print(snapshot.data!.data());
                                durationList.clear();
                                durationList = snapshot.data!.get('Durations');
                                return ListView.builder(
                                  itemCount: durationList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.only(left: 20, right: 20),
                                      child: Card(
                                        elevation: 0,
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Container(
                                              width: size.width,
                                              child: Text('${(index+1)}. '+durationList[index])),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            }))
                  ],
                ),
              ),
            ),
          ]),
    );
  }
}

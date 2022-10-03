import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slinfy_crm_admin/src/repo/service/database_service.dart';
class Technology extends StatefulWidget {
  const Technology({Key? key}) : super(key: key);

  @override
  State<Technology> createState() => _TechnologyState();
}

class _TechnologyState extends State<Technology> {
  TextEditingController technology = TextEditingController();
  List technologyList = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 850) {
        return Container(
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
                            controller: technology,
                            decoration: InputDecoration(
                                hintText: 'Technology Name',
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
                                  if (technology.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text("Enter Technology name")));
                                  } else {
                                    Set set = technologyList.toSet();
                                    set.add(technology.text.trim());
                                    set.add(technology.text.trim());
                                    technologyList = set.toList();
                                    set.clear();
                                    DatabaseService().addTechnology(technologyList);
                                    technology.clear();
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
                            technologyList.clear();
                            technologyList = snapshot.data!.get('Technology');
                            return ListView.builder(
                              itemCount: technologyList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Card(
                                    elevation: 0,
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Container(
                                          width: size.width,
                                          child: Text('${(index+1)}. '+technologyList[index])),
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
        );
      } else {
        return Container(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Container(
                height: 100,
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(flex: 7, child: TextField()),
                    Expanded(
                        flex: 3,
                        child: ElevatedButton(
                            onPressed: () {}, child: Text("Add")))
                  ],
                ),
              ),
              Container(
                height: size.height - 132,
                width: size.width,
              )
            ],
          ),
        );
      }
    });
  }
}

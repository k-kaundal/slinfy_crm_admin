import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slinfy_crm_admin/src/repo/service/database_service.dart';
class Colleges extends StatefulWidget {
  const Colleges({Key? key}) : super(key: key);

  @override
  State<Colleges> createState() => _CollegesState();
}

class _CollegesState extends State<Colleges> {
  TextEditingController college = TextEditingController();
  List collegeList = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Container(
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
                        controller: college,
                        decoration: InputDecoration(
                            hintText: 'College Name',
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
                              if (college.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("Enter College name")));
                              } else {
                                Set set = collegeList.toSet();
                                set.add(college.text.trim());
                                set.add(college.text.trim());
                                collegeList = set.toList();
                                set.clear();

                                DatabaseService().addCollege(collegeList);
                                college.clear();

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
                        collegeList.clear();
                        collegeList = snapshot.data!.get('Colleges');
                        return ListView.builder(
                          itemCount: collegeList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Card(
                                elevation: 0,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                      width: size.width,
                                      child: Text('${(index+1)}. '+collegeList[index])),
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
  }
}

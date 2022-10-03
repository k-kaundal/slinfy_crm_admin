import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slinfy_crm_admin/src/repo/service/database_service.dart';
import 'package:slinfy_crm_admin/src/ui/commons/app_background.dart';

class AllBatches extends StatefulWidget {
  const AllBatches({Key? key}) : super(key: key);

  @override
  State<AllBatches> createState() => _AllBatchesState();
}

class _AllBatchesState extends State<AllBatches> {
  TextEditingController batch = TextEditingController();
  List batchList = [];

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
                            controller: batch,
                            decoration: InputDecoration(
                                hintText: 'Batch Name',
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
                                  if (batch.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text("Enter batch name")));
                                  } else {
                                    Set set = batchList.toSet();
                                    set.add(batch.text.trim().toUpperCase());
                                    set.add(batch.text.trim().toUpperCase());
                                    batchList = set.toList();
                                    set.clear();
                                    DatabaseService().addBatches(batchList);
                                    batch.clear();
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
                            batchList.clear();
                            batchList = snapshot.data!.get('Batches');
                            return ListView.builder(
                              itemCount: batchList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Card(
                                    elevation: 0,
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Container(
                                          width: size.width,
                                          child: Text('${(index+1)}. '+batchList[index])),
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

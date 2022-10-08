import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:slinfy_crm_admin/src/utils/constants/commons.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  List<GridModel> gridList = [
    GridModel(text: 'Admin : 5', imageUrl:'https://img.lovepik.com/element/45010/1988.png_300.png' ),
    GridModel(text: 'HR: 34', imageUrl: 'https://w7.pngwing.com/pngs/25/431/png-transparent-human-resource-management-system-็hr-text-photography-human-resource-management.png'),
    GridModel(text: 'Students : 5', imageUrl:'https://cdn-icons-png.flaticon.com/512/219/219983.png' ),
    GridModel(text: 'Trainer : 50', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShSD5OlJ5C4v32c9Ms0ILC4yK8Jzf-Bu-u8guF1U04UwYjJ9QWqpkj-jZFArG1wZmXlZQ&usqp=CAU'),
    GridModel(text: 'Batches : 5', imageUrl:'https://e7.pngegg.com/pngimages/776/362/png-clipart-id3-macbook-pro-macos-music-composers-organization-orange-batch-processing.png' ),
    GridModel(text: 'College: 40', imageUrl: 'https://i.pinimg.com/originals/f4/b2/e9/f4b2e9d31c338e7bc4efd5c83f5af10f.png'),
    GridModel(text: 'Technology: 40', imageUrl: 'https://e7.pngegg.com/pngimages/13/921/png-clipart-connecting-application-icons-information-technology-computer-icons-information-and-communications-technology-technology-computer-network-electronics.png'),
    GridModel(text: 'Technology: 40', imageUrl: ''),
    GridModel(text: 'College: 40', imageUrl: ''),
    GridModel(text: 'College: 40', imageUrl: '')
  ];
  @override
  Widget build(BuildContext context) {
    // final List box = Commons().getBoxData();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          Container(
            height: size.height * 0.25,
            width: size.width,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          'https://img.freepik.com/premium-vector/man-with-laptop-studying-working-concept_113065-167.jpg?w=2000',
                        ),
                        fit: BoxFit.cover)),
                height: size.height * 0.18,
                width: size.width * 0.9,
              ),
            ),
          ),
          Container(
            height: size.height * 0.65,
            width: size.width,
            child: GridView.builder(
              itemCount: gridList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                            image: NetworkImage(
                              'https://img.freepik.com/free-vector/white-abstract-background_23-2148810113.jpg',
                            ),
                            fit: BoxFit.cover)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Container(
                            height: size.height*0.06,
                            child: Image.network(gridList[index].imageUrl
                            ,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(gridList[index].text),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}


class GridModel {
  String imageUrl;
  String text;
  GridModel({required this.text,required this.imageUrl});
}

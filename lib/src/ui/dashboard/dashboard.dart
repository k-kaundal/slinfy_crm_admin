import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:slinfy_crm_admin/src/utils/constants/app_images.dart';
import 'package:slinfy_crm_admin/src/utils/constants/commons.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<GridModel> gridList = [
    GridModel(
        text: 'Admin : 5',
        imageUrl:
            'https://i.pinimg.com/originals/94/09/7e/94097e458fbb22184941be57aaab2c8f.png'),
    GridModel(
        text: 'HR: 34',
        imageUrl:
            'https://thoughtsaroundwethepeople.files.wordpress.com/2017/09/ciel-blog-evaluate-staffing-partner.png'),
    GridModel(
        text: 'Students : 5',
        imageUrl:
            'https://img.freepik.com/free-vector/focused-tiny-people-reading-books_74855-5836.jpg'),
    GridModel(
        text: 'Trainer : 50',
        imageUrl:
            'https://img.freepik.com/free-vector/web-development-programmer-engineering-coding-website-augmented-reality-interface-screens-developer-project-engineer-programming-software-application-design-cartoon-illustration_107791-3863.jpg'),
    GridModel(
        text: 'Batches : 5',
        imageUrl:
            'https://tutoratti.com/uploads/courses/thumbnail/2022/mar/01/thumb_8a0697caba8c0c54cb44dff594b52921.jpg'),
    GridModel(
        text: 'College: 40',
        imageUrl:
            'https://st2.depositphotos.com/3382541/9065/v/600/depositphotos_90653486-stock-illustration-graduation-diploma-certificate.jpg'),
    GridModel(
        text: 'Technology: 40',
        imageUrl:
            'https://cdn.dribbble.com/users/1647667/screenshots/9849363/media/01890923f178ea5693c3816aa0bc65e2.jpg'),
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
            height: size.height * 0.3,
            width: size.width,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          'https://static.vecteezy.com/system/resources/thumbnails/001/871/281/small_2x/illustration-of-health-checking-technology-health-protection-covid-19-swab-test-can-be-used-for-landing-page-website-web-mobile-apps-flyer-background-element-banner-template-poster-free-vector.jpg',
                        ),opacity: 200,
                        fit: BoxFit.cover)),
                height: size.height * 0.18,
                width: size.width * 0.9,
                child: Column(
                  children: [
                    Row(

                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: size.height * 0.6,
            width: size.width,
            child: ListView.builder(
              itemCount: gridList.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Container(
                    width: size.width * 0.9,
                    height: 120,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Card(
                          child: Container(
                            width: size.width * 0.9,
                            height: 100,
                            child: Padding(
                              padding: EdgeInsets.only(left: 120,),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: size.height,
                                    width: size.width * 0.51,
                                    child: Padding(padding: EdgeInsets.all(10),
                                    child: Text('vsdbnvms smnv mna mndv admnv adnm danm danm dndsvsdsdc sdds mnd kq')),

                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    // color: Colors.blueAccent,
                                    height: size.height,
                                    width: 30,
                                    child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Image.asset(
                                          AppImages.arrow_right,
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          child: Container(
                            height: size.height,
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                    image:
                                        NetworkImage(gridList[index].imageUrl),
                                    opacity: 200,
                                    fit: BoxFit.cover)),
                            child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Admin',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Roboto_Bold',
                                        color: Colors.black),
                                  ),
                                  Text(gridList[index].text, style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Roboto_Bold',
                                      color: Colors.black),)
                                ]),
                          ),
                        ),
                      ],
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

  GridModel({required this.text, required this.imageUrl});
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:slinfy_crm/src/models/Demo.dart';
// import 'package:slinfy_crm/src/utils/helpers/responsive_helper.dart';
// import 'package:slinfy_crm/src/utils/helpers/styles.dart';
//
// class Login extends StatefulWidget {
//   const Login({Key? key}) : super(key: key);
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   final _formKey = GlobalKey<FormState>();
//   bool isPassword = true;
//   Demo? demo;
//
//   getData() async{
//     FirebaseAuth auth = FirebaseAuth.instance;
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     CollectionReference collectionReference = FirebaseFirestore.instance.collection("Users");
//     // DocumentReference documentReference = firebaseFirestore.collection("User")
//     collectionReference.doc("123").get().then((DocumentSnapshot value) {
//     demo = Demo.fromData(value.data() as Map<String, dynamic>);
//     print(demo!.name);
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(),
//       body: Scrollbar(
//           child: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Container(
//           // height: context.height,
//           height: size.height,
//           width: size.width,
//           // width: context.width,
//           child: ResponsiveHelper.isMobile(context)
//               ? Container(
//                   margin: EdgeInsets.all(20),
//                   child: Column(
//                       children: [
//                         Image.asset('assets/images/login.png',width: size.width*0.5,height: size.height*0.5,),
//                         Text("Enter your login details",style: TextStyle(fontSize: 22,color: Colors.black87),),
//                         SizedBox(
//                           height: size.height*0.02,
//                         ),
//                         loginWidget(context)]))
//               : ResponsiveHelper.isWeb()
//                   ? Container(
//                       child: Column(
//                         children: [
//                           Container(
//                             width: size.width,
//                             height: size.height * 0.1,
//                             color: Colors.blue,
//                           ),
//                           Container(
//                             width: size.width,
//                             height: size.height * 0.9,
//                             color: Colors.red,
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                     child: Container(
//                                   color: Colors.yellow,
//                                 )),
//                                 Expanded(
//                                     child: Container(
//                                   width: size.width,
//                                   height: size.height,
//                                   decoration: BoxDecoration(
//                                       image: DecorationImage(
//                                           image: NetworkImage(
//                                               'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTD0pM5zXcJDw4E1V3uxVx3MYkY96kqXZ1OJIvkEF3OU1KIMJMMjbV1XyO4S0B2HOhgSM&usqp=CAU'),
//                                           fit: BoxFit.cover)),
//                                   child: Row(children: [
//                                     Expanded(
//                                       flex: 9,
//                                       child: Container(
//                                           width: size.width,
//                                           height: size.height,
//                                           decoration: BoxDecoration(
//                                               color: Colors.black12,
//                                               border: Border(
//                                                   right: BorderSide.none),
//                                               borderRadius: BorderRadius.only(
//                                                   topLeft: Radius.circular(20),
//                                                   bottomLeft:
//                                                       Radius.circular(20))),
//                                           margin: EdgeInsets.only(
//                                               left: size.width * 0.15,
//                                               // right: size.width * 0.05,
//                                               top: size.height * 0.1,
//                                               bottom: size.height * 0.1),
//                                           child: Padding(
//                                               padding: EdgeInsets.all(20),
//                                               child: loginWidget(context))),
//                                     ),
//                                     Expanded(
//                                         flex: 1,
//                                         child: Container(
//                                           width: size.width,
//                                           height: size.height,
//                                           color: Colors.white,
//                                         )),
//                                   ]),
//                                 ))
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     )
//                   : Container(),
//         ),
//       )),
//     );
//   }
//
//   Widget loginWidget(BuildContext context) {
//     return Container(
//       child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 keyboardType: TextInputType.emailAddress,
//                 style: robotoBlack,
//                 decoration: InputDecoration(
//                   filled: true,
//                     focusColor: Colors.white,
//                     //add prefix icon
//                     prefixIcon: Icon(
//                       Icons.email,
//                       color: Colors.grey,
//                     ),
//                     hintText: "Enter email ID",
//                     label: Text('Email'),
//                     // border: InputBorder.none
//                     // border: OutlineInputBorder(
//                     //     borderSide: BorderSide(
//                     //         color: Theme.of(context).dividerColor))
//                     ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter some text';
//                   }
//                   return null;
//                 },
//
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               TextFormField(
//                 keyboardType: TextInputType.text,
//                 decoration: InputDecoration(
//                   hintText: "Enter your password",
//                   label: Text("Password"),
//                   // border: InputBorder.none,
//                   // border: OutlineInputBorder(
//                   //     borderSide: BorderSide(
//                   //         color: Theme.of(context).dividerColor)),
//                   prefixIcon: Icon(
//                     Icons.key,
//                     color: Colors.grey,
//                   ),
//                   filled: true,
//                   suffixIcon: InkWell(
//                     onTap: () {
//                       setState(() {
//                         if (isPassword) {
//                           isPassword = false;
//                         } else {
//                           isPassword = true;
//                         }
//                         isPassword != isPassword;
//                       });
//                     },
//                     child: Icon(isPassword
//                         ? Icons.visibility_off
//                         : Icons.remove_red_eye),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter some text';
//                   }
//                   return null;
//                 },
//                 obscuringCharacter: "*",
//                 obscureText: isPassword,
//                 style: robotoBlack,
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               ElevatedButton(
//                 style: ButtonStyle(
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                         side:
//                             BorderSide(color: Theme.of(context).dividerColor)),
//                   ),
//                 ),
//                 onPressed: () {
//                   // Validate returns true if the form is valid, or false otherwise.
//                   // if (_formKey.currentState!.validate()) {
//                   //   // If the form is valid, display a snackbar. In the real world,
//                   //   // you'd often call a server or save the information in a database.
//                   //   ScaffoldMessenger.of(context).showSnackBar(
//                   //     const SnackBar(content: Text('Processing Data')),
//                   //   );
//                   // }
//                   getData();
//                 },
//                 child: Container(
//                     width: context.width * 0.9,
//                     child: Center(child: const Text('Submit'))),
//               ),
//             ],
//           )),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slinfy_crm_admin/src/bloc/authentication/authentication_bloc.dart';
import 'package:slinfy_crm_admin/src/models/user_model.dart';
import 'package:slinfy_crm_admin/src/repo/service/authentication_service.dart';
import 'package:slinfy_crm_admin/src/ui/auth/input_widget_email.dart';
import 'package:slinfy_crm_admin/src/ui/auth/input_widget_password.dart';
import 'package:slinfy_crm_admin/src/ui/commons/widgets/background.dart';
import 'package:slinfy_crm_admin/src/ui/home/admin_home.dart';
import 'package:slinfy_crm_admin/src/ui/home/home.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slinfy_crm_admin/src/ui/home/hr_home.dart';
import 'package:slinfy_crm_admin/src/ui/home/trainer_home.dart';
import 'package:slinfy_crm_admin/src/utils/constants/app_images.dart';
import 'package:slinfy_crm_admin/src/utils/constants/commons.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isEmail = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (BuildContext context, state) {
        if (state is AuthenticationSuccess) {
          if (state.userType == UserType.ADMIN.name) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const AdminHome()));
          } else if (state.userType == UserType.HR.name) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HRHome()));
          } else if (state.userType == UserType.TRAINER.name) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const TrainerHome()));
          }
        }else if(state is AuthenticationFailure){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error.toString())));

        }
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        if (state is AuthenticationInitial) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(children: [
              Background(),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 2.3),
                  ),
                  Column(
                    children: <Widget>[
                      ///holds email header and inputField
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 40, bottom: 10),
                            child: isEmail
                                ? Text(
                                    "Email",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500),
                                  )
                                : Text(
                                    "Password",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500),
                                  ),
                          ),
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: <Widget>[
                              isEmail
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          right: 40, bottom: 30),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                40,
                                        child: Column(children: [
                                          Material(
                                            elevation: 10,
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(0),
                                                    topRight:
                                                        Radius.circular(30))),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 40,
                                                  right: 20,
                                                  top: 10,
                                                  bottom: 10),
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                controller: email,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        "JohnDoe@example.com",
                                                    hintStyle: TextStyle(
                                                        color: Colors.black45,
                                                        fontSize: 14)),
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.only(
                                          right: 40, bottom: 30),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                40,
                                        child: Column(children: [
                                          Material(
                                            elevation: 10,
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(30),
                                                    topRight:
                                                        Radius.circular(0))),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 40,
                                                  right: 20,
                                                  top: 10,
                                                  bottom: 10),
                                              child: TextFormField(
                                                controller: password,
                                                obscureText: true,
                                                obscuringCharacter: '*',
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        "Enter your password",
                                                    hintStyle: TextStyle(
                                                        color: Colors.black45,
                                                        fontSize: 14)),
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ),
                              Padding(
                                  padding: EdgeInsets.only(right: 40),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: Padding(
                                        padding: EdgeInsets.only(top: 40),
                                        child: isEmail
                                            ? Text(
                                                'Enter your email id to continue...',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    color: Colors.black45,
                                                    fontSize: 12),
                                              )
                                            : Text(
                                                'Enter your password to continue...',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    color: Colors.black45,
                                                    fontSize: 12),
                                              ),
                                      )),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            isEmail = isEmail ? false : true;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: ShapeDecoration(
                                            shape: CircleBorder(),
                                            gradient: LinearGradient(
                                                colors: signInGradients,
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight),
                                          ),
                                          child: ImageIcon(
                                            AssetImage(
                                                "assets/images/ic_forward.png"),
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 40),
                      ),
                      Visibility(
                          visible: !isEmail,
                          child: roundedRectButton(
                              "Let's get Started",
                              signInGradients,
                              false,
                              email.text.trim(),
                              password.text.trim())),
                      // roundedRectButton("Create an Account", signUpGradients, false),
                    ],
                  )
                ],
              ),
            ]),
          );
        } else if (state is AuthenticationStarted) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppImages.login,width: MediaQuery.of(context).size.width*0.5,),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}

Widget roundedRectButton(String title, List<Color> gradient,
    bool isEndIconVisible, String email, String password) {
  return Builder(builder: (BuildContext mContext) {
    return InkWell(
      onTap: () async {
        UserModel userModel = UserModel(email: email, password: password);
        mContext
            .read<AuthenticationBloc>()
            .add(AuthenticationStarted(userModel: userModel));
        // await AuthenticationService()
        //     .signIn(userModel);
        // .then((UserCredential? value) {
        // if (value!= null) {
        //
        //   Navigator.of(mContext).pushReplacement(MaterialPageRoute(builder: (context)=>Home()));
        //
        // } else {
        //   ScaffoldMessenger.of(mContext)
        //       .showSnackBar(SnackBar(content: Text('Usernot found !')));
        // }
        // });
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Stack(
          alignment: Alignment(1.0, 0.0),
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(mContext).size.width / 1.5,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                gradient: LinearGradient(
                    colors: gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
              ),
              child: Text(title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              padding: EdgeInsets.only(top: 16, bottom: 16),
            ),
            Visibility(
              visible: isEndIconVisible,
              child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: ImageIcon(
                    AssetImage("assets/images/ic_forward.png"),
                    size: 30,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  });
}

const List<Color> signInGradients = [
  Color(0xFF0EDED2),
  Color(0xFF03A0FE),
];

const List<Color> signUpGradients = [
  // Color(0x2FF0FCF9),
  Color(0xFFABD1F5),
  Color(0xC87294E8),
  // Color(0xFFFF9945),
  // Color(0xFFFc6076),
];

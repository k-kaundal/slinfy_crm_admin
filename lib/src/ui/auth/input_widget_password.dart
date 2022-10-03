import 'package:flutter/material.dart';
class InputWidgetPassword extends StatelessWidget {
  final double topRight;
  final double bottomRight;

  InputWidgetPassword(this.topRight, this.bottomRight);
TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 40, bottom: 30),
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        child: Column(
            children:[
              Material(
                elevation: 10,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(bottomRight),
                        topRight: Radius.circular(topRight))),
                child: Padding(
                  padding: EdgeInsets.only(left: 40, right: 20, top: 10, bottom: 10),
                  child: TextFormField(
                    controller: password,
                    obscureText: true,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your password",
                        hintStyle: TextStyle(color: Colors.black45, fontSize: 14)),
                  ),
                ),
              ),
            ] ),
      ),
    );
  }
}
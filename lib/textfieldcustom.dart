import 'package:flutter/material.dart';
import 'Animation/FadeAnimation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TextFieldCustom extends StatefulWidget {
  TextFieldCustom({this.title,this.keyboardstyle,this.validator,this.text});
  final String title;
  TextInputType keyboardstyle;
  List<String Function(dynamic)> validator;
  final String text;

  @override
  _TextFieldCustomState createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  Color ktextcolor = Color.fromRGBO(143, 148, 251, 1);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.text,
          style: TextStyle(
              fontSize: 18,
              color: ktextcolor,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 3,),
        FadeAnimation(
            1.8,
            Container(
              height: 55,
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(143, 148, 251, .2),
                        blurRadius: 20.0,
                        offset: Offset(0, 10))
                  ]),
              child:
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: FormBuilderTextField(
                    validators: widget.validator,
                    keyboardType: widget.keyboardstyle,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.title,
                        hintStyle:
                        TextStyle(color: Colors.grey[600])),
                  ),
                ),
            )
        ),
        SizedBox(height: 10,),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TextFieldCustom extends StatefulWidget {
  TextFieldCustom(
      {this.hint,
      this.keyboardstyle,
      this.validator,
      this.text,
      this.onsaved,
      this.height,
      this.attribute});

  final String hint;
  final String attribute;
  TextInputType keyboardstyle;
  List<String Function(dynamic)> validator;
  final String text;
  final double height;
  Function onsaved;

  @override
  _TextFieldCustomState createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  Color ktextcolor = Color.fromRGBO(143, 148, 251, 1);
  bool allGood = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.text,
          style: TextStyle(
              fontSize: 18, color: ktextcolor, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 3,
        ),
        Container(
            height: widget.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Color.fromRGBO(143, 148, 251, 1)),
            child: Container(
              height: 65,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Color.fromRGBO(143, 148, 251, 8),
                  width: 3.0,
                ),
              ),
              child: FormBuilderTextField(
                autovalidate: allGood ? false : true,
                attribute: widget.attribute,
                onSaved: widget.onsaved,
                validators: widget.validator,
                keyboardType: widget.keyboardstyle,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.hint,
                    hintStyle:
                        TextStyle(color: Colors.grey[600], fontSize: 15)),
              ),
            )),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

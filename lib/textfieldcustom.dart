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
      this.attribute,
      this.autovalidate,
      this.initialValue});

  final String hint;
  final String attribute;
  TextInputType keyboardstyle;
  List<String Function(dynamic)> validator;
  final String text;
  final double height;
  final bool autovalidate;
  final String initialValue;

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
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Color.fromRGBO(143, 148, 251, 8),
                  width: 3.0,
                ),
              ),
              child: FormBuilderTextField(
                initialValue: widget.initialValue,
                textAlign: TextAlign.center,
                autovalidate: widget.autovalidate,
                attribute: widget.attribute,
                onSaved: widget.onsaved,
                validators: widget.validator,
                keyboardType: widget.keyboardstyle,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.hint,
                    hintStyle:
                        TextStyle(color: Colors.grey[300], fontSize: 15)),
              ),
            )),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

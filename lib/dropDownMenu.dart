import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
class dropDownMenuBox extends StatelessWidget {
  dropDownMenuBox({this.items, this.attribute, this.initialval});

  String attribute;
  String initialval;
  List items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color.fromRGBO(143, 148, 251, 8),
                //                   <--- border color
                width: 3.0,
              ),
            ),
            child: FormBuilderDropdown(
              attribute: attribute,
//                    decoration: InputDecoration(labelText: "Gender"),
              initialValue: initialval,
              hint: Text('Select'),
              validators: [FormBuilderValidators.required()],
              items: items
                  .map((requester) => DropdownMenuItem(
                  value: requester, child: Text("$requester")))
                  .toList(),
            ),
          ),
          Divider(
            endIndent: 10,
            indent: 10,
          ),
        ],
      ),
    );
  }
}
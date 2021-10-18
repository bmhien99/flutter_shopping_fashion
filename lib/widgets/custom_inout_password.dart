import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_fashion/screens/login_page.dart';

class CustomInPutPassword extends StatelessWidget {
  final String? name;
  final bool? obstext;
  final String? imageObserText;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final void Function()? onTap;

  CustomInPutPassword({this.name, this.obstext, this.imageObserText, this.validator, this.onChanged, this.onTap});
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
          obscureText: obstext!,
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
              hintText: name,
              border: OutlineInputBorder(),
              suffixIcon: GestureDetector(
                onTap: onTap,
                child: Icon(
                  obstext==true?Icons.visibility:Icons.visibility_off,
                  color:Colors.black,
                ),
              )
          )
      ),
    );
  }
}
  //return Container(
//       margin: EdgeInsets.only(bottom: 20.0),
//       child: TextFormField(
//           obscureText: obserText,
//           onChanged: widget.onChanged,
//           validator: widget.validator,
//           decoration: InputDecoration(
//               hintText: widget.name,
//               border: OutlineInputBorder(),
//               suffixIcon: GestureDetector(
//                 onTap: widget.onTap,
//                 child: Icon(
//                   obserText==true?Icons.visibility:Icons.visibility_off,
//                   color:Colors.black,
//                 ),
//               )
//           )
//       ),
//     );


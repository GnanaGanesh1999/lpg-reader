import 'package:flutter/material.dart';
import 'package:flutter_auth/components/text_field_container.dart';
import 'package:flutter_auth/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onSaved;
  final ValueChanged<String> validator;
  final ValueChanged<String> toggleObscureText;
  final String hintText;
  const RoundedPasswordField(
      {Key key,
      this.hintText,
      this.onSaved,
      this.validator,
      // this.obscureText = true,
      this.toggleObscureText})
      : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: obscureText,
        onChanged: widget.onSaved,
        validator: widget.validator,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: widget.hintText,
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.visibility,
              color: kPrimaryColor,
            ),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

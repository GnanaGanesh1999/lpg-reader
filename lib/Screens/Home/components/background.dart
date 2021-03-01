import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: kPrimaryLightColor.withOpacity(1),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   child: Image.asset(
          //     "assets/images/main_top.png",
          //     width: size.width * 0.4,
          //     height: size.height * 0.25,
          //     fit: BoxFit.fill,
          //   ),
          // ),
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   child: Image.asset(
          //     "assets/images/main_bottom.png",
          //     width: size.width * 0.4,
          //     height: size.height * 0.22,
          //     fit: BoxFit.fill,
          //   ),
          // ),
          // Positioned(
          //   bottom: 0,
          //   right: 0,
          //   child: Image.asset(
          //     "assets/images/login_bottom.png",
          //     width: size.width * 0.4,
          //     height: size.height * 0.15,
          //     fit: BoxFit.fill,
          //   ),
          // ),
          child,
        ],
      ),
    );
  }
}

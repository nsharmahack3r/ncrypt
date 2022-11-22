import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({Key? key, this.url, this.size = 40}) : super(key: key);
  final String? url;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (url == null || url == '') {
      return ClipOval(
          child: Image.asset(
        'assets/images/user.jpeg',
        fit: BoxFit.cover,
        height: size,
        width: size,
      ));
    }
    return ClipOval(
        child: Image.network(
          url!,
          fit: BoxFit.cover,
          height: size,
          width: size,
        ));
  }
}

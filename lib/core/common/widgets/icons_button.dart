import 'package:flutter/material.dart';

class IconsButton extends StatelessWidget {
  const IconsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            // Add your video call action here
            print('Video call button tapped');
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.video_call, color: Colors.black),
          ),
        ),
        InkWell(
          onTap: () {
            // Add your phone call action here
            print('Phone call button tapped');
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.phone, color: Colors.black),
          ),
        ),
      ],
    );
  }
}

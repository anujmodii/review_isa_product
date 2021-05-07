import 'package:flutter/material.dart';

class AvatarCard extends StatelessWidget {
   AvatarCard(this.image_name,this.name);

  String image_name;
  String name;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 125,
                backgroundImage: AssetImage(
                  image_name
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

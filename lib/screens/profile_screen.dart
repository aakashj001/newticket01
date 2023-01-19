import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticketbooking/utils/App_layout.dart';

import '../utils/app_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.bgcolor,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Gap(125),
              CircleAvatar(
                  backgroundImage: AssetImage('assets/images/p1.png'),
                  radius: 60),
              Gap(10),
              Text("Akshay", style: TextStyle(fontSize: 24)),
              Gap(5),
              Text(
                "someone@example.com",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Gap(10),
              TextButton(
                onPressed: null,
                // ignore: sort_child_properties_last
                child:  Padding(
                  padding:  EdgeInsets.only(left:8.0,right:8.0),
                  child: Text("Logout",style: TextStyle(color: Colors.white),),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red)),
              )
            ],
          ),
        ));
  }
}

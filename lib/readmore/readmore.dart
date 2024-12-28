import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

class readmoreText extends StatelessWidget {
  String content =
      "Terms and Conditions"
  "These terms and conditions govern your use of our system. By using our system, you agree to be bound by these terms and conditions.\n"
  "- A contract will be closed when judged by the admin if it is reported."

 " C,\n"

  "- A contract will be closed when judged by the admin if it is reported.\n"
  "-U have to provide your tasks at time with a desired quality.\n"

"  Dear Employers,\n"

  "- Sufficient unit is required to post a job.\n"
  "- Unit can be issued by a borrow, with out doing tasks.\n"
  "- Money can be withdrawn if the amount of your unit and borrow is greater than the withdrawal amount.\n"
 " - If u leave the system it will be hold by the system as compensation.\n"
  "-  You have to close a contract when you receive your project from the freelancer, unless you have a complain.\n"


  "Admin Email: ssswar367@gmail.com.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms and conditions"),
        backgroundColor: Colors.indigo,
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: ReadMoreText(
            content,
            trimLines: 8,
            textAlign: TextAlign.justify,
            trimMode: TrimMode.Line,
            trimCollapsedText: " Show More ",
            trimExpandedText: " Show Less ",
            lessStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
            moreStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),


            style: const TextStyle(
              fontSize: 16,
              height: 2,
            ),
          ),
        ),


      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {

              String UserEmail = "ssswar367@gmail.com";


              String? encodeQueryParameters(Map<String, String> params) {
                return params.entries
                    .map((MapEntry<String, String> e) =>
                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                    .join('&');
              }
              final Uri emailUri = Uri(
                  scheme: 'mailto',
                  path: UserEmail,
                  query: encodeQueryParameters(<String, String>{
                    'subject': 'From Skill Exchange System Admin',
                    'body':
                    'hello our user',

                  })

              );
              launchUrl(emailUri);

          },
          style: ElevatedButton.styleFrom(
            primary: Colors.indigo,
            onPrimary: Colors.white,
          ),
          child: Text("Contact Admin"),
        ),
      ),
    );
  }

}
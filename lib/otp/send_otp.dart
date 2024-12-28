import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/loading_dialog.dart';
import 'otp_screen.dart';

class otp_send extends StatefulWidget {

  String name;
  String password;
  String phone;
  String about;
  String image;


  otp_send(this.name,this.password,this.phone,this.about,this.image, );
 // const otp_send({Key? key}) : super(key: key);

  @override
  State<otp_send> createState() => _otp_sendState();
}

class _otp_sendState extends State<otp_send> {
  String? name1;
  String? email1;
  String? password1;
  String? phone1;
  String? about1;
  String? image1;
  TextEditingController email = TextEditingController();
  EmailOTP myauth = EmailOTP();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(

          child: Column( children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "images/otp.png",
                height: 350,
              ),
            ),
            const SizedBox(
              height: 60,
              child: Text(
                "Enter your Email to get otp Code",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Card(
              child: Column(
                children: [
                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.mail,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () async {
                        if (email.text.isNotEmpty) {
                          showDialog(
                              context: context,
                              builder: (c) {
                                return LoadingDialogWidget(
                                  message: "Registering  account",
                                );
                              }
                          );
                          myauth.setConfig(
                              appEmail: "contact@hdevcoder.com",
                              appName: "Email OTP",
                              userEmail: email.text,
                              otpLength: 4,
                              otpType: OTPType.digitsOnly);
                          if (await myauth.sendOTP() == true) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("OTP has been sent"),
                            ));

                            name1 = widget.name;
                            email1 = email.text;
                            password1 = widget.password;
                            phone1 = widget.phone;
                            about1 = widget.about;
                            image1 = widget.image;


                            Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen(myauth: myauth, name1.toString(), email1.toString(), password1.toString(), phone1.toString(), about1.toString(), image1.toString())));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Oops, OTP send failed"),
                            ));
                          }
                        }else{
                          Fluttertoast.showToast(msg: "Please enter your Email");

                        }
                          },
                          icon: const Icon(
                            Icons.send_rounded,
                            color: Colors.indigo,
                          )),
                      hintText: "Email Address",
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),

                  ElevatedButton(
                      onPressed: () async {
                        if (email.text.isNotEmpty) {
                          showDialog(
                              context: context,
                              builder: (c)
                              {
                                return LoadingDialogWidget(
                                  message: "sending otp",
                                );
                              }
                          );
                          myauth.setConfig(
                              appEmail: "contact@hdevcoder.com",
                              appName: "Email OTP",
                              userEmail: email.text,
                              otpLength: 4,
                              otpType: OTPType.digitsOnly);
                          if (await myauth.sendOTP() == true) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("OTP has been sent"),
                            ));

                            name1 = widget.name;
                            email1 = email.text;
                            password1 = widget.password;
                            phone1 = widget.phone;
                            about1 = widget.about;
                            image1 = widget.image;


                            Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen(myauth: myauth, name1.toString(), email1.toString(), password1.toString(), phone1.toString(), about1.toString(), image1.toString())));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Oops, OTP send failed"),
                            ));
                          }
                        }else
                        {

                          Fluttertoast.showToast(msg: "Please enter your Email");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.indigo,
                        fixedSize: const Size(290, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Send Otp",style: TextStyle(fontSize: 18,),
                      )
                  ),
                ],
              ),
            ),
          ]
          ),
        ),
      ),
    );
  }
}
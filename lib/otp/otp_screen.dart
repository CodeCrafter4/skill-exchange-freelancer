import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../quiz/quiz_home.dart';

class Otp extends StatelessWidget {



  const Otp({
    Key? key,
    required this.otpController,
  }) : super(key: key);
  final TextEditingController otpController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextFormField(
        controller: otpController,
        keyboardType: TextInputType.number,
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
        decoration: const InputDecoration(
          hintText: ('0'),
        ),
        onSaved: (value) {},
      ),
    );
  }
}

class OtpScreen extends StatefulWidget {


  String name;
  String email;
  String password;
  String phone;
  String about;
  String image;



   OtpScreen(this.name,this.email,this.password,this.phone,this.about,this.image,{Key? key,required this.myauth}) : super(key: key);

  final EmailOTP myauth ;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}


class _OtpScreenState extends State<OtpScreen> {

  String? name1;
  String? email1;
  String? password1;
  String? phone1;
  String? about1;
  String? image1;
  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();

  String otpController = "1234";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter OTP"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          const Icon(Icons.dialpad_rounded, size: 50),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Enter PIN That Sent to your Email",
            style: TextStyle(fontSize: 30),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Otp(
                  otpController: otp1Controller,
                ),
                Otp(
                  otpController: otp2Controller,
                ),
                Otp(
                  otpController: otp3Controller,
                ),
                Otp(
                  otpController: otp4Controller,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "correct your Email if you can't find a pin",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () async {
              if (await widget.myauth.verifyOTP(otp: otp1Controller.text +
                  otp2Controller.text +
                  otp3Controller.text +
                  otp4Controller.text) == true) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("OTP is verified"),
                ));
                name1=widget.name;
                email1=widget.email;
                password1=widget.password;
                phone1=widget.phone;
                about1=widget.about;
                image1=widget.image;

                Navigator.push(context, MaterialPageRoute(builder: (context) =>  QuizHomePage(name1.toString(), email1.toString(), password1.toString(), phone1.toString(), about1.toString(), image1.toString())));
               // Navigator.push(context, MaterialPageRoute(builder: (context) =>  AuthScreen()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Invalid OTP"),
                ));
              }
            },
            child: const Text(
              "Confirm",
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
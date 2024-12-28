
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freelancer_app/profile/profile.dart';
import '../global/global.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loading_dialog.dart';



class changeAccount extends StatefulWidget {
  String? img;
  String? pass;
  changeAccount(this. img, this.pass);

  @override
  _changeAccountState createState() => _changeAccountState();
}

class _changeAccountState extends State<changeAccount> {

  String password = "";
  String phone = "";
  String img ="";
  String pass ="";



  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();









  @override
  Widget build(BuildContext context)
  {
img=widget.img!;
pass=widget.pass!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text("Edit Account"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Material(

          child: Column(
            children: [

              const SizedBox(height: 12,),

              //get-capture image
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          img,
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.transparent,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 12,),

              const Text(
                "select photo for your profile",

                style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 1,
                  //fontFamily: 'Signatra',
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),

              ),

              const SizedBox(height: 12,),



              //inputs form fields
              Form(
                key: formKey,
                child: Column(
                  children: [

                    //name
                    CustomTextField(
                      textEditingController: passwordTextEditingController,
                      iconData: Icons.password,
                      hintText:  pass,
                      keyboardType: TextInputType.text,
                      isObsecre: false,
                      enabled: true,
                    ),


                    //phone


                    //email
                    CustomTextField(

                      textEditingController: phoneTextEditingController,
                      iconData: Icons.phone,
                      hintText:  sharedPreferences!.getString("phone")!,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      isObsecre: false,
                      enabled: true,
                    ),


                    const SizedBox(height: 20,),


                  ],
                ),
              ),
              const SizedBox(height: 20,),
              const SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: ()
                  {

                    updateProfile();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo,
                    fixedSize: const Size(290, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Save",style: TextStyle(fontSize: 18,),
                  )
              ),
              const SizedBox(height: 30,),

            ],


          ),


        ),
      ),


    );

  }


  updateProfile() async
  {
    if (passwordTextEditingController.text.isNotEmpty
        && phoneTextEditingController.text.isNotEmpty)
    {
      showDialog(
          context: context,
          builder: (c)
          {
            return LoadingDialogWidget(
              message: "updating your account",
            );
          }
      );

      password = passwordTextEditingController.text;
      phone = phoneTextEditingController.text;


      await FirebaseFirestore.instance
          .collection("users")
          .doc(
          sharedPreferences!.getString("uid"))
          .update({
        "password": password,
        "phone": phone,



      }

      );

      Fluttertoast.showToast(msg: "Account updated successfully.");

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => profile( ),
      ));
    }
    else
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Please complete the form.");
    }
  }
}
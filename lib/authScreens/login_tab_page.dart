import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../global/global.dart';
import '../splashScreen/my_splash_screen.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loading_dialog.dart';


class LoginTabPage extends StatefulWidget
{
  @override
  State<LoginTabPage> createState() => _LoginTabPageState();
}



class _LoginTabPageState extends State<LoginTabPage>
{
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  validateForm()
  {
    if(emailTextEditingController.text.isNotEmpty
        && passwordTextEditingController.text.isNotEmpty)
    {
      //allow user to login
      loginNow();
    }
    else
    {
      Fluttertoast.showToast(msg: "Please provide email and password.");
    }
  }

  loginNow() async
  {
    showDialog(
        context: context,
        builder: (c)
        {
          return LoadingDialogWidget(
            message: "Checking credentials",
          );
        }
    );

    User? currentUser;

    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailTextEditingController.text.trim(),
      password: passwordTextEditingController.text.trim(),
    ).then((auth)
    {
      currentUser = auth.user;
    }).catchError((errorMessage)
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occurred: \n $errorMessage");
    });

    if(currentUser != null)
    {
      checkIfUserRecordExists(currentUser!);
    }
  }

  checkIfUserRecordExists(User currentUser) async
  {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .get()
        .then((record) async
    {
      if(record.exists) //record exists
          {
        //status is approved
        if(record.data()!["status"] == "approved")
        {
          await sharedPreferences!.setString("uid", record.data()!["uid"]);
          await sharedPreferences!.setString("email", record.data()!["email"]);
          await sharedPreferences!.setString("name", record.data()!["name"]);
          await sharedPreferences!.setString("photoUrl", record.data()!["photoUrl"]);

          List<String> userCartList = record.data()!["userBookmark"].cast<String>();
          await sharedPreferences!.setStringList("userBookmark", userCartList);

          //send user to home screen
          Navigator.push(context, MaterialPageRoute(builder: (c)=> MySplashScreen()));
        }
        else //status is not approved
            {
          FirebaseAuth.instance.signOut();
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "you have BLOCKED by admin.\ncontact Admin: admin@ishop.com");
        }
      }
      else //record not exists
          {
        FirebaseAuth.instance.signOut();
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "This user's record do not exists.");
      }
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return SingleChildScrollView(
      child: Column(
        children: [

          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "images/go.png",
                height: MediaQuery.of(context).size.height * 0.40,
              ),
            ),
          ),

          const Text("Welcome Back",style: TextStyle(color: Colors.indigoAccent,fontSize: 26),),
          SizedBox(height: 43,),
          Form(
            key: formKey,
            child: Column(
              children: [


                //email
                CustomTextField(
                  textEditingController: emailTextEditingController,
                  iconData: Icons.email,
                  hintText: "Email",
                  isObsecre: false,
                  enabled: true,
                  keyboardType: TextInputType.emailAddress,
                ),

                //pass
                CustomTextField(
                  textEditingController: passwordTextEditingController,
                  iconData: Icons.lock,
                  hintText: "Password",
                  isObsecre: true,
                  enabled: true,
                  keyboardType: TextInputType.text,
                ),



                const SizedBox(height: 30,),

              ],
            ),
          ),

          ElevatedButton(
              onPressed: ()
              {
                validateForm();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo,
                fixedSize: const Size(290, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Sign in",style: TextStyle(fontSize: 18,),
              )
          ),

          const SizedBox(height: 30,),

        ],
      ),
    );
  }
}

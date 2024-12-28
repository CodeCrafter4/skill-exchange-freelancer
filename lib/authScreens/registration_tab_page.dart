import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../otp/send_otp.dart';
import '../quiz/quiz_home.dart';
import '../widgets/custom_text_field.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;

import '../widgets/loading_dialog.dart';



class RegistrationTabPage extends StatefulWidget
{
  const RegistrationTabPage({super.key});


  @override
  State<RegistrationTabPage> createState() => _RegistrationTabPageState();
}



class _RegistrationTabPageState extends State<RegistrationTabPage>
{

  TextEditingController nameTextEditingController = TextEditingController();
  // TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController aboutTextEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String downloadUrlImage = "";
  bool _value=false;


  String? name;
  String? password;
  String? phone;
  String? about;

  XFile? imgXFile;
  final ImagePicker imagePicker = ImagePicker();





  getImageFromGallery() async
  {
    imgXFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imgXFile;
    });
  }

  formValidation() async
  {
    if(imgXFile == null) //image is not selected
        {
      Fluttertoast.showToast(msg: "Please select an image.");
    }
    else //image is already selected
        {
      //password is equal to confirm password
      if(passwordTextEditingController.text == confirmPasswordTextEditingController.text)
      {
        showDialog(
            context: context,
            builder: (c)
            {
              return LoadingDialogWidget(
                message: "Registering  account",
              );
            }
        );
        //1.upload image to storage
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();

        fStorage.Reference storageRef = fStorage.FirebaseStorage.instance
            .ref()
            .child("usersImages").child(fileName);

        fStorage.UploadTask uploadImageTask = storageRef.putFile(File(imgXFile!.path));

        fStorage.TaskSnapshot taskSnapshot = await uploadImageTask.whenComplete(() {});

        await taskSnapshot.ref.getDownloadURL().then((urlImage)
        {
          downloadUrlImage = urlImage;
        });
        //check email, pass, confirm password & name text fields
        if(nameTextEditingController.text.isNotEmpty
            && passwordTextEditingController.text.isNotEmpty
            && confirmPasswordTextEditingController.text.isNotEmpty
            && phoneTextEditingController.text.isNotEmpty
            && aboutTextEditingController.text.isNotEmpty)
        {


        name = nameTextEditingController.text;
        password = passwordTextEditingController.text;
        phone=phoneTextEditingController.text;
        about=aboutTextEditingController.text;

        Navigator.push(context, MaterialPageRoute(builder: (c)=>otp_send (name.toString(), password.toString(), phone.toString(), about.toString(), downloadUrlImage.toString())));




          //2. save the user info to firestore database
         // saveInformationToDatabase();
        }
        else
        {
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Please complete the form. Do not leave any text field empty.");
        }
      }
      else //password is NOT equal to confirm password
          {
        Fluttertoast.showToast(msg: "Password and Confirm Password do not match.");
      }
    }
  }



  @override
  Widget build(BuildContext context)
  {
    return SingleChildScrollView(
      child: Column(
        children: [

          const SizedBox(height: 12,),
          const Text("Welcome to Freelancers App",style: TextStyle(color: Colors.indigoAccent,fontSize: 26),),
          SizedBox(height: 43,),
          //get-capture image
          GestureDetector(
            onTap: ()
            {
              getImageFromGallery();
            },
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.20,
              backgroundColor: Colors.white,
              backgroundImage: imgXFile == null
                  ? null
                  : FileImage(
                  File(imgXFile!.path)
              ),
              child: imgXFile == null
                  ? Icon(
                Icons.add_photo_alternate,
                color: Colors.black54,
                size: MediaQuery.of(context).size.width * 0.20,
              ) : null,
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
          const Text(
            "create your profile.",

            style: TextStyle(
              fontSize: 16,
              letterSpacing: 1,
              //fontFamily: 'Signatra',
              color: Colors.indigo,
              fontWeight: FontWeight.bold,
            ),

          ),
          //inputs form fields
          Form(
            key: formKey,
            child: Column(
              children: [

                //name
                CustomTextField(
                  textEditingController: nameTextEditingController,
                  iconData: Icons.person,
                  hintText: "User Name",
                  keyboardType: TextInputType.text,
                  isObsecre: false,
                  enabled: true,
                ),


                //phone
                CustomTextField(
                  textEditingController: phoneTextEditingController,
                  iconData: Icons.phone,
                  hintText: "Phone(10 character)",
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  isObsecre: false,
                  enabled: true,
                ),

                //email
                // CustomTextField(
                //
                //   textEditingController: emailTextEditingController,
                //   iconData: Icons.email,
                //   hintText: "Email",
                //   keyboardType: TextInputType.emailAddress,
                //   isObsecre: false,
                //   enabled: true,
                // ),

                //pass
                CustomTextField(
                  textEditingController: passwordTextEditingController,
                  iconData: Icons.password,
                  hintText: "Password(6 character or more)",
                  keyboardType: TextInputType.text,
                  isObsecre: true,
                  enabled: true,
                ),

                //confirm pass
                CustomTextField(
                  textEditingController: confirmPasswordTextEditingController,
                  iconData: Icons.password,
                  hintText: "Confirm Password(6 character or more)",
                  keyboardType: TextInputType.text,
                  isObsecre: true,

                  enabled: true,
                ),

                const SizedBox(height: 20,),
                 SizedBox(
                   width: MediaQuery.of(context).size.width * 0.95,
                   child: Container(
                     color: Colors.black12,
                     child: TextField(
                      style: const TextStyle(color: Colors.black),
                      minLines: 4,
                      maxLines: 7,
                      maxLength: 1000,
                      controller: aboutTextEditingController,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        hintText: "About me",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),


                      ),
                ),
                   ),
                 ),




              ],
            ),
          ),
            SizedBox(height: 10,),
            TextButton(onPressed: (){
              showDialog(
                  context: context,
                  builder: (context)
                  {
                    return SimpleDialog(
                      title: const Text(
                        "Terms and Conditions\n Our terms and conditions are your moral, we have the following terms and conditions to bring in to a system.\n"
                            "- A contract will be closed when judged by the admin if it is reported."
                            " Dear freelancers,\n"

                            "- U should have at least one skill to sign-up.\n"
                            "- U have to provide your tasks at time with a desired quality.\n"

                            " Dear Employers,\n"

                            "- Sufficient unit is required to post a job.\n"
                            "- Unit can be issued by a borrow, with out doing tasks.\n"
                            "- Money can be withdrawn if the amount of your unit and borrow is greater than the withdrawal amount.\n"
                            "- If u leave the system it will be hold by the system as compensation.\n"
                            "- You have to close a contract when you receive your project from the freelancer, unless you have a complain."
                        ,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,


                        ),
                      ),
                      children: [
                        SimpleDialogOption(
                          onPressed: ()
                          {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "ok",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 15
                            ),
                          ),
                        ),


                      ],
                    );
                  }
              );



            }, child: const Text("Read Terms and conditions",textAlign: TextAlign.start,
              style: TextStyle(fontSize: 16,color: Colors.indigo,
                decoration: TextDecoration.underline,),)),


            CheckboxListTile(
              title : const Text("I have read Terms and condition",
                style: TextStyle(color: Colors.black),),
                     value: _value, onChanged: (value){

              setState(() {
                _value=value!;
              });
          }
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
              onPressed: _value==true?()
              {
                formValidation();
              }:null,
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo,
                fixedSize: const Size(290, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Sign up",style: TextStyle(fontSize: 18,),
              )
          ),

          const SizedBox(height: 30,),

        ],
      ),
    );
  }
}

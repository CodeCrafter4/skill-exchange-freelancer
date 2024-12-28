import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freelancer_app/profile/profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;

import '../global/global.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loading_dialog.dart';



class EditProfilePage extends StatefulWidget {
  String? img;
  String? pass;
  EditProfilePage(this. img,this. pass);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  String name = "";
  String about = "";
  String email = "";
  String image = "";
  String pass = "";


  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController aboutTextEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String downloadUrlImage = "";
  String img = "";
  XFile? imgXFile;
  final ImagePicker imagePicker = ImagePicker();





  getImageFromGallery() async
  {
    imgXFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imgXFile;
    });
  }

  @override
  Widget build(BuildContext context)
  {
     img=widget.img!;
     pass=widget.pass!;
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text("Edit profile"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Material(

          child: Column(
            children: [

              const SizedBox(height: 12,),

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
                      ? CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.20,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        img,
                    ),

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



              //inputs form fields
              Form(
                key: formKey,
                child: Column(
                  children: [

                    //name
                    CustomTextField(
                      textEditingController: nameTextEditingController,
                      iconData: Icons.person,
                      hintText:  pass,
                      keyboardType: TextInputType.text,
                      isObsecre: false,
                      enabled: true,
                    ),


                    //phone


                    //email
                    CustomTextField(

                      textEditingController: emailTextEditingController,
                      iconData: Icons.email,
                      hintText:  sharedPreferences!.getString("email")!,
                      keyboardType: TextInputType.emailAddress,
                      isObsecre: false,
                      enabled: false,
                    ),



                    //location
                    CustomTextField(
                      textEditingController: aboutTextEditingController,
                      iconData: Icons.abc_outlined,
                      hintText:  sharedPreferences!.getString("about")!,
                      keyboardType: TextInputType.text,
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
    if (nameTextEditingController.text.isNotEmpty
        && aboutTextEditingController.text.isNotEmpty)
    {
      showDialog(
          context: context,
          builder: (c)
          {
            return LoadingDialogWidget(
              message: "updating your profile",
            );
          }
      );

      //1.upload image to storage
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      fStorage.Reference storageRef = fStorage.FirebaseStorage.instance
          .ref()
          .child("employersImages").child(fileName);

      fStorage.UploadTask uploadImageTask = storageRef.putFile(File(imgXFile!.path));

      fStorage.TaskSnapshot taskSnapshot = await uploadImageTask.whenComplete(() {});

      await taskSnapshot.ref.getDownloadURL().then((urlImage)
      {
        downloadUrlImage = urlImage;
      });
      name = nameTextEditingController.text;
      about = aboutTextEditingController.text;


      await FirebaseFirestore.instance
          .collection("users")
          .doc(
          sharedPreferences!.getString("uid"))
          .update({
        "name": name,
        "photoUrl": downloadUrlImage,
        "about": about,


      }

      );

      Fluttertoast.showToast(msg: "profile updated successfully.");

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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freelancer_app/contractsProposalScreens/text_field_address_widget.dart';
import '../global/global.dart';
import 'proposal_screen.dart';

class SaveNewProposalScreen extends StatefulWidget
{
  String? EmployerUID;
  String? unit;
  String? employerName;
  double? totalAmount;


  SaveNewProposalScreen({this.EmployerUID, this.totalAmount, this.unit, this.employerName,});

  @override
  State<SaveNewProposalScreen> createState() => _SaveNewProposalScreenState();
}

class _SaveNewProposalScreenState extends State<SaveNewProposalScreen>
{
  TextEditingController proposal = TextEditingController();
  String? employerName;



  @override
  Widget build(BuildContext context)
  {
    employerName=widget.employerName;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              color: Colors.indigo
          ),
        ),
        title: const Text(
          "New proposal",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()
        {
          if(proposal.text.isNotEmpty )
          {

            FirebaseFirestore.instance
                .collection("users")
                .doc(sharedPreferences!.getString("uid"))
                .collection("userProposal")
                .doc(DateTime.now().millisecondsSinceEpoch.toString())
                .set(
                {
                  "UserProposal": proposal.text.trim(),


                }).then((value)
            {

              Fluttertoast.showToast(msg: "New  proposal has been saved.");
              Navigator.push(context, MaterialPageRoute(builder: (c)=>ProposalScreen(
                employerUID:widget.EmployerUID.toString(),
                unit:widget.unit.toString(),
                totalAmount:widget.totalAmount,
                employerName:widget.employerName,

              )));

            });
          }else{
            Fluttertoast.showToast(msg: "fill the text box");

          }
        },
        label: const Text(
            "Save Now"
        ),

        icon: const Icon(
          Icons.save,
          color: Colors.white,
        ),backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: proposal,
                  minLines: 8,
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                      hintText: 'Write Your Proposal Here',
                      hintStyle: TextStyle(
                          color: Colors.grey
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )
                  ),
                ),
              ),


            ],
          ),

        ),

      ),

    );
  }
}

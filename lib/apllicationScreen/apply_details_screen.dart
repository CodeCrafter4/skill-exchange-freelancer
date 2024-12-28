import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_app/apllicationScreen/proposal_design_widget.dart';
import 'package:freelancer_app/apllicationScreen/status_banner_widget.dart';
import 'package:intl/intl.dart';
import '../global/global.dart';
import '../models/proposal.dart';


class ApplyDetailsScreen extends StatefulWidget
{
  String? contractID;

  ApplyDetailsScreen({super.key, this.contractID,});

  @override
  State<ApplyDetailsScreen> createState() => _ProposalDetailsScreenState();
}



class _ProposalDetailsScreenState extends State<ApplyDetailsScreen>
{
  String contractStatus = "";
  String contractID = "";
  String unit = "";
  String employerName = "";
  String email = "";
  String contractDate = "";
  String employerUID1="";
  String contractByUser2= "";

  @override
  Widget build(BuildContext context)
  {


    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(

        child: FutureBuilder(

          future: FirebaseFirestore.instance
              .collection("users")
              .doc(sharedPreferences!.getString("uid"))
              .collection("contracts")
              .doc(widget.contractID)
              .get(),
          builder: (c, AsyncSnapshot dataSnapshot)
          {
            Map? contractDataMap;
            if(dataSnapshot.hasData)
            {
              contractDataMap = dataSnapshot.data.data() as Map<String, dynamic>;
              contractStatus = contractDataMap["status"].toString();
              contractID = contractDataMap["contractId"].toString();
              employerName=contractDataMap["employerName"].toString();
              email=contractDataMap["email"].toString();
              unit=contractDataMap["unit"].toString();
              contractDate=contractDataMap["contractTime"].toString();
              employerUID1= contractDataMap["employerUID"].toString();
              contractByUser2= contractDataMap["contractBy"].toString();
              return Column(
                children: [

                  StatusBanner(
                      status: contractDataMap["isSuccess"],
                      contractID:  contractID,
                      unit: unit,
                      employerName: employerName,
                      email: email,
                      contractStatus: contractStatus,
                      contractDate:contractDate,
                      employerUID:employerUID1,
                      contractByUser:contractByUser2,

                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Unit ${contractDataMap["unit"]}",
                        style: const TextStyle(
                          color: Colors.indigo,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "contract ID = ${contractDataMap["contractId"]}",
                        style: const TextStyle(
                          color: Colors.indigo,
                          
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(

                        "contract at = ${DateFormat("dd MMMM, yyyy - hh:mm aa")
                            .format(DateTime.fromMillisecondsSinceEpoch(int.parse(contractDataMap["contractTime"])))}",
                        style: const TextStyle(
                          color: Colors.indigo,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const Divider(
                    thickness: 1,
                    color: Colors.lightBlue,
                  ),

                   contractStatus == "ended"
                      ? Image.asset("images/delivered.png")
                      : Image.asset("images/state.png"),


                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,

                    ),
                  ),

                  const Divider(
                    thickness: 1,
                    color: Colors.lightBlue,
                  ),
                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("users")
                        .doc(sharedPreferences!.getString("uid"))
                        .collection("userProposal")
                        .doc(contractDataMap["proposalID"])
                        .get(),
                    builder: (c, AsyncSnapshot snapshot)
                    {
                      if(snapshot.hasData)
                      {
                        return ProposalDesign(
                          model: Proposal.fromJson(
                              snapshot.data.data() as Map<String, dynamic>
                          ),
                          contractStatus: contractStatus,
                          contractId: widget.contractID,
                          employerUID: contractDataMap!["employerUID"],
                          unit: contractDataMap!["unit"],
                          orderByUser: contractDataMap["contractBy"],
                          totalUnit: contractDataMap["unit"].toString(),
                        );
                      }
                      else
                      {
                        return const Center(
                          child: Text(
                            "No data exists.",
                          ),
                        );
                      }
                    },
                  ),

                ],
              );
            }
            else
            {
              return const Center(
                child: Text(
                  "No data exists.",
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_app/contractsProposalScreens/save_new_proposal_screen.dart';
import 'package:provider/provider.dart';
import '../assistantMethods/proposal_changer.dart';
import '../global/global.dart';
import '../models/proposal.dart';
import 'proposal_design_widget.dart';


class ProposalScreen extends StatefulWidget
{
  String? employerUID;
  String? unit;
  String? employerName;
  double? totalAmount;

  ProposalScreen({this.employerUID, this.totalAmount, this.unit, this.employerName,});



  @override
  State<ProposalScreen> createState() => _ProposalScreenState();
}

class _ProposalScreenState extends State<ProposalScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        flexibleSpace: Container(
          decoration: const BoxDecoration(
              color: Colors.indigo
          ),
        ),
        title: const Text(
          "submit proposal",
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
            Navigator.push(context, MaterialPageRoute(builder: (c)=>SaveNewProposalScreen(
              EmployerUID: widget.employerUID.toString(),
              totalAmount: widget.totalAmount,
              unit:widget.unit.toString(),
              employerName:widget.employerName.toString(),
            )));
          },
          label: const Text(
            "Add New proposal"
          ),
          icon: const Icon(
            Icons.abc_outlined,
            color: Colors.white,
          ),
      ),
      body: Column(
        children: [

          //query
          //model
          //design

          Consumer<ProposalChanger>(builder: (context, address, c)
          {
            return Flexible(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(sharedPreferences!.getString("uid"))
                    .collection("userProposal").snapshots(),
                builder: (context, AsyncSnapshot dataSnapshot)
                {
                  if(dataSnapshot.hasData)
                  {
                    if(dataSnapshot.data.docs.length > 0)
                    {
                      return ListView.builder(
                          itemBuilder: (context, index)
                          {
                            return ProposalDesignWidget(
                              proposalModel: Proposal.fromJson(
                                dataSnapshot.data.docs[index].data() as Map<String, dynamic>
                              ),
                              index: address.count,
                              value: index,
                              proposalID: dataSnapshot.data.docs[index].id,
                              totalUnit: widget.totalAmount,
                              employerUID: widget.employerUID,
                              unit: widget.unit,
                              employerName: widget.employerName,
                            );
                          },
                          itemCount: dataSnapshot.data.docs.length,
                      );
                    }
                    else
                    {
                      return Container();
                    }
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
            );
          }),
        ],
      ),
    );
  }
}

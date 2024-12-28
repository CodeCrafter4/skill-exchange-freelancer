import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../assistantMethods/proposal_changer.dart';
import '../applyStart/place_apply_screen.dart';
import '../models/proposal.dart';



class ProposalDesignWidget extends StatefulWidget
{
  Proposal? proposalModel;
  int? index;
  int? value;
  String? proposalID;
  double? totalUnit;
  String? employerUID;
  String? unit;
  String? employerName;

  ProposalDesignWidget({super.key,
    this.proposalModel,
    this.index,
    this.value,
    this.proposalID,
    this.totalUnit,
    this.employerUID,
    this. unit,
    this. employerName,
  });

  @override
  State<ProposalDesignWidget> createState() => _ProposalDesignWidgetState();
}

class _ProposalDesignWidgetState extends State<ProposalDesignWidget>
{
  @override
  Widget build(BuildContext context)
  {
    return Card(
      color: Colors.white24,
      child: Column(
        children: [

          //address info
          Row(
            children: [

              Radio(
                groupValue: widget.index,
                value: widget.value!,
                activeColor: Colors.indigo,
                onChanged: (val)
                {
                  //provider
                  Provider.of<ProposalChanger>(context, listen: false).showSelectedAddress(val);
                },
              ),

              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Table(
                      children: [

                        TableRow(
                          children:
                          [
                            const Text(
                              "Employer Name: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.employerName!.toString(),
                            ),
                          ],
                        ),

                        const TableRow(
                          children:
                          [
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),

                        // TableRow(
                        //   children:
                        //   [
                        //     const Text(
                        //       "Phone Number: ",
                        //       style: TextStyle(
                        //         color: Colors.black,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //     Text(
                        //       widget.proposalModel!.phoneNumber.toString(),
                        //     ),
                        //   ],
                        // ),

                        const TableRow(
                          children:
                          [
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),

                        TableRow(
                          children:
                          [
                            const Text(
                              "proposal: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.proposalModel!.UserProposal.toString(),
                            ),
                          ],
                        ),

                        const TableRow(
                          children:
                          [
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ],
              ),

            ],
          ),

          //button
          widget.value == Provider.of<ProposalChanger>(context).count
              ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                    ),
                    onPressed: ()
                    {


                      //send user to Place Order Screen finally
                      Navigator.push(context, MaterialPageRoute(builder: (c)=>ApplyScreen(
                        proposalID: widget.proposalID,
                        totalAmount: widget.totalUnit,
                        employerUID: widget.employerUID.toString(),
                        unit: widget.unit.toString(),
                        employerName: widget.employerName.toString(),
                      )));
                    },
                    child: const Text("Proceed"),
                  ),
              )
              : Container(),

        ],
      ),
    );
  }
}

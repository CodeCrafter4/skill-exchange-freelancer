import 'package:flutter/material.dart';


class CustomTextField extends StatefulWidget
{
  TextEditingController? textEditingController;
  IconData? iconData;
  String? hintText;
  int? maxLength;
  int? minLines;
  TextInputType keyboardType;
  bool? isObsecre = true;
  bool? enabled = true;

  CustomTextField({super.key,
    this.textEditingController,
    this.iconData,
    required this.keyboardType,
    this.hintText,
    this.isObsecre,
    this.maxLength,
    this.minLines,
    this.enabled,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}



class _CustomTextFieldState extends State<CustomTextField>
{
  @override
  Widget build(BuildContext context)
  {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black12,

        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),

      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        enabled: widget.enabled,
        controller: widget.textEditingController,
        obscureText: widget.isObsecre!,
        maxLength: widget.maxLength,
        minLines: widget.minLines,
        keyboardType: widget.keyboardType,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(

          border: InputBorder.none,
          prefixIcon: Icon(
            widget.iconData,
            color: Colors.indigo,
          ),
          focusColor: Theme.of(context).primaryColorDark,
          hintText: widget.hintText,hintStyle: const TextStyle(color: Colors.grey),

          //contentPadding: EdgeInsets.all(20)
        ),
      ),
    );
  }
}

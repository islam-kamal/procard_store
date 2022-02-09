import 'package:procard_store/fileExport.dart';

class CustomTextFieldWidget extends StatefulWidget{
  BuildContext context;
      String hint;
  IconData iconData;
      Widget suffixIcon;
  bool secure ;
  Color color;
  final TextInputType inputType;
  final String errorText;
  final int max_lines;
  final Function(String) onchange;
  CustomTextFieldWidget({
   this.hint,this.suffixIcon = null,this.context,this.iconData = null,this.secure= false,this.onchange,
    this.errorText,this.inputType,this.color=Colors.white , this.max_lines =1
});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomTextFieldWidgetState();
  }

}

class CustomTextFieldWidgetState extends State<CustomTextFieldWidget>{
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return TextFormField(
      style: TextStyle(color: widget.color),
      obscureText: widget.secure,
      maxLines: widget.max_lines,
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.iconData,
          color: widget.color,
        ),
        suffixIcon:  widget.suffixIcon,

        hintText:  widget.hint,
        hintStyle: TextStyle(
            color: widget.color,
            fontWeight: FontWeight.bold,
            fontSize: height * .014),
        filled: false,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color:  widget.color,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: widget.color,
            )),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color:  widget.color,
            )),
          errorText: widget.errorText
      ),
      onChanged: widget.onchange,
      keyboardType: widget.inputType,

    );
  }

}
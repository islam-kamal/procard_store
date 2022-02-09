import 'package:procard_store/fileExport.dart';
class CustomTextField extends StatefulWidget {
  final String hint;
  final bool  secure ;
  Widget prefixIcon ;
  final Function onTab;
  final bool icon_status;
  final int maxline ;
  final readOnly;
  final Stream<String> stream;
  final Function(String) onchange;
  final TextInputType inputType;
  final Icon icon;
  final String errorText;
  CustomTextField(
      {this.secure, this.hint  ,this.prefixIcon : null,
        this.icon_status,
        this.onTab,
        this.readOnly,
        this.stream,
        this.onchange,
        this.maxline= 1,
        this.icon ,
        this.errorText,
        this.inputType=TextInputType.text,} );
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomTextField_State();
  }
}


class CustomTextField_State extends State<CustomTextField> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width ;
    return Container(
      child:   StreamBuilder<String>(
          stream: widget.stream,
          builder: (context, snapshot) {
            return TextFormField(
              keyboardType: widget.inputType,
              style: TextStyle(color:primary_color,
                  fontSize: height*ProdCardStoreFont.primary_font_size),
              obscureText: widget.secure,
              cursorColor: primary_color,
              onChanged: widget.onchange,
              maxLines: widget.maxline,
              decoration: InputDecoration(
                  prefixIcon: widget.prefixIcon == null ? null : widget.prefixIcon,
                hintText: widget.hint,
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                hintStyle: TextStyle(color: whiteColor.withOpacity(.8,),
                    fontWeight: FontWeight.bold,fontSize: height*.018,),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color:Colors.white)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: greenColor)),
                  errorText: widget.errorText),
              readOnly: widget.readOnly ?? false,
              onTap: widget.onTab,
            );
          }),






      );}}
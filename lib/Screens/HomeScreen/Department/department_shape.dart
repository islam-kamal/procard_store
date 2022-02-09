import 'package:procard_store/Model/Home_Models/departments_model.dart' as department_model;
import 'package:procard_store/Widgets/customText.dart';
import 'package:procard_store/fileExport.dart';

class DepartmentShape extends StatefulWidget{
  department_model.Data  department;
  final String type;
  DepartmentShape({this.department,this.type});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DepartmentShapeState();
  }

}

class DepartmentShapeState extends State<DepartmentShape>{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(StaticData.get_width(context)  * 0.02),
      child: Container(
        width: widget.type == 'horizontal'? StaticData.get_width(context) * 0.3 : StaticData.get_width(context) * 0.5 ,
        padding: EdgeInsets.all(StaticData.get_width(context)  * 0.02),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: primary_color)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network('${widget.department.logo}',
            height: StaticData.get_width(context) * 0.1,),
            MyText(
              text: widget.department.name,
              color: primary_color,
              weight: FontWeight.bold,
              size: ProdCardStoreFont.primary_font_size,
            ),
          ],
        ),
      ),
    );
  }

}
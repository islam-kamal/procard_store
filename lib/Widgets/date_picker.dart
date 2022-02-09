
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart' as intl;
import 'package:procard_store/fileExport.dart';

class Date_Picker extends StatefulWidget {
  final String label;
  final String hint;
  final bool start_date ;
  final String type;
  Date_Picker({this.label='',this.hint,this.start_date=false, this.type });
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DatePicker_State();
  }
}

class DatePicker_State extends State<Date_Picker> {
  var date = '25/7/2020';
  DateTime selectedDate = DateTime.now();
  SharedPreferenceManager sharedPreferenceManager =SharedPreferenceManager();

  Future<void> selectDate(BuildContext context) async {
    var date_hint = '${widget.hint}';
    final DateTime picked = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: primary_color,
              accentColor: yellowColor,
              colorScheme: ColorScheme.light(primary: primary_color),
              buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme.primary
              ),
            ),
            child: child,
          );
        },
        initialDate: selectedDate,
        firstDate: widget.start_date?DateTime(1980):DateTime.now(),
        lastDate: DateTime(2050),);
        if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        date = "${selectedDate.toLocal()}".split(' ')[0];
        date_hint = intl.DateFormat('EEEE').format(selectedDate);
        final DateFormat formatter = DateFormat('dd-MM-yyyy');
        final String date_formatted = formatter.format(selectedDate);
        sharedPreferenceManager.writeData(CachingKey.DATE, date_formatted);
        print('date : ${date}');
        print('date_hint : $date_hint');
        print('date_formatted : $date_formatted');
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    //final String formatted = formatter.format(now);
    final String formatted = '${widget.hint}';
    date = formatted;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        children: <Widget>[
          InkWell(
            child: spinner_show_time_and_date(date),
            onTap: () {
              setState(() {
                selectDate(context);
                date = date;
              });
            },
          )

        ],
      ),
    );
  }
  Widget spinner_show_time_and_date(String hint) {
    String _value;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return  Stack(
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Stack(
                children: <Widget>[
                  Container(
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<String>(
                          value: _value,
                          isExpanded: true,
                          icon:  Icon( Icons.date_range,size: 25,),
                          hint: Text(
                            hint,
                            style: TextStyle(fontSize: ProdCardStoreFont.primary_font_size),
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              _value = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: whiteColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: whiteColor)
                    ),
                  )

                ],
              ),
            ),
          ),
        ],
      );

  }
}

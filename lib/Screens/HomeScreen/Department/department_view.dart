import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procard_store/Bloc/Home_Bloc/departments_bloc.dart';
import 'package:procard_store/Model/Home_Models/departments_model.dart';
import 'package:procard_store/Widgets/Shimmer/list_shimmer.dart';
import 'package:procard_store/fileExport.dart';

class DepartmentView extends StatefulWidget{
  final String view_type;
  DepartmentView({this.view_type});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DepartmentViewState();
  }

}

class DepartmentViewState extends State<DepartmentView>{

  @override
  void initState() {
    departmentsBloc.add(GetAllDepartmentsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.view_type == 'horizontal_ListView' ?   BlocBuilder(
      bloc: departmentsBloc,
      builder: (context, state) {
        if (state is Loading) {
          return ListShimmer(
            type: 'horizontal',
          );
        } else if (state is Done) {
          if(state.indicator == 'department'){
            return StreamBuilder<DepartmentsModel>(
                stream: departmentsBloc.departments_subject,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.data.isEmpty) {
                      return ListShimmer(
                        type: 'horizontal',
                      );
                    } else {
                      return     ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: snapshot.data.data.length,
                          itemBuilder: (context,index){
                            return DepartmentShape(
                              department: snapshot.data.data[index],
                              type: 'horizontal',
                            );
                          });
                    }
                  } else {
                    return ListShimmer(
                      type: 'horizontal',
                    );
                  }
                });
          }
        } else if (state is ErrorLoading) {
          if(state.indicator == 'department'){
            return ListShimmer(
              type: 'horizontal',
            );
          }

        }else{
          return Container();
        }
      },
    )


 : BlocBuilder(
      bloc: departmentsBloc,
      builder: (context, state) {
        if (state is Loading) {
          return ListShimmer(
            type: 'grid_view',
          );
        } else if (state is Done) {
          if(state.indicator == 'department'){
            return StreamBuilder<DepartmentsModel>(
                stream: departmentsBloc.departments_subject,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.data.isEmpty) {
                      return ListShimmer(
                        type: 'grid_view',
                      );
                    } else {
                      return  GridView.builder(
                          itemCount: snapshot.data.data.length,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.5,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color(0xfff7f7f7),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(0),
                                  ),
                                ),
                                child:  DepartmentShape(
                                  department: snapshot.data.data[index],
                                  type: 'horizontal',
                                )
                            );
                          });
                    }
                  } else {
                    return ListShimmer(
                      type: 'grid_view',
                    );
                  }
                });
          }
        } else if (state is ErrorLoading) {
          if(state.indicator == 'department'){
            return ListShimmer(
              type: 'grid_view',
            );
          }
        }else{
          return Container();
        }
      },
    );
  }

}
import 'package:bloc/bloc.dart';
import 'package:procard_store/Model/Home_Models/departments_model.dart';
import 'package:procard_store/Model/Home_Models/latest_card_model.dart';
import 'package:procard_store/Repository/Departments_Repo/departments_respository.dart';
import 'package:procard_store/Repository/Latest_Cards_Repo/latest_card_repository.dart';
import 'package:procard_store/Repository/Slider_Repo/slider_repository.dart';
import 'package:procard_store/fileExport.dart';
import 'package:rxdart/rxdart.dart';

class DepartmentsBloc extends Bloc<AppEvent,AppState>  {
  DepartmentsBloc(AppState initialState) : super(initialState);

  BehaviorSubject<DepartmentsModel> _departments_subject = new BehaviorSubject<DepartmentsModel>();

  get departments_subject {
    return _departments_subject;
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    yield Loading();
    if(event is GetAllDepartmentsEvent){
      final response = await departmentsRepo.get_all_departments();
      print("response : ${response}");
      if(response.status  == 200){
        _departments_subject.sink.add(response);
        yield Done(indicator: 'department');
      }else{
        yield ErrorLoading(null,indicator: 'department');
      }

    }

  }
}
DepartmentsBloc departmentsBloc = new DepartmentsBloc(null);
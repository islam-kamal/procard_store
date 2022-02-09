import 'package:bloc/bloc.dart';
import 'package:procard_store/Model/Bank_Model/bank_model.dart';
import 'package:procard_store/Model/Home_Models/departments_model.dart';
import 'package:procard_store/Model/Home_Models/latest_card_model.dart';
import 'package:procard_store/Model/Settings_Model/settings_model.dart';
import 'package:procard_store/Repository/BankRepo/bank_repository.dart';
import 'package:procard_store/Repository/Departments_Repo/departments_respository.dart';
import 'package:procard_store/Repository/Latest_Cards_Repo/latest_card_repository.dart';
import 'package:procard_store/Repository/SettingsRepo/settings_repository.dart';
import 'package:procard_store/Repository/Slider_Repo/slider_repository.dart';
import 'package:procard_store/fileExport.dart';
import 'package:rxdart/rxdart.dart';

class BankBloc extends Bloc<AppEvent,AppState>  {
  BankBloc(AppState initialState) : super(initialState);

  BehaviorSubject<BankModel> _bank_subject = new BehaviorSubject<BankModel>();

  get bank_subject {
    return _bank_subject;
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    yield Loading();
    if(event is GetBanksEvent){
      final response = await bankRepo.getAllBanks();
      print("response : ${response}");
      if(response.status  == 200){
        _bank_subject.sink.add(response);
        yield Done();
      }else{
        yield ErrorLoading(null);
      }

    }

  }
}
BankBloc bankBloc = new BankBloc(null);
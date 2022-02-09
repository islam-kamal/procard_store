
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:procard_store/Base/shared_preference_manger.dart';
import 'package:procard_store/Bloc/Authentication_Bloc/ForgetPasswordBloc/forget_password_bloc.dart';
import 'package:procard_store/Repository/AuthenticationRepo/authentication_repository.dart';

import 'package:procard_store/fileExport.dart';

class LogoutBloc extends Bloc<AppEvent,AppState> implements BaseBloc{
  final AuthenticationRepository _authenticationRepository;
  LogoutBloc(this._authenticationRepository):super(Start());
  SharedPreferenceManager sharedPreferenceManager =SharedPreferenceManager();
  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    if(event is logoutClick){
      yield Loading(model: null);
      var response = await AuthenticationRepository.logout();
      if(response.status ==true){
        yield Done(model: response);


      }else{
        yield ErrorLoading(response);
      }

    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
  }

}

final logout_bloc = LogoutBloc(null);
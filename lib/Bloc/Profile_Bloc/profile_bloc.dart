import 'package:bloc/bloc.dart';
import 'package:procard_store/Model/Profile_Model/profile_staistics_model.dart';
import 'package:procard_store/fileExport.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc extends Bloc<AppEvent,AppState>  {
  ProfileBloc(AppState initialState) : super(initialState);

  BehaviorSubject<ProfileStaisticsModel> _profile_statics_subject = new BehaviorSubject<ProfileStaisticsModel>();

  get profile_statics_subject {
    return _profile_statics_subject;
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    yield Loading();
    if(event is GetProfileStatistics){
      final response = await profileRepository.getProfileStaistics();
      print("response status : ${response.data}");
        _profile_statics_subject.sink.add(response);
      yield  Done();

    }

  }
}
ProfileBloc profileBloc = new ProfileBloc(null);
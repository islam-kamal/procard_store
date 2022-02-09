import 'package:bloc/bloc.dart';
import 'package:procard_store/Repository/Slider_Repo/slider_repository.dart';
import 'package:procard_store/fileExport.dart';
import 'package:rxdart/rxdart.dart';

class SliderBloc extends Bloc<AppEvent,AppState>  {
  SliderBloc(AppState initialState) : super(initialState);

  BehaviorSubject<SliderModel> _home_slider_subject = new BehaviorSubject<SliderModel>();

  get home_slider_subject {
    return _home_slider_subject;
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    yield Loading();
    if(event is GetHomeSliderEvent){
      final response = await sliderRepo.getAllSliders();
      print("response : ${response}");
      if(response.status == 200){
        _home_slider_subject.sink.add(response);
        yield Done(indicator: 'slider');
      }else{
        yield ErrorLoading(null,indicator: 'slider');
      }

    }

  }
}
SliderBloc sliderBloc = new SliderBloc(null);
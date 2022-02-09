import 'package:procard_store/fileExport.dart';

class SliderRepo {

  Future<SliderModel> getAllSliders() async{
    return NetworkUtil.internal().get(
        SliderModel(), Urls.HOME_SLIDER_URL);
  }

}

SliderRepo sliderRepo = SliderRepo();
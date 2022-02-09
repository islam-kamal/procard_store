import 'package:bloc/bloc.dart';
import 'package:procard_store/Model/CreditCard_Model/credit_card_model.dart';
import 'package:procard_store/Repository/CreditCardRepo/credit_card_repository.dart';
import 'package:procard_store/fileExport.dart';
import 'package:rxdart/rxdart.dart';

class CreditCardsBloc extends Bloc<AppEvent,AppState>  with Validator{
  CreditCardsBloc(AppState initialState) : super(initialState);

  BehaviorSubject<CreditCardModel> _credit_cards_subject = new BehaviorSubject<CreditCardModel>();

  get credit_cards_subject {
    return _credit_cards_subject;
  }
  final card_name_controller = BehaviorSubject<String>();
  Function(String) get card_name_change => card_name_controller.sink.add;
  Stream<String> get card_name => card_name_controller.stream.transform(input_text_validator);

  final card_number_controller = BehaviorSubject<String>();
  Function(String) get card_number_change => card_number_controller.sink.add;
  Stream<String> get card_number => card_number_controller.stream.transform(input_text_validator);

  final card_cvv_controller = BehaviorSubject<String>();
  Function(String) get card_cvv_change => card_cvv_controller.sink.add;
  Stream<String> get card_cvv => card_cvv_controller.stream.transform(input_text_validator);

  final card_expire_date_controller = BehaviorSubject<String>();
  Function(String) get card_expire_date_change => card_expire_date_controller.sink.add;
  Stream<String> get card_expire_date => card_expire_date_controller.stream.transform(input_text_validator);

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{

    if(event is GetCreditCardEvent){
      yield Loading();
      final response = await creditCardRepository.getAllCreditCards();
      print("response : ${response}");
        _credit_cards_subject.sink.add(response);
        print("_credit_cards_subject : ${_credit_cards_subject}");
        yield Done();


    }else  if(event is AddCreditCardEvent){
      yield Loading();
      final response = await creditCardRepository.addCreditCard(
       card_name: card_name_controller.value ,
       card_number: card_number_controller.value,
       expire_date: await sharedPreferenceManager.readString(CachingKey.DATE),
       cvv: card_cvv_controller.value
      );
      print("response : ${response}");
      if(response.status == 204){
        yield Done(model: response);
      }else{
        yield ErrorLoading(response);
      }



    }

  }
}
CreditCardsBloc creditCardsBloc = new CreditCardsBloc(null);
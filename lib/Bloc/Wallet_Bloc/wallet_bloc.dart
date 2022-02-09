
import 'package:procard_store/Model/Wallet_Model/wallet_model.dart';
import 'package:procard_store/Repository/WalletRepo/Wallet_Repo.dart';
import 'package:procard_store/fileExport.dart';
import 'package:rxdart/rxdart.dart';

class WalletBloc extends Bloc<AppEvent,AppState> with Validator{
  WalletBloc(AppState initialState) : super(initialState);


  BehaviorSubject<WalletModel> _wallet_history_subject = new BehaviorSubject<WalletModel>();
  get wallet_history_subject {
    return _wallet_history_subject;
  }

  final recharge_amount_controller = BehaviorSubject<String>();
  Function(String) get recharge_amount_change => recharge_amount_controller.sink.add;
  Stream<String> get recharge_amount => recharge_amount_controller.stream.transform(input_number_validator);

  final account_name_controller = BehaviorSubject<String>();
  Function(String) get account_name_change => account_name_controller.sink.add;
  Stream<String> get account_name => account_name_controller.stream.transform(input_text_validator);

  final account_number_controller = BehaviorSubject<String>();
  Function(String) get account_number_change => account_number_controller.sink.add;
  Stream<String> get account_number => account_number_controller.stream.transform(input_text_validator);

  final iban_number_controller = BehaviorSubject<String>();
  Function(String) get iban_number_change => iban_number_controller.sink.add;
  Stream<String> get iban_number => iban_number_controller.stream.transform(input_text_validator);

  final bank_name_controller = BehaviorSubject<String>();
  Function(String) get bank_name_change => bank_name_controller.sink.add;
  Stream<String> get bank_name=> bank_name_controller.stream.transform(input_text_validator);

  void dispose(){
    _wallet_history_subject.value =null;
  }
  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is getWalletHistoryEvent) {
      yield Loading();
      final response = await walletRepository.get_wallet_history(
      );
      if (response.status == 200) {
        print("wallet : ${response.operations}");
        print("wallet balance : ${response.balance}");
        sharedPreferenceManager.writeData(CachingKey.USER_WALLET_BALANCE, response.balance);

        _wallet_history_subject.sink.add(response);
        yield Done(model: response);
      } else{
        yield ErrorLoading(response);
      }
    }else  if (event is RechargeWalletBankTransferEvent) {
      yield Loading(indicator: 'confirm charge');
      final response = await walletRepository.recharge_wallet_bank_transfer(
        bank_name: bank_name_controller.value,
        account_owner: account_name_controller.value,
        account_number: account_number_controller.value,
        amount: recharge_amount_controller.value,
        iban: iban_number_controller.value
      );
      if (response.status == 204) {
        print("wallet : ${response.message}");
        yield Done(model: response,indicator: 'confirm charge');
      } else{
        yield ErrorLoading(response,indicator: 'confirm charge');
      }
    }
  }

}

WalletBloc walletBloc = new WalletBloc(null);
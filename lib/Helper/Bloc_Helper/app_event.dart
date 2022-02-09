
abstract class AppEvent {}

//Home Events
class GetHomeSliderEvent extends AppEvent{

}
class GetLatestCardsEvent extends AppEvent{

}
class GetBestSellerEvent extends AppEvent{

}
class GetCountriesEvent extends AppEvent{

}

class GetCardDetailsEvent extends AppEvent{
  final int card_id;
  GetCardDetailsEvent({this.card_id});
}
class GetAllDepartmentsEvent extends AppEvent{

}

//SETTINGS
class AppSettingsEvent extends AppEvent{
}
class AppSocialEvent extends AppEvent{
}
//Banks
class GetBanksEvent extends AppEvent{

}
//CommonQuestions
class GetCommonQuestionsEvent extends AppEvent{

}
// DISCOUNT
class GetAllDiscountsEvent extends AppEvent{

}
//Coupon
class AddCouponEvent extends AppEvent{
var value;
AddCouponEvent({this.value});
}
//Notifications
class GetAllNotificationsEvent extends AppEvent{

}

//orders
class GetAllOrdersEvent extends AppEvent{

}
class CancelOrderEvent extends AppEvent{
  final int order_id;
  CancelOrderEvent({this.order_id});
}
class OrderDetailsEvent extends AppEvent{
  final int order_id;
  OrderDetailsEvent({this.order_id});
}
//CREDIT CARDS
class GetCreditCardEvent extends AppEvent{

}
class AddCreditCardEvent extends AppEvent{

}


//RECOMMENDATIONS
class GetAllRecommendationsEvent extends AppEvent{

}

class click extends AppEvent{}
class refreshToken extends AppEvent{}


//forget password events
class sendOtpClick extends AppEvent{}

class checkOtpClick extends AppEvent{}

class resendOtpClick extends AppEvent{}

class changePasswordClick extends AppEvent{}

class logoutClick extends AppEvent{}

//profile event
class profileClick extends AppEvent{
  var password;
  profileClick({this.password});
}

//upgrade account
class upgradeAccountClick extends AppEvent{}

//offers
class getAllOffers extends AppEvent{}

//category
class getAllCategories extends AppEvent{}
//complain
class getAllComplain extends AppEvent{}


//Favourite
class AddFavouriteEvent extends AppEvent{
  final int card_id;
  AddFavouriteEvent({this.card_id});
}
class RemoveFavouriteEvent extends AppEvent{
  final int card_id;
  RemoveFavouriteEvent({this.card_id});
}
class GetAllFavouriteEvent extends AppEvent{

}

//product
class getRecommendedProduct_click extends AppEvent{

}
class rateAndReview_click extends AppEvent{
  var value;
  var product_quality; var product_id;
  var delivery_time;
  var comment ;
  var using_experiences;
  rateAndReview_click({this.product_id,this.value,this.using_experiences,this.delivery_time,this.product_quality,this.comment});

}

// CREDIT CARD
class updateCreditCard extends AppEvent{
  final String card_id;
  updateCreditCard({this.card_id});
}
class getAllCreditCard_click extends AppEvent{
}

//Locations
class addNewLocation extends AppEvent{

}
class updateLocation extends AppEvent{
  final String location_id;
  updateLocation({this.location_id});
}
class getAllAddresses_click extends AppEvent{
}


// Profile
class GetProfileStatistics extends AppEvent{
}

//Wallet
class getWalletHistoryEvent extends AppEvent{
}
class RechargeWalletBankTransferEvent extends AppEvent{
}


//Call Us
class CallUsEvent extends AppEvent{
}

//search
class SearchEvent extends AppEvent{

}
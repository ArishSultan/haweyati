import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:haweyati_client_data_models/utils/toast_utils.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';

class StripeTransactionResponse {
  String message;
  bool success;
  String paymentIntentId;
  StripeTransactionResponse({this.message, this.success,this.paymentIntentId});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '$apiBase/payment_intents';
  static String secret = 'sk_test_51H5TD1Hd6Hl6omJ80WMijMFyAWulASFc9q3dEVQCbHnjScWSKksWLbZ5h6bB2RjorJ9sCJxolZ8G72AEawTJ22b200AvBaVNjg';
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  static init() {
    StripePayment.setOptions(
        StripeOptions(
            publishableKey: "pk_test_51H5TD1Hd6Hl6omJ8y6cuRN5kQThSgh0TLf5Abanb3nOFXo53YcxsmNQOulXour5TmtNAAZule8a4pwi8S4jWZW8A001r9dg6a2",
            merchantId: "Test",
            androidPayMode: 'test'
        )
    );
  }

  static Future<StripeTransactionResponse> payViaExistingCard({String amount, String currency, CreditCard card}) async{

    try {
      var paymentMethod = await StripePayment.createPaymentMethod(PaymentMethodRequest(card: card));

      var paymentIntent;
      try{
        paymentIntent = await StripeService.createPaymentIntent(
            amount,
            "SAR"
            // currency
        );

        print(paymentIntent);
      } catch (e){
        print("There was an error");
        showErrorToast(e);
        print(e);
      }

      var response;
      try{
        response = await StripePayment.confirmPaymentIntent(
            PaymentIntent(
                clientSecret: paymentIntent['client_secret'],
                paymentMethodId: paymentMethod.id
            ));
      }catch (e){
          print(e);
        }


        print(response.paymentIntentId);

      if (response.status == 'succeeded') {
        return new StripeTransactionResponse(
          paymentIntentId: response.paymentIntentId,
            message: 'Transaction successful',
            success: true
        );
      } else {
        return StripeTransactionResponse(
            message: 'Transaction failed',
            success: false
        );
      }
    } on PlatformException catch(err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return new StripeTransactionResponse(
          message: 'Transaction failed: ${err.toString()}',
          success: false
      );
    }
  }

  static Future<StripeTransactionResponse> payWithNewCard({String amount, String currency}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest()
      );
      var paymentIntent = await StripeService.createPaymentIntent(
          amount,
          currency
      );

      var response = await StripePayment.confirmPaymentIntent(
          PaymentIntent(
              clientSecret: paymentIntent['client_secret'],
              paymentMethodId: paymentMethod.id
          )
      );

      print(response.toJson());

      if (response.status == 'succeeded') {
        return new StripeTransactionResponse(
            message: 'Transaction successful',
            success: true,
            paymentIntentId: response.paymentIntentId
        );
      } else {
        return new StripeTransactionResponse(
            message: 'Transaction failed',
            success: false
        );
      }
    } on PlatformException catch(err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      showErrorToast(err);
      return new StripeTransactionResponse(
          message: 'Transaction failed: ${err.toString()}',
          success: false
      );
    }
  }

  static getPlatformExceptionErrorResult(err) {
    print(err);
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction cancelled';
    }

    return new StripeTransactionResponse(
        message: message,
        success: false
    );
  }

  static Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
        Uri.parse(StripeService.paymentApiUrl),
          body: body,
          headers: StripeService.headers
      );
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
    return null;
  }
}
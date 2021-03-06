import 'package:flutter/material.dart';
import 'package:haweyati/src/ui/pages/payment/new-card_page.dart';
import 'package:haweyati/src/ui/views/dotted-background_view.dart';
import 'package:haweyati/src/ui/views/live-scrollable_view.dart';
import 'package:haweyati/src/ui/widgets/app-bar.dart';
import 'package:haweyati/src/const.dart';
import 'package:haweyati/src/utils/navigator.dart';
import 'package:hive/hive.dart';

import 'payment-methods_page.dart';

class CreditCardsPage extends StatefulWidget {
  final int amount;
  CreditCardsPage({this.amount});
  @override
  _CreditCardsPageState createState() => _CreditCardsPageState();
}

class _CreditCardsPageState extends State<CreditCardsPage> {

  String paymentIntentId;

  receive(String id){
    paymentIntentId = id;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HaweyatiAppBar(hideCart: true, hideHome: true),
      body: DottedBackgroundView(
        child: LiveScrollableView(
          title: 'Available Cards',
          subtitle: loremIpsum.substring(0, 70),
          loader: () async {
            Box box;

            if (Hive.isBoxOpen('available_cards')) {
              box = Hive.box('available_cards');
            } else {
              box = await Hive.openBox('available_cards');
            }

            return box.values.toList();
          },
          builder: (BuildContext context, data) {
            return Container();
          }
        ),
      ),

      floatingActionButton: Container(
        height: 40,
        margin: const EdgeInsets.only(bottom: 5),
        child: FlatButton.icon(
          onPressed: () async {
            await navigateTo(context, NewCardPage(amount: widget.amount,onPaymentIntentId: receive,));
            if (paymentIntentId != null) {
              Navigator.pop(context, PaymentResponse(PaymentMethodEnum.stripe,paymentIntentId));
              Navigator.pop(context, PaymentResponse(PaymentMethodEnum.stripe,paymentIntentId));
            }
          },
          icon: Icon(Icons.add),
          shape: StadiumBorder(),
          textColor: Colors.white,
          color: Theme.of(context).primaryColor,
          label: Text('Add New Card', style: TextStyle(
            letterSpacing: 0
          ))
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    Hive.box('available_cards').close();
  }
}

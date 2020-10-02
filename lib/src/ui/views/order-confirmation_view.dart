import 'dart:async';

import 'package:flutter/material.dart';
import 'package:haweyati/src/models/payment_model.dart';
import 'package:haweyati/src/services/orders_service.dart';
import 'package:haweyati/src/ui/modals/dialogs/order/unable-to-place-order_dialog.dart';
import 'package:haweyati/src/ui/modals/dialogs/waiting_dialog.dart';
import 'package:haweyati/src/ui/pages/orders/order-placed_page.dart';
import 'package:haweyati/src/ui/pages/payment/payment-methods_page.dart';
import 'package:haweyati/src/ui/snack-bars/payment/not-selected_snack-bar.dart';
import 'package:haweyati/src/ui/views/scroll_view.dart';
import 'package:haweyati/src/models/order/order_model.dart';
import 'package:haweyati/src/ui/widgets/app-bar.dart';
import 'package:haweyati/src/ui/widgets/buttons/raised-action-button.dart';
import 'package:haweyati/src/utils/custom-navigator.dart';

class OrderConfirmationView extends StatelessWidget {
  final Order order;
  final bool fromCart;
  final List<Widget> children;
  final FutureOr Function() preProcess;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  OrderConfirmationView({
    this.order,
    this.fromCart = false,
    this.children,
    this.preProcess
  });

  @override
  Widget build(BuildContext context) {
    return ScrollableView(
      key: _scaffoldKey,
      appBar: HaweyatiAppBar(progress: .75, confirmOrderCancel: true),
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 100),
      showBackground: true,
      children: children,
      extendBody: true,

      bottom: RaisedActionButton(
        label: 'Proceed',
        onPressed: () async {
          _scaffoldKey.currentState.hideCurrentSnackBar();

          if (preProcess != null) await preProcess();

          final result = await navigateTo(context, PaymentMethodsPage());

          if (result == null) {
            _scaffoldKey.currentState.showSnackBar(PaymentMethodNotSelectedSnackBar());
            return;
          }

          order.payment = Payment(
            type: result.method,
            intentId: result.intentId
          );

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => WaitingDialog(message: 'Placing your order')
          );

          try {
            final _order = await OrdersService().placeOrder(order);
            Navigator.of(context).pop();

            navigateTo(context, OrderPlacedPage(_order.number, () async {}));
          } catch (e) {
            Navigator.of(context).pop();

            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => UnableToPlaceOrderDialog(e)
            );
          }
        }
      )
    );
  }
}
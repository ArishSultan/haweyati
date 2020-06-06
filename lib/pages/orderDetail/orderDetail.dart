import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati/models/dumpstermodel.dart';
import 'package:haweyati/pages/payment/payment-method.dart';
import 'package:haweyati/widgits/appBar.dart';
import 'package:haweyati/widgits/emptyContainer.dart';
import 'package:haweyati/widgits/haweyati-appbody.dart';
import 'package:haweyati/widgits/stackButton.dart';

class OrderDetail extends StatefulWidget


{


DumpSterModel orderDetail;
OrderDetail({this.orderDetail});
  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: HaweyatiAppBar(),
      body: HaweyatiAppBody(title: "Orders",btnName: "Continue",
        onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PaymentMethod(paymentMethod: widget.orderDetail,)));},
        showButton: true,detail: "fdsfds",
        child: ListView(
        padding: EdgeInsets.fromLTRB(15, 30, 15, 100),
        children: <Widget>[
          EmptyContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Services Detail",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    FlatButton.icon(
                        onPressed: (null),
                        icon: Icon(
                          Icons.edit,
                          color: Theme.of(context).accentColor,
                        ),
                        label: Text(
                          "Edit",
                          style: TextStyle(
                              color: Theme.of(context).accentColor),
                        ))
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 50,
                      color: Colors.brown,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                 widget.orderDetail.name,
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Price",
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                      flex: 4,
                    ),
                    Expanded(
                      child: Text(
                        "Quantity",
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                      flex: 3,
                    ),
                    Expanded(
                      child: Text(
                        "Helper",
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                      flex: 2,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(widget.orderDetail.rate),
                      flex: 4,
                    ),
                    Expanded(
                      child: Text("100 piece"),
                      flex: 3,
                    ),
                    Expanded(
                      child: Text("No"),
                      flex: 2,
                    ),
                  ],
                )
              ],
            ),
          ),
          EmptyContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Time & Location",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    FlatButton.icon(
                        onPressed: (null),
                        icon: Icon(
                          Icons.edit,
                          color: Theme.of(context).accentColor,
                        ),
                        label: Text(
                          "Edit",
                          style: TextStyle(
                              color: Theme.of(context).accentColor),
                        ))
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                FlatButton.icon(
                    onPressed: (null),
                    icon: Icon(
                      Icons.location_on,
                      color: Theme.of(context).accentColor,
                    ),
                    label: Text("dkjfjkasbfkjanfksnfansfnasln")),
                SizedBox(
                  height: 30,
                ),
                _buildHeadRow(text1: "Drop-off-Date",text2: "Drop-off-Time"),
                SizedBox(
                  height: 15,
                ),
_builddetailRow(text1: "1 June 2020", text2: "3.00 - 6.00 PM")
,
                SizedBox(
                  height: 30,
                ),
                _buildHeadRow(text1: "Pick-up-Date",text2: "Pick-up-Time"),
                SizedBox(
                  height: 15,
                ),
                _builddetailRow(text1: "1 June 2020", text2: "3.00 - 6.00 PM")

/////////////////////////////,
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "20 Yard Container Dumpster",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          SizedBox(
            height: 10,
          ),          _buildRow(type: "Price", detail: "345.00 Sar"),
          _buildRow(type: "Quantity", detail: "1 Piece"),
          _buildRow(type: "Service Days", detail: "11 Days"),
          _buildRow(type: "Delivery fee", detail: "50.00 SAR"),

          _buildRow(type: "Total", detail: "345.00 Sar")
        ],
      ),)
    );
  }

  Widget _buildRow({String type, String detail ,}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          Text(
            type,
            style: TextStyle(color: Colors.blueGrey),
          ),
          Text(
            detail,
            style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }

  Widget _buildHeadRow({String text1,String text2}){
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            "Drop-off-Date",
            style: TextStyle(color: Colors.blueGrey),
          ),
          flex: 4,
        ),
        Expanded(
          child: Text(
            "Drop-off-Date",
            style: TextStyle(color: Colors.blueGrey),
          ),
          flex: 3,
        ),
      ],
    );
  }

  Widget _builddetailRow({String text1,String text2}){
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            text1,
            ),
          flex: 4,
        ),
        Expanded(
          child: Text(
            text2,
            ),
          flex: 3,
        ),
      ],
    );
  }
}

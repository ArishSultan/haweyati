import 'package:flutter/material.dart';
import 'package:haweyati/models/bm-pricing.dart';
import 'package:haweyati/models/building-material_sublist.dart';
import 'package:haweyati/services/haweyati-service.dart';
import 'package:haweyati/widgits/appBar.dart';
import 'package:haweyati/src/utils/custom-navigator.dart';
import 'package:haweyati/widgits/stackButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'building-quantity-selection.dart';

class BuildingDetail extends StatefulWidget {
  final BMProduct item;
  BuildingDetail({this.item});
  @override
  _BuildingDetailState createState() => _BuildingDetailState();
}

class _BuildingDetailState extends State<BuildingDetail> {

  SharedPreferences prefs;
  BMProduct bmItem;
  BMPricing pricing;
  @override
  void initState() {
    super.initState();
    initDetail();
  }

  initDetail() async {
    var prefs = await SharedPreferences.getInstance();
    bmItem = widget.item;
    for(var item in widget.item.pricing){
      if(item.city == prefs.getString('city')){
        setState(() {
          pricing = item;
        });
        bmItem.pricing.clear();
        bmItem.pricing.add(item);
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: HaweyatiAppBar(context: context,),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  child: (Image.network(HaweyatiService.convertImgUrl(widget.item.image.name),fit: BoxFit.cover,)),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                 widget.item.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("${pricing?.price12yard.toString()} / 12 Yard | ${pricing?.price20yard.toString()} / 20 Yard",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
//                    Text(
//                      pricing.,
//                      style: TextStyle(color: Colors.black54),
//                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(widget.item.description),
              ],
            ),
          ),
          StackButton(
            onTap: () {
              CustomNavigator.navigateTo(
                  context, BuildingProductDetail(item: bmItem ,));
            },
            buttonName: "Buy Now ",
          )
        ],
      ),
    );
  }
}

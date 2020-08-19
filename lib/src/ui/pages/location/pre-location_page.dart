import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:haweyati/pages/locations-map_page.dart';
import 'package:haweyati/widgits/appBar.dart';
import 'package:haweyati/widgits/custom-navigator.dart';
import 'package:haweyati/widgits/no-scroll_page.dart';
import 'package:easy_localization/easy_localization.dart';

class PreLocationPage extends StatefulWidget {
  @override
  _PreLocationPageState createState() => _PreLocationPageState();
}

class _PreLocationPageState extends State<PreLocationPage> {

  bool isLocationEnabled;

   checkLocationEnabledStatus() async {
//    GeolocationStatus geolocationStatus = await Geolocator().checkGeolocationPermissionStatus();
//    print(geolocationStatus);
    if (await Geolocator().isLocationServiceEnabled()) {
      isLocationEnabled = true;
    } else {
      isLocationEnabled = false;
    }
  }

  @override
  void initState() {
    super.initState();
    checkLocationEnabledStatus();
  }

  @override
  Widget build(BuildContext context) {
    return NoScrollPage(
      appBar: HaweyatiAppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.location_on,
              color: Theme.of(context).accentColor,
              size: 100,
            ),
            SizedBox(height: 15),
            Text(
              tr("Location"),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 15),
            Text(
              tr("Location_Detail"),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      onAction: () async {

       await checkLocationEnabledStatus();
        if(isLocationEnabled!=null && isLocationEnabled){
          CustomNavigator.navigateTo(context, MyLocationMapPage());
        }
        else {
          await AppSettings.openLocationSettings();
        }
      },
      action: tr('Set_Your_Location'),
    );
  }
}

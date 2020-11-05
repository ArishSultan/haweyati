import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haweyati/src/data.dart';
import 'package:haweyati/src/ui/views/dotted-background_view.dart';
import 'package:haweyati/src/ui/views/header_view.dart';
import 'package:haweyati/src/ui/views/no-scroll_view.dart';
import 'package:haweyati/src/ui/widgets/app-bar.dart';
import 'package:haweyati/src/ui/widgets/buttons/flat-action-button.dart';
import 'package:haweyati/src/const.dart';

class ShareAndInvitePage extends StatefulWidget {
  @override
  _ShareAndInvitePageState createState() => _ShareAndInvitePageState();
}

class _ShareAndInvitePageState extends State<ShareAndInvitePage> {
  String _code;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    final profileId = AppData.instance().$user.profile.id;
    _code = profileId.substring(profileId.length - 5);
  }

  @override
  Widget build(BuildContext context) {
    return NoScrollView(
      key: _scaffoldKey,
      appBar: HaweyatiAppBar(hideHome: true, hideCart: true),
      body: DottedBackgroundView(
        padding: const EdgeInsets.only(bottom: 50),
        child: Column(children: <Widget>[
          Container(
            width: 80,
            height: 80,
            child: Center(child: Image.asset(GiftIcon, width: 50, height: 50)),
            decoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: HeaderView(
              title: 'Share and Invite',
              subtitle: 'Invite our friends and give them each 500 points in coupons. And for every friend who completes their first purchase we\'ll give you 500 points.',
            ),
          ),
          Container(
            width: 170,
            padding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 15
            ),
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(50)
            ),
            child: Row(children: <Widget>[
              Text(_code.toUpperCase(), style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                letterSpacing: 2
              )),
              GestureDetector(
                onTap: () => Clipboard.setData(ClipboardData(text: _code)),
                child: Text('Copy', style: TextStyle(color: Colors.orange))
              )
            ],mainAxisAlignment: MainAxisAlignment.spaceBetween),
          ),
        ], mainAxisAlignment: MainAxisAlignment.center),
      ),
      bottom: FlatActionButton(
        label: 'Invite Friends',
        onPressed: () {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Invitation will be available after purchasing application domain'
                'i.e. https://www.haweyati.com'),
          ));
        }
      ),
    );
  }
}

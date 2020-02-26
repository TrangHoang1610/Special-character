import 'dart:io';

import 'package:flutter/material.dart';
import 'package:special_character/constaints/constaints.dart';
import 'package:special_character/screen/createIcon.dart';
import 'package:special_character/screen/create_characters.dart';
import 'package:special_character/screen/frequently_character.dart';
import 'package:special_character/screen/icon.dart';
import 'package:special_character/screen/my_Favorite.dart';
import 'package:special_character/util/native.dart';
import 'package:special_character/util/readJson.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:special_character/util/admob_ads.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isHide = false;
  String dropdownMore = '';
  @override
  void initState() {
    platform.invokeListMethod("rate");
    // TODO: implement initState

    super.initState();
  }

  _launchURL() async {
    const url = STORE;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffF2BA4D),
          centerTitle: true,
          title: Text(
            'Character ',
            style: TextStyle(
                fontFamily: 'Sans',
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
                size: 30,
              ),
              elevation: 3,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              underline: Container(
                color: Colors.white,
              ),
              onChanged: (String value) {
                if (value == 'Share') {
                  FlutterShare.share(title: 'Share App', linkUrl: APP);
                } else if (value == 'Other application') {
                  _launchURL();
                } else {
                  platform.invokeListMethod("showRate");
                }
              },
              items: <String>['Share', 'Other application', 'Rate me 5 star']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
        // drawer: Drawer(
        //   child: ListView(
        //     children: <Widget>[],
        //   ),
        // ),
        body: Stack(
          children: <Widget>[
            Container(
              width: width,
              height: height,
              color: Color(0xff1D253B),
            ),
            Positioned.fill(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isHide = true;
                            });
                            AdmobAds.createInterstitialAd(50, () {
                              setState(() {
                                isHide = false;
                              });
                              //setState(() {});
                              //cần làm sau khi tắt quảng cáo
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Create()),
                              );
                            });
                          },
                          child: Container(
                            width: width / 2 - 5,
                            height: 150,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1.5, color: Colors.black12),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/create.png',
                                  width: 40,
                                  height: 40,
                                ),
                                Text('Create characters',
                                    style: TextStyle(
                                      fontFamily: 'Sans',
                                      fontSize: 18,
                                      color: Colors.black,
                                    ))
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isHide = true;
                            });
                            AdmobAds.createInterstitialAd(50, () {
                              setState(() {
                                isHide = false;
                              });
                              //setState(() {});
                              //cần làm sau khi tắt quảng cáo
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => iconScreen()),
                              );
                            });
                          },
                          child: Container(
                            width: width / 2 - 5,
                            height: 150,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1.5, color: Colors.black12),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/icon.png',
                                  width: 40,
                                  height: 40,
                                ),
                                Text('Emoticons',
                                    style: TextStyle(
                                      fontFamily: 'Sans',
                                      fontSize: 18,
                                      color: Colors.black,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isHide = true;
                          });
                          AdmobAds.createInterstitialAd(50, () {
                            setState(() {
                              isHide = false;
                            });
                            //setState(() {});
                            //cần làm sau khi tắt quảng cáo
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateIcon()),
                            );
                          });
                        },
                        child: Container(
                          width: width / 2 - 5,
                          height: 150,
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 1.5, color: Colors.black12),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/images/iconCreate.png',
                                width: 40,
                                height: 40,
                              ),
                              Text('Create icons',
                                  style: TextStyle(
                                    fontFamily: 'Sans',
                                    fontSize: 18,
                                    color: Colors.black,
                                  ))
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isHide = true;
                          });
                          AdmobAds.createInterstitialAd(50, () {
                            setState(() {
                              isHide = false;
                            });
                            //setState(() {});
                            //cần làm sau khi tắt quảng cáo
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => myFavotite()),
                            );
                          });
                        },
                        child: Container(
                          width: width / 2 - 5,
                          height: 150,
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 1.5, color: Colors.black12),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/images/favorite.png',
                                width: 40,
                                height: 40,
                              ),
                              Text('My Favorite',
                                  style: TextStyle(
                                    fontFamily: 'Sans',
                                    fontSize: 18,
                                    color: Colors.black,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isHide = true;
                            });
                            AdmobAds.createInterstitialAd(50, () {
                              setState(() {
                                isHide = false;
                              });
                              //cần làm sau khi tắt quảng cáo
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Frequently()),
                              );
                            });
                          },
                          child: Container(
                            width: width - 10,
                            height: 150,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1.5, color: Colors.black12),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/like.png',
                                  width: 40,
                                  height: 40,
                                ),
                                Text('Hot characters',
                                    style: TextStyle(
                                      fontFamily: 'Sans',
                                      fontSize: 18,
                                      color: Colors.black,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            isHide == false
                ? Container()
                : Container(
                    width: width,
                    height: height,
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
          ],
        ));
  }
}

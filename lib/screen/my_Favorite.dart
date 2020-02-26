import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:special_character/constaints/constaints.dart';
import 'package:special_character/util/native.dart';
import 'package:special_character/util/sharePre.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:edge_alert/edge_alert.dart';

class myFavotite extends StatefulWidget {
  @override
  _myFavotiteState createState() => _myFavotiteState();
}

class _myFavotiteState extends State<myFavotite> {
  List<String> favorite = [];
  @override
  void initState() {
    // TODO: implement initState
    SharePre().getList("list").then((list) {
      setState(() {
        favorite = list;
        // print(list);
      });
    });

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

  String dropdownMore = '';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF2BA4D),
        // centerTitle: true,
        title: Text(
          'Favorite character ',
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
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            underline: Container(
              color: Colors.white,
            ),
            onChanged: (String value) {
              if (value == 'Share') {
                FlutterShare.share(title: 'Share App', linkUrl: APP);
              } else if (value == 'Other application') {
                _launchURL();
              } else {
                platform.invokeListMethod("rate");
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
      body: Stack(
        children: <Widget>[
          Container(
            width: width,
            height: height,
            color: Color(0xff1D253B),
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  favorite.length == 0
                      ? Container(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Text(
                              'No Data',
                              style: TextStyle(
                                  fontFamily: 'Sans',
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(8),
                          itemCount: favorite.length,
                          itemBuilder: (BuildContext context, int index) {
                            return (Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 4, left: 4, right: 4),
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          width: width,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.black38),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 50,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  child: Center(
                                                    child: Text(
                                                      favorite[index],
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        // fontWeight:
                                                        //     FontWeight.bold
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: DropdownButton(
                                                  icon: Icon(
                                                    Icons.more_vert,
                                                    color: Color(0xffF2BA4D),
                                                    size: 24,
                                                  ),
                                                  elevation: 3,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  underline: Container(
                                                    color: Colors.white,
                                                  ),
                                                  onChanged: (String value) {
                                                    if (value == 'Copy') {
                                                      ClipboardManager
                                                              .copyToClipBoard(
                                                                  favorite[
                                                                      index])
                                                          .then((result) {
                                                        final snackBar =
                                                            SnackBar(
                                                          content: Text(
                                                              'Copied to Clipboard'),
                                                          action:
                                                              SnackBarAction(
                                                            label: 'Undo',
                                                            onPressed: () {},
                                                          ),
                                                        );
                                                        Scaffold.of(context)
                                                            .showSnackBar(
                                                                snackBar);
                                                      });
                                                    } else if (value ==
                                                        'Delete') {
                                                      favorite.removeAt(index);
                                                      EdgeAlert.show(
                                                        context,
                                                        title: 'Delete',
                                                        description:
                                                            'successful!!!',
                                                        gravity: EdgeAlert.TOP,

                                                        backgroundColor:
                                                            Colors.red,
                                                        //icon: Icon(Icons.done),
                                                      );
                                                      setState(() {
                                                        SharePre().setList(
                                                            "list", favorite);
                                                      });
                                                    } else {
                                                      FlutterShare.share(
                                                        title: 'share',
                                                        text: favorite[index],
                                                      );
                                                    }
                                                  },
                                                  items: <String>[
                                                    'Copy',
                                                    'Send',
                                                    'Delete',
                                                  ].map<
                                                      DropdownMenuItem<
                                                          String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                            String>(
                                                        value: value,
                                                        child: Text(value));
                                                  }).toList(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          left: 0,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(40)),
                                            child: Container(
                                              width: 45,
                                              height: 45,
                                              color: Color(0xffF2BA4D),
                                              child: Icon(
                                                Icons.star,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ))
                              ],
                            ));
                          },
                        )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

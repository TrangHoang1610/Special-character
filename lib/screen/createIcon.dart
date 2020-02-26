import 'package:flutter/material.dart';
import 'package:special_character/util/exapndingnav.dart';
import 'package:special_character/util/readJson.dart';
import 'package:flutter_fab_dialer/flutter_fab_dialer.dart';
import 'package:special_character/util/sharePre.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:edge_alert/edge_alert.dart';

class CreateIcon extends StatefulWidget {
  final myControler = TextEditingController();
  @override
  _CreateIconState createState() => _CreateIconState();
}

class _CreateIconState extends State<CreateIcon> {
  final myControler = TextEditingController();

  List<String> face = [];
  List<String> eyes = [];
  List<String> mouth = [];
  List<String> hands = [];
  List<String> ears = [];
  List<String> more = [];
  List<String> favorite = [];
  var pageIndex = 0;
  PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  // void initState() {
  //   // TODO: implement initState

  //   super.initState();
  // }

  void initState() {
    // TODO: implement initState
    loadAsset('iconFace').then((list) {
      setState(() {
        face = list;
      });
    });
    loadAsset('iconEye').then((list) {
      setState(() {
        eyes = list;
      });
    });
    loadAsset('iconMouth').then((list) {
      setState(() {
        mouth = list;
      });
    });
    loadAsset('iconHand').then((list) {
      setState(() {
        hands = list;
      });
    });
    loadAsset('iconEar').then((list) {
      setState(() {
        ears = list;
      });
    });
    loadAsset('iconMore').then((list) {
      setState(() {
        more = list;
      });
    });
    SharePre().getList("list").then((list) {
      favorite = list;
      // print(list);
    });

    super.initState();
  }

  add(String text) {
    //print(text);
    setState(() {
      myControler.text = myControler.text + text;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var _fabMiniMenuItemList = [
      new FabMiniMenuItem.withText(
          new Icon(
            Icons.send,
            color: Color(0xff1D253B),
          ),
          Color(0xffF2BA4D),
          10.0,
          "", () {
        FlutterShare.share(
          title: 'share',
          text: myControler.text.toString(),
        );
      }, "Sent", Color(0xffF2BA4D), Color(0xff1D253B), true),
      new FabMiniMenuItem.withText(
          new Icon(
            Icons.content_copy,
            color: Color(0xff1D253B),
          ),
          Color(0xffF2BA4D),
          10.0,
          "", () {
        ClipboardManager.copyToClipBoard(myControler.text.toString())
            .then((result) {
          final snackBar = SnackBar(
            content: Text('Copied to Clipboard'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {},
            ),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        });
      }, "Copy", Color(0xffF2BA4D), Color(0xff1D253B), true),
      new FabMiniMenuItem.withText(
          new Icon(
            Icons.favorite,
            color: Color(0xff1D253B),
          ),
          Color(0xffF2BA4D),
          10.0,
          "", () {
        favorite.add(myControler.text.toString());
        SharePre().setList("list", favorite);
        //print(favorite);
        // print("==============");
        EdgeAlert.show(
          context,
          title: 'Done',
          description: 'successful!!!',
          gravity: EdgeAlert.TOP,

          backgroundColor: Colors.green,
          //icon: Icon(Icons.done),
        );
      }, "Add to favorite", Color(0xffF2BA4D), Color(0xff1D253B), true),
    ];
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 110.0),
            child: Container(
              color: Colors.white,
              child: PageView(
                  physics: BouncingScrollPhysics(),
                  controller: pageController,
                  onPageChanged: onPageChanged,
                  children: <Widget>[
                    Container(
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: face.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 6),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // print(face[index]);
                              add(face[index]);
                            },
                            child: Container(
                              width: width / 6,
                              height: width / 6,
                              color: Colors.white,
                              child: Center(child: Text(face[index])),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: eyes.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 6),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // print(face[index]);
                              add(eyes[index]);
                            },
                            child: Container(
                              width: width / 6,
                              height: width / 6,
                              color: Colors.white,
                              child: Center(child: Text(eyes[index])),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: mouth.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 6),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // print(face[index]);
                              add(mouth[index]);
                            },
                            child: Container(
                              width: width / 6,
                              height: width / 6,
                              color: Colors.white,
                              child: Center(child: Text(mouth[index])),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: hands.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 6),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // print(face[index]);
                              add(hands[index]);
                            },
                            child: Container(
                              width: width / 6,
                              height: width / 6,
                              color: Colors.white,
                              child: Center(child: Text(hands[index])),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: ears.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 6),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // print(face[index]);
                              add(ears[index]);
                            },
                            child: Container(
                              width: width / 6,
                              height: width / 6,
                              color: Colors.white,
                              child: Center(child: Text(ears[index])),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: more.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 6),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // print(face[index]);
                              add(more[index]);
                            },
                            child: Container(
                              width: width / 6,
                              height: width / 6,
                              color: Colors.white,
                              child: Center(child: Text(more[index])),
                            ),
                          );
                        },
                      ),
                    )
                  ]),
            ),
          ),
          Positioned(
            top: 30,
            left: 0,
            child: Container(
              width: width,
              decoration: BoxDecoration(
                border: Border.all(width: 3, color: Colors.white),
                borderRadius: BorderRadius.circular(10),
                color: Colors.black12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(),
                  Container(
                    //width: width - 30,
                    width: width - 100,
                    height: 80,
                    child: TextField(
                      maxLines: 3,
                      controller: myControler,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        //hintText: 'Nhập để quy đổi (abc...)'),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      myControler.clear();
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xff1D253B),
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          new FabDialer(_fabMiniMenuItemList, Color(0xffF2BA4D),
              new Icon(Icons.add, color: Color(0xff1D253B))),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Color(0xffF2BA4D),
      //   child: Icon(
      //     Icons.add,
      //     size: 28,
      //     color: Color(0xff1D253B),
      //   ),
      //   onPressed: () {},
      // ),
      bottomNavigationBar: ExpandingBottomBar(
        backgroundColor: Color(0xffF2BA4D),
        navBarHeight: 50.0,
        items: [
          ExpandingBottomBarItem(
              icon: Icons.face, text: "Face", selectedColor: Color(0xff1D253B)),
          ExpandingBottomBarItem(
              icon: Icons.panorama_fish_eye,
              text: "Eye",
              selectedColor: Color(0xff1D253B)),
          ExpandingBottomBarItem(
              icon: Icons.mouse,
              text: "Mouth",
              selectedColor: Color(0xff1D253B)),
          ExpandingBottomBarItem(
              icon: Icons.drag_handle,
              text: "Hand",
              selectedColor: Color(0xff1D253B)),
          ExpandingBottomBarItem(
              icon: Icons.phonelink_erase,
              text: "Ears",
              selectedColor: Color(0xff1D253B)),
          ExpandingBottomBarItem(
              icon: Icons.more_vert,
              text: "More",
              selectedColor: Color(0xff1D253B)),
        ],
        selectedIndex: pageIndex,
        onIndexChanged: navigationTapped,
      ),
    );
  }

  void onPageChanged(int value) {
    setState(() {
      pageIndex = value;
    });
  }

  void navigationTapped(int value) {
    pageController.animateToPage(value,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }
}

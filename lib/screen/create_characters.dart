import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:special_character/api/api.dart';
import 'package:special_character/util/readJson.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:special_character/util/sharePre.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:edge_alert/edge_alert.dart';

class Create extends StatefulWidget {
  @override
  _Create createState() => _Create();
}

class _Create extends State<Create> {
  List<String> listName = [];
  List<String> searchs_left = [];
  List<String> searchs_center = [];
  List<String> searchs_right = [];
  List<String> hot_character = [];
  List<String> favorite = [];

  final myControler = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    loadAsset('left').then((list) {
      setState(() {
        searchs_left = list;
      });
    });

    loadAsset('right').then((list) {
      setState(() {
        searchs_right = list;
      });
    });
    // loadAsset('hot_character').then((list) {
    //   setState(() {
    //     hot_character = list;
    //     print(hot_character.length);
    //   });
    // });
    SharePre().getList("list").then((list) {
      setState(() {
        favorite = list;
        // print(list);
      });
    });
    super.initState();
  }

  Widget _selectPopup(String text, double width) => PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text("Add to the left"),
          ),
          PopupMenuItem(
            value: 2,
            child: Text("Add to the right"),
          ),
        ],
        initialValue: 1,
        onSelected: (value) {
          if (value == 1) {
            myControler.text = text + myControler.text;
          } else {
            myControler.text = myControler.text + text;
          }
        },
        child: Container(
          width: width / 6,
          height: width / 6,
          child: Center(
            child: Text(text),
          ),
        ),
      );

  String _currentSelectedValue_left = '';
  String _currentSelectedValue3_right = '';
  String dropdownMore = '';
  bool isHide = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        // ),
        body: Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Stack(
        children: <Widget>[
          Container(
            width: width,
            height: height,
            color: Color(0xffF2EC72),
          ),
          Positioned.fill(
            child:
                //   SlidingUpPanel(
                // maxHeight: height,
                // minHeight: 150,
                // body:
                SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 3, color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black12,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: width - 80,
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: TextField(
                                        controller: myControler,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText:
                                              'Enter to convert (abc ...)',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 50,
                                    height: 50,
                                    // decoration: BoxDecoration(
                                    //   //border: Border.all(width: 1, color: Colors.white),
                                    //   borderRadius: BorderRadius.circular(5),
                                    //   color: Colors.black,
                                    // ),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (myControler.text == "") {
                                          showDialog<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Notification !',
                                                    style: TextStyle(
                                                      fontFamily: 'Sans',
                                                      fontSize: 16,
                                                      color: Colors.black87,
                                                    )),
                                                content: const Text(
                                                    'You need input character...',
                                                    style: TextStyle(
                                                      fontFamily: 'Sans',
                                                      fontSize: 16,
                                                      color: Colors.black87,
                                                    )),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: Text('Ok'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      setState(() {});
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                        // print(myControler.text.toString());
                                        setState(() {
                                          isHide = true;
                                        });
                                        getName(
                                                myControler.text.toString(),
                                                _currentSelectedValue_left,
                                                _currentSelectedValue3_right)
                                            .then((list) {
                                          setState(() {
                                            isHide = false;
                                            listName = new List<String>();
                                            list.forEach((e) {
                                              listName.add(e.toString());
                                            });
                                          });
                                        });
                                      },
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.white,
                                        size: 32.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                              decoration: InputDecoration(
                                errorStyle: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 16.0,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                              ),
                              // isEmpty: _currentSelectedValue == '',
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Text('Left :   ',
                                            style: TextStyle(
                                              fontFamily: 'Sans',
                                              fontSize: 16,
                                              color: Colors.black87,
                                            )),
                                        Text(_currentSelectedValue_left),
                                      ],
                                    ),
                                  ),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      // value: _currentSelectedValue,
                                      isDense: true,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          _currentSelectedValue_left = newValue;
                                          // print(_currentSelectedValue);
                                          state.didChange(newValue);
                                        });
                                      },
                                      items: searchs_left.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  )
                                ],
                              ));
                        },
                        initialValue: _currentSelectedValue_left,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                              decoration: InputDecoration(
                                errorStyle: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 16.0,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                              ),
                              // isEmpty: _currentSelectedValue == '',
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Text('Right :   ',
                                            style: TextStyle(
                                              fontFamily: 'Sans',
                                              fontSize: 16,
                                              color: Colors.black87,
                                            )),
                                        Text(_currentSelectedValue3_right),
                                      ],
                                    ),
                                  ),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      // value: _currentSelectedValue,
                                      isDense: true,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          _currentSelectedValue3_right =
                                              newValue;
                                          // print(_currentSelectedValue);
                                          state.didChange(newValue);
                                        });
                                      },
                                      items: searchs_right.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  )
                                ],
                              ));
                        },
                        initialValue: _currentSelectedValue3_right,
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 200),
                        child: listName.length > 0
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(8),
                                itemCount: listName.length,
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      width: 50,
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        child: Center(
                                                          child: Text(
                                                            listName[index],
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: DropdownButton(
                                                        icon: Icon(
                                                          Icons.more_vert,
                                                          color:
                                                              Color(0xffF2BA4D),
                                                          size: 24,
                                                        ),
                                                        elevation: 3,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                        ),
                                                        underline: Container(
                                                          color: Colors.white,
                                                        ),
                                                        onChanged:
                                                            (String value) {
                                                          if (value == 'Copy') {
                                                            ClipboardManager
                                                                    .copyToClipBoard(
                                                                        listName[
                                                                            index])
                                                                .then((result) {
                                                              final snackBar =
                                                                  SnackBar(
                                                                content: Text(
                                                                    'Copied to Clipboard'),
                                                                action:
                                                                    SnackBarAction(
                                                                  label: 'Undo',
                                                                  onPressed:
                                                                      () {},
                                                                ),
                                                              );
                                                              Scaffold.of(
                                                                      context)
                                                                  .showSnackBar(
                                                                      snackBar);
                                                            });
                                                          } else if (value ==
                                                              'Add to favorite') {
                                                            favorite.add(
                                                                listName[
                                                                    index]);
                                                            EdgeAlert.show(
                                                              context,
                                                              title: 'Done',
                                                              description:
                                                                  'successful!!!',
                                                              gravity:
                                                                  EdgeAlert.TOP,

                                                              backgroundColor:
                                                                  Colors.green,
                                                              //icon: Icon(Icons.done),
                                                            );
                                                            SharePre().setList(
                                                                "list",
                                                                favorite);
                                                          } else {
                                                            FlutterShare.share(
                                                              title: 'share',
                                                              text: listName[
                                                                  index],
                                                            );
                                                          }
                                                        },
                                                        items: <String>[
                                                          'Send',
                                                          'Copy',
                                                          'Add to favorite',
                                                        ].map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                            (String value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  40)),
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
                            : Container(),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // panel: Container(
            //   child: Column(
            //     children: <Widget>[
            //       Icon(
            //         Icons.file_upload,
            //         color: Colors.black54,
            //         size: 32,
            //       ),
            //       Expanded(
            //         flex: 1,
            //         child: GridView.builder(
            //           shrinkWrap: true,
            //           itemCount: hot_character.length,
            //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //               crossAxisCount: 6),
            //           itemBuilder: (context, index) {
            //             return _selectPopup(hot_character[index], width);
            //             // : GestureDetector(
            //             //     onTap: () {
            //             //       myControler.text = hot_character[index];
            //             //       setState(() {});
            //             //     },
            //             //     child: Text(hot_character[index]),
            //             //   );
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
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
      ),
    ));
  }
}

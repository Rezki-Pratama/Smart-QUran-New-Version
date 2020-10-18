import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:smart_quran_new_version/model/model_list_detail_ayat.dart'
    as detailAyat;
import 'package:smart_quran_new_version/model/model_list_ayat.dart';
import 'package:http/http.dart' as http;

class DetailAyat extends StatefulWidget {
  // Declare a field that holds the Todo.
  final ModelListAyat todo;

  // In the constructor, require a Todo.
  DetailAyat({Key key, @required this.todo}) : super(key: key);

  @override
  _DetailAyatState createState() => _DetailAyatState();
}

class _DetailAyatState extends State<DetailAyat>
    with SingleTickerProviderStateMixin {
  List<detailAyat.ModelDetailAyat> _faq = List<detailAyat.ModelDetailAyat>();
  List<detailAyat.ModelDetailAyat> _faqForDisplay =
      List<detailAyat.ModelDetailAyat>();
  AudioPlayer player = new AudioPlayer();
  int buttonPlayer = 0;
  AnimationController animationController;
  Animation<double> opacityAnimation;

  Future<List<detailAyat.ModelDetailAyat>> fetchAyat() async {
    print(widget.todo.nomor);
    print(widget.todo.ayat);
    final String url =
        'https://api.quran.sutanlab.id/surah/${widget.todo.nomor}';
    final response = await http.get(url);
    var faqs = List<detailAyat.ModelDetailAyat>();
    if (response.statusCode == 200) {
      var notesJson = json.decode(utf8.decode(response.bodyBytes));
      print(notesJson['data']['verses']);
      for (var noteJson in notesJson['data']['verses']) {
        faqs.add(detailAyat.ModelDetailAyat.fromJson(noteJson));
      }
    } else {
      throw Exception('Failed to load List Ayat');
    }
    return faqs;
  }

  @override
  void initState() {
    animationController =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn))
      ..addListener(() {
        setState(() {});
      });

    fetchAyat().then((value) {
      setState(() {
        _faq.addAll(value);
        _faqForDisplay = _faq;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
        body: Container(
      color: Color(0xFFe4f2f5),
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.0, left: 10.0),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Color(0xFF4ba592),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 8),
                Text(
                  'Smart Quran',
                  style: TextStyle(
                      color: Color(0xFF4ba592),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Container(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFe4f2f5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView(primary: false, children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 3.0, bottom: 10, left: 3),
                        child: Container(
                            height: MediaQuery.of(context).size.height / 1.2,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.fromLTRB(
                                              8.0, 20.0, 8.0, 3.0),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              _faqForDisplay[index].text.arab,
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  color: Color(0xFF4ba592),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                          )),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        if (!_faqForDisplay[
                                                                index]
                                                            .isTafsir) {
                                                          setState(() =>
                                                              _faqForDisplay[
                                                                          index]
                                                                      .isTafsir =
                                                                  true);
                                                          animationController
                                                              .forward();
                                                        } else {
                                                          setState(() =>
                                                              _faqForDisplay[
                                                                          index]
                                                                      .isTafsir =
                                                                  false);
                                                          animationController
                                                              .reverse();
                                                        }
                                                      },
                                                      child: Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                        ),
                                                        color:
                                                            Color(0xFF4ba592),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: Text(
                                                            'Tafsir',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      color: Color(0xFF4ba592),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Text(
                                                          'Arti',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      color: Color(0xFF4ba592),
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: InkWell(
                                                            onTap: (!_faqForDisplay[
                                                                        index]
                                                                    .isSelected)
                                                                ? () {
                                                                    setState(
                                                                        () {
                                                                      _faqForDisplay[index]
                                                                              .isSelected =
                                                                          true;
                                                                      _faqForDisplay[index]
                                                                              .buttonPlayer =
                                                                          true;
                                                                    });

                                                                    player.play(_faqForDisplay[
                                                                            index]
                                                                        .audio
                                                                        .primary);
                                                                  }
                                                                : () {
                                                                    if (_faqForDisplay[
                                                                            index]
                                                                        .buttonPlayer) {
                                                                      player
                                                                          .pause();
                                                                      setState(() =>
                                                                          _faqForDisplay[index].buttonPlayer =
                                                                              false);
                                                                    } else {
                                                                      player.play(_faqForDisplay[
                                                                              index]
                                                                          .audio
                                                                          .primary);
                                                                      setState(() =>
                                                                          _faqForDisplay[index].buttonPlayer =
                                                                              true);
                                                                    }
                                                                  },
                                                            child: Icon(
                                                              (_faqForDisplay[
                                                                          index]
                                                                      .buttonPlayer)
                                                                  ? Icons.pause
                                                                  : Icons
                                                                      .play_arrow,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )),
                                                    ),
                                                    (_faqForDisplay[index]
                                                            .isSelected)
                                                        ? Card(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0),
                                                            ),
                                                            color: Color(
                                                                0xFF4ba592),
                                                            child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    player
                                                                        .stop();
                                                                    setState(() =>
                                                                        _faqForDisplay[index].isSelected =
                                                                            false);
                                                                    setState(() =>
                                                                        _faqForDisplay[index].buttonPlayer =
                                                                            false);
                                                                  },
                                                                  child: Icon(
                                                                    Icons.close,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                )),
                                                          )
                                                        : Container()
                                                  ],
                                                )
                                              ],
                                            ),
                                            (_faqForDisplay[index].isTafsir)
                                                ? Opacity(
                                                    opacity:
                                                        opacityAnimation.value,
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12.0),
                                                        child: Text(
                                                            _faqForDisplay[
                                                                    index]
                                                                .tafsir
                                                                .id
                                                                .short),
                                                      ),
                                                    ),
                                                  )
                                                : Container()
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                              itemCount: _faqForDisplay.length,
                            ))),
                  ]),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}

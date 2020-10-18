import 'dart:convert';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:smart_quran_new_version/model/model_list_ayat.dart';
import 'package:smart_quran_new_version/pages/detail_ayat.dart';

class ListAyat extends StatefulWidget {
  @override
  _ListAyatState createState() => _ListAyatState();
}

class _ListAyatState extends State<ListAyat> {
  @override
  List<ModelListAyat> _faq = List<ModelListAyat>();
  List<ModelListAyat> _faqForDisplay = List<ModelListAyat>();

  Future<List<ModelListAyat>> fetchNotes() async {
    final String url = 'https://api.banghasan.com/quran/format/json/surat';
    final response = await http.get(url);

    var faqs = List<ModelListAyat>();

    if (response.statusCode == 200) {
      var notesJson = json.decode(utf8.decode(response.bodyBytes));
      for (var noteJson in notesJson['hasil']) {
        faqs.add(ModelListAyat.fromJson(noteJson));
      }
    } else {
      throw Exception('Failed to load List Ayat');
    }

    return faqs;
  }

  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _faq.addAll(value);
        _faqForDisplay = _faq;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Color(0xFFe4f2f5),
      child: ListView(
        children: <Widget>[
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
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Color(0xFFe4f2f5),
            ),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView(primary: false, children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 0, bottom: 0, left: 3),
                      child: Column(
                        children: [
                          _searchBar(),
                          FutureBuilder(
                            future: fetchNotes(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Container(
                                    height: MediaQuery.of(context).size.height /
                                        1.3,
                                    child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        return _listItem(index);
                                      },
                                      itemCount: _faqForDisplay.length,
                                    ));
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container(
                                  alignment: Alignment.topCenter,
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  child: FlareActor(
                                    'assets/flare/SmartQuran.flr',
                                    animation: 'loading',
                                    fit: BoxFit.cover,
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Text('Periksa Koneksi Anda'),
                                );
                              }
                            },
                          ),
                        ],
                      )),
                ]),
              ),
            ),
          )
        ],
      ),
    ));
  }

  _searchBar() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: TextField(
          style: TextStyle(color: Color(0xFF4ba592), fontFamily: "JosefinSans"),
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintStyle: TextStyle(
                  fontSize: 17.0,
                  color: Colors.grey,
                  fontFamily: "JosefinSans"),
              hintText: 'Cari...',
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))),
          onChanged: (text) {
            text = text.toLowerCase();
            setState(() {
              _faqForDisplay = _faq.where((note) {
                var noteTitle = note.nama.toLowerCase();
                return noteTitle.contains(text);
              }).toList();
            });
          },
        ),
      ),
    );
  }

  _listItem(index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailAyat(todo: _faqForDisplay[index])),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Center(
                            child: Icon(
                              FontAwesomeIcons.certificate,
                              color: Color(0xFF4ba592),
                              size: 35.0,
                            ),
                          ),
                          Center(
                              child: Text(
                            _faqForDisplay[index].nomor,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white),
                          )),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        _faqForDisplay[index].nama,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4ba592),
                            fontFamily: "JosefinSans"),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      _faqForDisplay[index].asma,
                      style: GoogleFonts.harmattan(
                          color: Color(0xFF4ba592),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                color: Color(0xFF4ba592),
                height: 2,
                width: MediaQuery.of(context).size.width,
              ),
            )
          ],
        ),
      ),
    );
  }
}

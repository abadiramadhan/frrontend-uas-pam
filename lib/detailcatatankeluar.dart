import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailCatatanKeluar extends StatefulWidget {
  List list;
  int index;
  DetailCatatanKeluar({this.index, this.list});

  @override
  _DetailCatatanKeluarState createState() => new _DetailCatatanKeluarState();
}

class _DetailCatatanKeluarState extends State<DetailCatatanKeluar> {
  Future<List> getData() async {
    var id = widget.list[widget.index]['id_kategori'];
    print(id);
    final response = await http
        .get("http://10.0.2.2/backend-financial-record/catatan/catatanKeluar?id=$id");
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      print(result);
      return result['data'];
    } else {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Detail Lap. Keluar ${widget.list[widget.index]['nama_kategori']}")),
     
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new ItemList(
                  list: snapshot.data,
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        // return new Text(list[i]['nama']);
        // return new ListTile(
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
           
            child: new Card(
              child: new ListTile(
                title: new Text(list[i]['nama_kategori']),
                leading: new Icon(Icons.widgets),
                subtitle: new Text('Nominal : ${list[i]['nominal']} / Tanggal : ${list[i]['tanggal']} / Jenis : ${list[i]['jenis']}'),
              ),
            ),
          ),
        );
      },
    );
  }
}

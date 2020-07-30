import 'package:flutter/material.dart';
import 'package:uas_pam/adddata.dart';
import './detail.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  Future<List> getData() async {
    final response = await http
        .get("http://10.0.2.2/backend-financial-record/kategori/kategoriGet");
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      print(result['data']);
      return result['data'];
    } else {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Kategori Riwayat Keuangan"),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (BuildContext context) => new AddData(),
          ),
        ),
      ),
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
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) =>
                    new Detail(list: list, index: i))),
            child: new Card(
              child: new ListTile(
                title: new Text(list[i]['nama_kategori']),
                leading: new Icon(Icons.widgets),
                subtitle: new Text('Nominal : ${list[i]['nominal']}'),
              ),
            ),
          ),
        );
      },
    );
  }
}

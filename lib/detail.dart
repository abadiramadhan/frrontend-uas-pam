import 'package:flutter/material.dart';
// import './editdata.dart';
import 'package:http/http.dart' as http;
import 'package:uas_pam/editdata.dart';
import 'package:uas_pam/kategori.dart';
import 'dart:async';
import 'dart:convert';

class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({this.index, this.list});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {

  Future<bool> deleteData() async {
    print("masuk");
    final url = 'http://10.0.2.2/backend-financial-record/kategori/kategoriDelete';
    final response = await http.post(url, body: {
      "id_kategori": widget.list[widget.index]['id_kategori']
    });
    final result = json.decode(response.body);
    if (response.statusCode == 200 && result['status'] == 'success') {
      Widget okButton = FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          });

      AlertDialog alert = AlertDialog(
        // title: Text("My title"),
        content: Text(result['message']),
        actions: [
          okButton,
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
      return true;
    }
    return false;
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
          "Apakah yakin kamu akan hapus data ini '${widget.list[widget.index]['nama_kategori']}'?"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text(
            "OK, Hapus Data!",
            style: new TextStyle(color: Colors.black),
          ),
          color: Colors.red,
          onPressed: () {
            deleteData();
            Navigator.of(context, rootNavigator: true).pop(context);
          },
        ),
        new RaisedButton(
          child: new Text(
            "Cancel",
            style: new TextStyle(color: Colors.black),
          ),
          color: Colors.green,
          onPressed: () =>
              Navigator.of(context, rootNavigator: true).pop(context),
        )
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Detail ${widget.list[widget.index]['nama_kategori']}"),
      ),
      body: new Container(
        height: 250.0,
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          child: new Center(
              child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.only(top: 30.0),
              ),
              new Text(
                widget.list[widget.index]['nama_kategori'],
                style: new TextStyle(fontSize: 20.0),
              ),
              new Text(
                "Id Kategori : ${widget.list[widget.index]['id_kategori']}",
                style: new TextStyle(fontSize: 18.0),
              ),
              new Text(
                "Nominal Kategori: ${widget.list[widget.index]['nominal']}",
                style: new TextStyle(fontSize: 18.0),
              ),
              // new Text(widget.list[widget.index]['nama'], style: new TextStyle(fontSize: 18.0),),
              new Padding(
                padding: const EdgeInsets.only(top: 30.0),
              ),

              new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new RaisedButton(
                    child: new Text("Edit Kategori"),
                    color: Colors.green,
                    onPressed: () =>
                        Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new EditData(
                        list: widget.list,
                        index: widget.index,
                      ),
                    )),
                  ),
                  new RaisedButton(
                    child: new Text("Delete Kategori"),
                    color: Colors.red,
                    onPressed: () => confirm(),
                  )
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}

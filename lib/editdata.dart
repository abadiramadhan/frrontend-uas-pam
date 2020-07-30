import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uas_pam/kategori.dart';
import 'dart:async';
import 'dart:convert';

class EditData extends StatefulWidget {
  final List list;
  final int index;

  EditData({this.list, this.index});
  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  TextEditingController controllerNama;
  TextEditingController controllerNominal;

  Future<bool> editData() async {
    int nominal_lama = int.parse(widget.list[widget.index]['nominal']);
    int nominal_baru = int.parse(controllerNominal.text);
    int hitung_nominal = 0;
    var jenis = "";

    if (nominal_baru > nominal_lama) {
      hitung_nominal = nominal_lama + nominal_baru;
      jenis ="masuk";
    } else {
      hitung_nominal = nominal_lama - nominal_baru;
      jenis ="keluar";
    }

    final url = 'http://10.0.2.2/backend-financial-record/kategori/kategoriUpdate';
    final response = await http.put(url, body: {
      "id_kategori": widget.list[widget.index]['id_kategori'],
      "nama_kategori": controllerNama.text,
      "nominal": hitung_nominal.toString(),
      "jenis": jenis
    });
    // print(response);
    final result = json.decode(response.body);
    if (response.statusCode == 200 && result['status'] == 'success') {
      // notifyListeners();
      // return true;
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
    }
    return false;
  }

  @override
  void initState() {
    controllerNama = new TextEditingController(
        text: widget.list[widget.index]['nama_kategori']);
    controllerNominal =
        new TextEditingController(text: widget.list[widget.index]['nominal']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Kelola Riwayat Keuangan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            new Column(
              children: <Widget>[
                new TextField(
                  controller: controllerNama,
                  decoration: new InputDecoration(
                      hintText: "Nama Kategori", labelText: "Nama kategori"),
                ),
                new TextField(
                  keyboardType: TextInputType.number,
                  controller: controllerNominal,
                  decoration: new InputDecoration(
                      hintText: "Nominal kategori",
                      labelText: "Nominal kategori"),
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                new RaisedButton(
                  child: new Text("Proses Riwayat Keuangan"),
                  color: Colors.blueAccent,
                  onPressed: () {
                    if (controllerNama.text.length == 0) {
                      Widget okButton = FlatButton(
                        child: Text("OK"),
                        onPressed: () =>
                            Navigator.of(context, rootNavigator: true)
                                .pop(context),
                      );

                      AlertDialog alert = AlertDialog(
                        // title: Text("My title"),
                        content: Text("Kolom input nama masih kosong."),
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
                      // print("kosong bray");
                    } else if (controllerNominal.text.length == 0) {
                      Widget okButton = FlatButton(
                        child: Text("OK"),
                        onPressed: () =>
                            Navigator.of(context, rootNavigator: true)
                                .pop(context),
                      );

                      AlertDialog alert = AlertDialog(
                        // title: Text("My title"),
                        content: Text("Kolom input nominal masih kosong."),
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
                      // print("kosong bray");
                    } else {
                      editData();

                      // Navigator.pop(context);
                      // Navigator.of(context).push(new MaterialPageRoute(
                      //     builder: (BuildContext context) => new MyApp()));
                    }
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

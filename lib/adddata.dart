import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uas_pam/kategori.dart';
import 'dart:async';
import 'dart:convert';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController controllerNama = new TextEditingController();
  TextEditingController controllerNominal = new TextEditingController();

  // void addData() {

  Future<bool> storeKategori() async {
    print("masuk");
    final url = 'http://10.0.2.2/backend-financial-record/kategori/kategoriAdd';
    final response = await http.post(url, body: {
      "nama_kategori": controllerNama.text,
      "nominal": controllerNominal.text
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
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Tambah Data Kategori"),
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
                      hintText: "Nama kategori", labelText: "Nama kategori"),
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
                  child: new Text("Tambah Data Kategori"),
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
                      storeKategori();

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

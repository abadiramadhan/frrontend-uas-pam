import 'package:flutter/material.dart';
import 'package:uas_pam/catatanall.dart';
import 'package:uas_pam/catatankeluar.dart';
import 'package:uas_pam/catatanmasuk.dart';
import './kategori.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
           Container(
            padding: EdgeInsets.all(16.0),
            margin: const EdgeInsets.only(top: 150.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Aplikasi Sederhana Riwayat Keuangan",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                // Text(
                //   "Nama : Nur Abadi Ramadhan",
                //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                // )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            margin: const EdgeInsets.only(top: 30.0),
            height: 600.0,
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 3 / 2),
              children: <Widget>[
                _listKategori(),
                _listRiwayat(),
                _laporanMasuk(),
                _laporanKeluar(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _listKategori() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          // backgroundColor: Color(0xff94d500),
          backgroundColor: Colors.blue,
          child: IconButton(
            icon: Icon(
              Icons.category,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
          ),
        ),
        Text('Kategori Riwayat Keuangan'),
      ],
    );
  }

  _listRiwayat() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          // backgroundColor: Color(0xff94d500),
          backgroundColor: Colors.blue,
          child: IconButton(
            icon: Icon(
              Icons.history,
              color: Colors.black,
            ),
            onPressed: () {
               Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CatatanAll()));
            },
          ),
        ),
        Text('History Riwayat Keuangan All'),
      ],
    );
  }

  _laporanMasuk() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          // backgroundColor: Color(0xff94d500),
          backgroundColor: Colors.blue,
          child: IconButton(
            icon: Icon(
              Icons.list,
              color: Colors.black,
            ),
            onPressed: () {
               Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CatatanMasuk()));
            },
          ),
        ),
        Text('Lap. Keuangan Masuk'),
      ],
    );
  }

  _laporanKeluar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          // backgroundColor: Color(0xff94d500),
          backgroundColor: Colors.blue,
          child: IconButton(
            icon: Icon(
              Icons.list,
              color: Colors.black,
            ),
            onPressed: () {
               Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CatatanKeluar()));
            },
          ),
        ),
        Text('Lap. Keuangan Keluar'),
      ],
    );
  }

}

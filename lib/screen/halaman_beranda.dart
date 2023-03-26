import 'package:apk/model/response_barang_model.dart';
import 'package:apk/service/api_service.dart';
import 'package:apk/widgets/item_barang.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apk/screen/halaman_tambah_edit.dart';

class HalamanBeranda extends StatelessWidget {
  static const String id = "Halaman Beranda";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplikasi Inventory'),
      ),
      body: GridBarang(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HalamanTambahEdit(barang: null,)));
        },
      ),
    );
  }
}

class GridBarang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<List<Barang>>(
              future: ApiService.getListBarang(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  List<Barang> listBarang = snapshot.data;

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: listBarang?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        splashColor: Colors.indigo,
                        borderRadius: BorderRadius.circular(10.0),
                        child: itemBarang(listBarang[index]),
                        onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HalamanTambahEdit(
                              barang: listBarang[index]
                                )));
                        },
                      );
                    },
                  );
                }
              },
            )));
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:newsapp/app/modules/NavigasiItem/addnews.dart';
import 'package:newsapp/app/modules/NavigasiItem/update.dart';
import 'package:newsapp/app/modules/constant/model.dart';
import 'package:newsapp/app/modules/home/controllers/home_controller.dart';
import 'package:newsapp/app/modules/home/views/home_view.dart';
import 'package:http/http.dart' as http;

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  final list = <TampilNews>[];
  var loading = false;
  bool _refreshing = false;
  Future<void> _onRefresh() async {
    await _lihatdata();
  }

  _delete(String id_news) async {
    final url = Uri.parse('http://192.168.1.18/newsapp/delete.php');
    final response = await http.post(url, body: {"id_news": id_news});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['messege'];
    if (value == 1) {
      _lihatdata();
    } else {
      print(pesan);
    }
  }

  _dialogdelete(String id_news) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: ListView(
              padding: EdgeInsets.all(20),
              shrinkWrap: true,
              children: <Widget>[
                Text(
                  'Apakaha anda yakin ingin menghapus file?',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('No'),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _delete(id_news);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Ya',
                        style: const TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  

  Future _lihatdata() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final url = Uri.parse('http://192.168.1.18/newsapp/detileNews.php');
    final response = await http.get(url);

    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new TampilNews(
          api['id_news'],
          api['image'],
          api['title'],
          api['content'],
          api['description'],
          api['date_news'],
          api['id_users'],
          api['username'],
        );
        list.add(ab);
      });
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _lihatdata();
  }

  @override
  Widget build(BuildContext context) {
    final url = 'http://192.168.1.18/newsapp/upload/';
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyForm()));
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];
                return Container(
                  child: Column(
                    children: [
                      Card(
                        child: ListTile(
                          leading: Image.network(
                            url + item.image,
                            width: 100,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                          title: Text(item.title),
                          subtitle: Text(item.content),
                          onTap: () {},
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyUpdateForm(item)));
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _dialogdelete(item.id_news);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

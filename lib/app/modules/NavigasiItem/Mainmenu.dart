import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:newsapp/app/modules/NavigasiItem/categori.dart';
import 'package:newsapp/app/modules/NavigasiItem/news.dart';
import 'package:newsapp/app/modules/NavigasiItem/profil.dart';
import 'package:newsapp/app/modules/home/views/home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenu extends StatefulWidget {
  final VoidCallback signOut;
  MainMenu(this.signOut);
  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    signOut();
                  },
                  icon: Icon(Icons.logout))
            ],
          ),
          body: TabBarView(children: <Widget>[
            HomeView(),
            News(),
            Categori(),
            Profil(),
          ]),
          bottomNavigationBar: TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.home),
                  text: "Home",
                ),
                Tab(
                  icon: Icon(Icons.newspaper),
                  text: "News",
                ),
                Tab(
                  icon: Icon(Icons.category),
                  text: "Kategori",
                ),
                Tab(
                  icon: Icon(Icons.person),
                  text: "Profil",
                ),
              ])),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:responsi1/bloc/logout_bloc.dart';
import 'package:responsi1/bloc/bahasa_bloc.dart';
import 'package:responsi1/model/bahasa.dart';
import 'package:responsi1/ui/bahasa_detail.dart';
import 'package:responsi1/ui/login_page.dart';
import 'package:responsi1/ui/bahasa_form.dart';

class BahasaPage extends StatefulWidget {
  const BahasaPage({Key? key}) : super(key: key);

  @override
  _BahasaPageState createState() => _BahasaPageState();
}

class _BahasaPageState extends State<BahasaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Bahasa',
          style: TextStyle(
            fontFamily: 'Courier New', // Applying Courier New font
            color: Colors.white, // Set text color to white
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 126, 113, 205), // Dark blue
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BahasaForm()),
                );
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontFamily: 'Courier New',
                  color: Color.fromARGB(255, 72, 61, 139),
                ),
              ),
              trailing: const Icon(Icons.logout,
                  color: Color.fromARGB(255, 72, 61, 139)),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false)
                    });
              },
            )
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 189, 142, 235),
              Color.fromARGB(255, 136, 157, 244), // Purple
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FutureBuilder<List>(
          future: BahasaBloc.getBahasa(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListBahasa(list: snapshot.data)
                : const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 118, 106, 196),
                    ),
                  );
          },
        ),
      ),
    );
  }
}

class ListBahasa extends StatelessWidget {
  final List? list;

  const ListBahasa({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list!.length,
      itemBuilder: (context, i) {
        return ItemBahasa(
          bahasa: list![i],
        );
      },
    );
  }
}

class ItemBahasa extends StatelessWidget {
  final Bahasa bahasa;

  const ItemBahasa({Key? key, required this.bahasa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BahasaDetail(bahasa: bahasa),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        color: Colors.white,
        child: ListTile(
          title: Text(
            bahasa.originalLanguage!,
            style: const TextStyle(
              fontFamily: 'Courier New',
            ),
          ),
          subtitle: Text(
            'Translated: ${bahasa.translatedLanguage!}\nTranslator: ${bahasa.translatorName!}',
            style: const TextStyle(
              fontFamily: 'Courier New',
            ),
          ),
        ),
      ),
    );
  }
}

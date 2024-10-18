import 'package:flutter/material.dart';
import 'package:responsi1/bloc/bahasa_bloc.dart';
import 'package:responsi1/model/bahasa.dart';
import 'package:responsi1/ui/bahasa_form.dart';
import 'package:responsi1/ui/bahasa_page.dart';
import 'package:responsi1/widget/warning_dialog.dart';

// ignore: must_be_immutable
class BahasaDetail extends StatefulWidget {
  Bahasa? bahasa;

  BahasaDetail({Key? key, this.bahasa}) : super(key: key);

  @override
  _BahasaDetailState createState() => _BahasaDetailState();
}

class _BahasaDetailState extends State<BahasaDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Bahasa',
            style: TextStyle(color: Colors.white, fontFamily: 'Courier New')),
        backgroundColor: const Color.fromARGB(255, 126, 113, 205),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 189, 142, 235),
              Color.fromARGB(255, 136, 157, 244),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20), // Spacing at the top
            Text(
              "Original Language: ${widget.bahasa!.originalLanguage}",
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Courier New',
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Translated Language: ${widget.bahasa!.translatedLanguage}",
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontFamily: 'Courier New',
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Translator Name: ${widget.bahasa!.translatorName}",
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontFamily: 'Courier New',
              ),
            ),
            const SizedBox(height: 30), // Adding space before the buttons
            _tombolHapusEdit(),
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceEvenly, // Distributing buttons evenly
      children: [
        // Tombol Edit
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: const Color.fromARGB(
                255, 126, 113, 205), // Background color for button
          ),
          child: const Text("EDIT",
              style: TextStyle(color: Colors.white, fontFamily: 'Courier New')),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BahasaForm(
                  bahasa: widget.bahasa!,
                ),
              ),
            );
          },
        ),
        // Tombol Hapus
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 126, 113, 205),
          ),
          child: const Text("DELETE",
              style: TextStyle(color: Colors.white, fontFamily: 'Courier New')),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?",
          style: TextStyle(fontFamily: 'Courier New')),
      actions: [
        // tombol hapus
        OutlinedButton(
          child: const Text("Ya",
              style: TextStyle(
                  color: Color.fromARGB(255, 232, 125, 227),
                  fontFamily: 'Courier New')),
          onPressed: () {
            // Pastikan bahasa.id tidak null
            final id = widget.bahasa?.id;
            if (id != null) {
              BahasaBloc.deleteBahasa(id: id).then(
                (value) => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const BahasaPage()))
                },
                onError: (error) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => const WarningDialog(
                      description: "Hapus gagal, silahkan coba lagi",
                    ),
                  );
                },
              );
            } else {
              // Jika id null, tampilkan pesan error atau penanganan lain
              showDialog(
                context: context,
                builder: (BuildContext context) => const WarningDialog(
                  description: "ID bahasa tidak ditemukan.",
                ),
              );
            }
          },
        ),
        // tombol batal
        OutlinedButton(
          child: const Text("Batal",
              style: TextStyle(
                  color: Color.fromARGB(255, 232, 125, 227),
                  fontFamily: 'Courier New')),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}

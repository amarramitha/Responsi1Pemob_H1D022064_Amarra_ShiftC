import 'package:flutter/material.dart';
import 'package:responsi1/bloc/bahasa_bloc.dart';
import 'package:responsi1/model/bahasa.dart';
import 'package:responsi1/ui/bahasa_page.dart';
import 'package:responsi1/widget/warning_dialog.dart';

// ignore: must_be_immutable
class BahasaForm extends StatefulWidget {
  Bahasa? bahasa;
  BahasaForm({Key? key, this.bahasa}) : super(key: key);

  @override
  _BahasaFormState createState() => _BahasaFormState();
}

class _BahasaFormState extends State<BahasaForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "Tambah Bahasa";
  String tombolSubmit = "SIMPAN";
  final _originalLanguageController = TextEditingController();
  final _translatedLanguageController = TextEditingController();
  final _translatorNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.bahasa != null) {
      setState(() {
        judul = "Ubah Bahasa";
        tombolSubmit = "UBAH";
        _originalLanguageController.text = widget.bahasa!.originalLanguage!;
        _translatedLanguageController.text = widget.bahasa!.translatedLanguage!;
        _translatorNameController.text = widget.bahasa!.translatorName!;
      });
    } else {
      judul = "Tambah Bahasa";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          judul,
          style: const TextStyle(
            color: Colors.white, // Set text color to white
            fontFamily: 'Courier New', // Use Courier New font
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 126, 113, 205),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _originalLanguageTextField(),
                const SizedBox(height: 16.0),
                _translatedLanguageTextField(),
                const SizedBox(height: 16.0),
                _translatorNameTextField(),
                const SizedBox(height: 30.0),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // TextField untuk original language
  Widget _originalLanguageTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Original Language",
        labelStyle: TextStyle(color: Colors.white),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      keyboardType: TextInputType.text,
      controller: _originalLanguageController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Original Language harus diisi";
        }
        return null;
      },
    );
  }

  // TextField untuk translated language
  Widget _translatedLanguageTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Translated Language",
        labelStyle: TextStyle(color: Colors.white),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      keyboardType: TextInputType.text,
      controller: _translatedLanguageController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Translated Language harus diisi";
        }
        return null;
      },
    );
  }

  // TextField untuk translator name
  Widget _translatorNameTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Translator Name",
        labelStyle: TextStyle(color: Colors.white),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      keyboardType: TextInputType.text,
      controller: _translatorNameController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Translator Name harus diisi";
        }
        return null;
      },
    );
  }

  // Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 118, 106, 196),
        ),
        child: Text(tombolSubmit, style: const TextStyle(color: Colors.white)),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.bahasa != null) {
                // kondisi update bahasa
                ubah();
              } else {
                // kondisi tambah bahasa
                simpan();
              }
            }
          }
        },
      ),
    );
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Bahasa createBahasa = Bahasa(id: null);
    createBahasa.originalLanguage = _originalLanguageController.text;
    createBahasa.translatedLanguage = _translatedLanguageController.text;
    createBahasa.translatorName = _translatorNameController.text;
    BahasaBloc.addBahasa(bahasa: createBahasa).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const BahasaPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Bahasa updateBahasa = Bahasa(id: widget.bahasa!.id!);
    updateBahasa.originalLanguage = _originalLanguageController.text;
    updateBahasa.translatedLanguage = _translatedLanguageController.text;
    updateBahasa.translatorName = _translatorNameController.text;
    BahasaBloc.updateBahasa(bahasa: updateBahasa).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const BahasaPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}

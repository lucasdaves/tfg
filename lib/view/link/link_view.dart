import 'package:arquitect/util/button.dart';
import 'package:arquitect/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:ui';

import '../../model/model_link.dart';

class LinkView extends StatefulWidget {
  final String tag = "link_view";
  const LinkView({Key? key}) : super(key: key);

  @override
  _LinkViewState createState() => _LinkViewState();
}

class _LinkViewState extends State<LinkView> {
  late List<ModelLink> links;
  late TextEditingController urlController;
  late TextEditingController nameController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    links = [];
    urlController = TextEditingController();
    nameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(30, 31, 44, 1),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
          iconSize: 25,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        toolbarHeight: 80,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        title: Text(
          "Links",
          style: GoogleFonts.mulish(
            textStyle: const TextStyle(
              letterSpacing: 1.1,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: links.length,
                itemBuilder: (context, index) {
                  return cardLink(index);
                },
              ),
            ),
            PrimaryButton(
                text: 'Cadastrar',
                onPressed: () => buttonLink("register", null)),
          ],
        ),
      ),
    );
  }

  Widget cardLink(int index) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => buttonLink('edit', index),
              backgroundColor: Pallete.orange,
              foregroundColor: Pallete.white,
              icon: Icons.edit,
              label: 'Editar',
            ),
            SlidableAction(
              onPressed: (context) => deleteLink(index),
              backgroundColor: Pallete.red,
              foregroundColor: Pallete.white,
              icon: Icons.delete,
              label: 'Excluir',
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () => launchUrl(links[index].url),
          child: Container(
            width: double.maxFinite,
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Pallete.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  links[index].description,
                  maxLines: 1,
                  style: GoogleFonts.mulish(
                    textStyle: TextStyle(
                      letterSpacing: 1.1,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Pallete.white,
                    ),
                  ),
                ),
                Text(
                  links[index].url,
                  maxLines: 2,
                  style: GoogleFonts.mulish(
                    textStyle: TextStyle(
                      letterSpacing: 1.1,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Pallete.orange,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void launchUrl(String url) async {
    try {
      await launch(url);
    } catch (error) {
      snackBar("error");
    }
  }

  void buttonLink(String? operation, int? index) {
    if (operation == "edit") {
      urlController.text = links[index!].url;
      nameController.text = links[index].description;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.hardEdge,
              child: Material(
                color: Pallete.blue,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              operation == 'edit'
                                  ? 'Editando Link'
                                  : 'Cadastrando Link',
                              style: GoogleFonts.mulish(
                                textStyle: TextStyle(
                                  letterSpacing: 1.1,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Pallete.white,
                                ),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.close,
                                color: Pallete.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        title: Text(
                          'Nome',
                          style: GoogleFonts.mulish(
                            textStyle: TextStyle(
                              letterSpacing: 1.1,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Pallete.white,
                            ),
                          ),
                        ),
                        subtitle: Container(
                          constraints: const BoxConstraints(
                            minHeight: 50,
                            maxHeight: 150,
                          ),
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            border: Border.all(color: Pallete.orange, width: 2),
                            borderRadius: BorderRadius.circular(8),
                            color: Pallete.grey,
                          ),
                          child: TextFormField(
                            validator: (controller) {
                              if (controller == null || controller.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            },
                            initialValue: null,
                            maxLines: null,
                            controller: nameController,
                            style: GoogleFonts.mulish(
                              textStyle: TextStyle(
                                letterSpacing: 1.1,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Pallete.orange,
                              ),
                            ),
                            decoration: const InputDecoration(
                              labelText: 'exemplo: youtube',
                              border: InputBorder.none,
                              icon: Icon(Icons.clear_all),
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        title: Text(
                          'Link',
                          style: GoogleFonts.mulish(
                            textStyle: TextStyle(
                              letterSpacing: 1.1,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Pallete.white,
                            ),
                          ),
                        ),
                        subtitle: Container(
                          constraints: const BoxConstraints(
                            minHeight: 50,
                            maxHeight: 150,
                          ),
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            border: Border.all(color: Pallete.orange, width: 2),
                            borderRadius: BorderRadius.circular(8),
                            color: Pallete.grey,
                          ),
                          child: TextFormField(
                            validator: (controller) {
                              if (controller == null || controller.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            },
                            maxLines: null,
                            controller: urlController,
                            style: GoogleFonts.mulish(
                              textStyle: TextStyle(
                                letterSpacing: 1.1,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Pallete.orange,
                              ),
                            ),
                            decoration: const InputDecoration(
                              labelText: 'exemplo: www.youtube.com.br',
                              hintMaxLines: 2,
                              border: InputBorder.none,
                              icon: Icon(Icons.link),
                            ),
                          ),
                        ),
                      ),
                      PrimaryButton(
                        text: operation == "edit" ? 'Editar' : 'Concluir',
                        onPressed: () {
                          validateLink(urlController, operation, index);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void validateLink(
      TextEditingController urlController, String? operation, int? index) {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      if (!(urlController.text.contains('https://') ||
          urlController.text.contains('http://'))) {
        urlController.text = 'https://${urlController.text}';
      }
      if (operation == "edit") {
        editLink(index!, urlController.text, nameController.text);
      } else {
        addLink(urlController.text, nameController.text);
      }
    }
  }

  void addLink(String url, String description) {
    if (mounted) {
      clearController();
      setState(() => links.add(ModelLink(url, description)));
      snackBar("success", description: "Adicionado com sucesso");
    }
    Navigator.pop(context);
  }

  void editLink(int index, String url, String description) {
    if (mounted) {
      clearController();
      setState(() {
        links[index].url = url;
        links[index].description = description;
      });
      snackBar("success", description: "Editado com sucesso");
    }
    Navigator.pop(context);
  }

  void deleteLink(int index) {
    if (mounted) {
      clearController();
      setState(() {
        links.removeAt(index);
      });
      snackBar("success", description: "Excluido com sucesso");
    }
  }

  void clearController() {
    urlController.clear();
    nameController.clear();
  }

  void snackBar(String operation, {String? description}) {
    if (operation == "success") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 1000),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          backgroundColor: Pallete.green,
          content: Container(
            height: 50,
            alignment: Alignment.center,
            child: Text(
              description ?? 'Sucesso na operação',
              style: GoogleFonts.mulish(
                textStyle: TextStyle(
                  letterSpacing: 1.1,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Pallete.white,
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 1000),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          backgroundColor: Pallete.red,
          content: Container(
            height: 50,
            alignment: Alignment.center,
            child: Text(
              'Erro na operação',
              style: GoogleFonts.mulish(
                textStyle: TextStyle(
                  letterSpacing: 1.1,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Pallete.white,
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}

import 'package:arquitect/util/colors.dart';
import 'package:arquitect/util/responsive.dart';
import 'package:arquitect/view/home/widgets/carousel_slider.dart';
import 'package:arquitect/view/link/link_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  final String tag = "home_view";
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.darkBlue,
      drawer: drawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Pallete.transparent,
        centerTitle: true,
        toolbarHeight: 80,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        title: Text(
          "Arquitect",
          style: GoogleFonts.mulish(
            textStyle: TextStyle(
              letterSpacing: 1.1,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Pallete.white,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ResponsiveLayout(
          mobile: homeMobile(),
          desktop: homeMobile(),
        ),
      ),
    );
  }

  Widget homeMobile() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          card(
              "Clientes",
              "Cadastrar clientes, modificar descrição, acesso a telefone,cpf, entre outros",
              null),
          card("Financeiro",
              "Projetos, valores a serem pagos, despesas, entre outros", null),
          card(
            "Links",
            "Pagina de utilidades com links do site da prefeteitura, zoneamento, 156, entre outros",
            LinkView(),
          ),
          Spacer(),
          Carousel(),
        ],
      ),
    );
  }

  Widget drawer() {
    return SafeArea(
      child: Drawer(
        backgroundColor: Pallete.darkBlue,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Pallete.orange,
              ),
              child:
                  FittedBox(fit: BoxFit.fitHeight, child: Icon(Icons.person)),
            ),
            SizedBox(height: 40),
            Center(
              child: Text(
                'Olá, Edson Souza',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.mulish(
                  textStyle: TextStyle(
                    letterSpacing: 1.1,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Pallete.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            ListTile(
              title: Text(
                'Clientes',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.mulish(
                  textStyle: TextStyle(
                    letterSpacing: 1.1,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Pallete.orange,
                  ),
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Financeiro',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.mulish(
                  textStyle: TextStyle(
                    letterSpacing: 1.1,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Pallete.orange,
                  ),
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Links',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.mulish(
                  textStyle: TextStyle(
                    letterSpacing: 1.1,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Pallete.orange,
                  ),
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget card(String title, String description, Widget? location) {
    return GestureDetector(
      onTap: () {
        if (location != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => location),
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
                  'Ainda não implementado',
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
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 100,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Pallete.blue,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Pallete.darkBlue,
              offset: const Offset(2, 2),
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              maxLines: 1,
              style: GoogleFonts.mulish(
                textStyle: TextStyle(
                  letterSpacing: 1.1,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Pallete.white,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                description,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.mulish(
                  textStyle: TextStyle(
                    letterSpacing: 1.1,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Pallete.orange,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Icon(
              Icons.arrow_forward_ios,
              size: 25,
              color: Pallete.white,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:arquitect/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

final List<Finance> financeList = [
  Finance(title: ' Nikon - Extensão', description: '', status: '', price: ''),
  Finance(
      title: ' Paulo - Itapecirica', description: '', status: '', price: ''),
  Finance(title: ' Emilia - Sitio', description: '', status: '', price: ''),
  Finance(title: ' Paulo - Galpão', description: '', status: '', price: ''),
];

class Finance {
  final String title;
  final String description;
  final String status;
  final String price;

  Finance(
      {required this.title,
      required this.description,
      required this.status,
      required this.price});
}

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(
                () {
                  _currentIndex = index;
                },
              );
            },
          ),
          items: financeList
              .map(
                (item) => Container(
                  margin: const EdgeInsets.all(12),
                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Pallete.blue,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(30, 30, 45, 1),
                        offset: Offset(2, 2),
                        blurRadius: 1,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  clipBehavior: Clip.hardEdge,
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: 50,
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        Flexible(
                          flex: 7,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Pallete.orange,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(16),
                              ),
                            ),
                            child: Center(
                              child: FittedBox(
                                child: Text(
                                  financeList[_currentIndex].title,
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
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Container(),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: financeList.map((finance) {
            int index = financeList.indexOf(finance);
            return Container(
              width: 10.0,
              height: 10.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index ? Pallete.orange : Pallete.blue,
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}

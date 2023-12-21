import 'package:flutter/material.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardContent extends StatelessWidget {
  const OnBoardContent({
    Key? key,
    required this.image,
    required this.text,
    required this.paragraph,
    required this.indicator,
    required this.onPressNext,
    required this.onPressPrevious,
  }) : super(key: key);
  final String image, text, paragraph;
  final PageController indicator;
  final VoidCallback onPressNext, onPressPrevious;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.cover)),
              child: Container(
                color: Colors.black54,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.black87,
                      Colors.transparent,
                    ], stops: [
                      0.01,
                      0.9
                    ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(),
                          Text(
                            text,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(
                                fontSize: 26,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          Text(
                            paragraph,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: TextButton(
                                    onPressed: onPressPrevious,
                                    child: Text(
                                      'Previous',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      SmoothPageIndicator(
                                        controller: indicator,
                                        count: 3,
                                        effect: SlideEffect(
                                            activeDotColor: mainColor,
                                            radius: 0,
                                            dotHeight: 2,
                                            dotWidth: 15),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: TextButton(
                                    onPressed: onPressNext,
                                    child: Text(
                                      'Next',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: mainColor,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        )
      ],
    );
  }
}

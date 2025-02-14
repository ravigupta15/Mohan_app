
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/indicator_widget.dart';

sliderWidget(){
  return Column(
    children: [
      SizedBox(
                      height: 168,
                      // color: Colors.red,
                      child: CarouselSlider.builder(
                        itemCount: 2,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          return Container(
                            margin: const EdgeInsets.only(
                              right: 15,
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child:Image.asset('assets/dummy/slider.png')),
                          );
                        },
                        options: CarouselOptions(
                            autoPlay: true,
                            scrollDirection: Axis.horizontal,
                            // enlargeCenterPage: true,
                            viewportFraction: 1,
                            aspectRatio: 2.0,
                            initialPage: 0,
                            autoPlayCurve: Curves.ease,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 400),
                            autoPlayInterval: const Duration(seconds: 2),
                            onPageChanged: (val, _) {
                              // provider.updateSliderIndex(val);
                            }),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(2, (index) {
          return 0 == index
              ? indicatorWidget(isActive:  true,activeWidth: 26,inactiveWidth: 26)
              : indicatorWidget(isActive: false,activeWidth: 26,inactiveWidth: 26);
        }))
    ],
  );
}


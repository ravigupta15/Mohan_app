
import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_text.dart';

class CustomSliderWidget extends StatefulWidget {
  final double? value;
  final bool isEnable;
  CustomSliderWidget({this.value, this.isEnable =true});
  @override
  _CustomSliderWidgetState createState() => _CustomSliderWidgetState();
}

class _CustomSliderWidgetState extends State<CustomSliderWidget> {
  double _sliderValue = 0.0; 
  double thumbRadius = 20;

// Function to check if the slider is in Low, Medium, or High range
  String getSliderState(double value) {
    if (value <= 0.33) {
      return "Low";
    } else if (value <= 0.66) {
      return "Medium";
    } else {
      return "High";
    }
  }

  int getSnappedValue(double value){
    if (value <= 0.1) {
      return 1;
    } else if (value <= 0.3) {
      return 2;
    } else if (value <= 0.5) {
      return 3;
    } else if (value <= 0.7) {
      return 4;
    } else {
      return 5;
    }
  }

  double getSliderValue(double value){
     if (value == 0.1) {
    return 1;  // Maps to range [0, 1]
  } else if (value == 2) {
    return 0.3;  // Maps to range [0.1, 0.3]
  } else if (value == 3) {
    return 0.5;  // Maps to range [0.3, 0.5]
  } else if (value == 4) {
    return 0.7;  // Maps to range [0.5, 0.7]
  } else if (value == 5) {
    return 0.87;  // Maps to range [0.7, 1]
  } else {
    return 0;  // Fallback value, should not be reached if slider values are restricted
  }
  }

@override
  void initState() {
    Future.microtask((){
      if(widget.value!=null){
   _sliderValue = getSliderValue(widget.value!);
      }
      setState(() {
        
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     double screenWidth = MediaQuery.of(context).size.width;
      double sliderWidth = screenWidth * 0.85;
          return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              if(widget.isEnable){
              setState(() {
                 double newPosition = details.localPosition.dx;
                if (newPosition < 0) newPosition = 0; 
                if (newPosition > sliderWidth - thumbRadius * 2) {
                  newPosition = sliderWidth - thumbRadius * 2;
                }
                _sliderValue = newPosition / sliderWidth;
                print(getSnappedValue(_sliderValue));
              });
              }
            },
            child: Container(
              width: sliderWidth,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.grey.shade200, 
                borderRadius: BorderRadius.circular(5), 
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.yellow, Colors.green],
                  stops: [0.0, 0.5, 1.0],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: _sliderValue * sliderWidth - thumbRadius*.3, 
                    top: 0,bottom: 0,  
                    child: Container(
                      width: thumbRadius * 2, 
                      height: thumbRadius * 2,
                      margin: EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white, 
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha:  0.3),
                            blurRadius: 2,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 5,),
        SizedBox(
          // width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(title: "Low",fontsize: 12,),
              AppText(title: "Medium",fontsize: 12,),
              AppText(title: "High",fontsize: 12,),
            ],
          ),
        )
      ],
    );
  }
}
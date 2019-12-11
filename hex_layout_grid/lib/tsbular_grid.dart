import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexagonal_grid/hexagonal_grid.dart';
import 'package:hexagonal_grid_widget/hex_grid_child.dart';
import 'package:hexagonal_grid_widget/hex_grid_context.dart';
import 'package:hexagonal_grid_widget/hex_grid_widget.dart';
import 'package:polygon_clipper/polygon_clipper.dart'; 
//void main() => runApp(HexGridWidgetExample());

class HexGridWidgetExample extends StatelessWidget {
  final double _minHexWidgetSize = 70;
  final double _maxHexWidgetSize = 70;
  final double _scaleFactor = 0.2;
  final double _densityFactor = 1.75;
  final double _velocityFactor = 0.0;
  final int _numOfHexGridChildWidgets = 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Example"),
          centerTitle: true,
        ),
        body: Material(
          type: MaterialType.transparency,
          child: Container(color: Colors.white,
              child: HexGridWidget(
          children: createHexGridChildren(_numOfHexGridChildWidgets),
          hexGridContext: HexGridContext(_minHexWidgetSize, _maxHexWidgetSize,
              _scaleFactor, _densityFactor, _velocityFactor)),
            ),
        ));
  }

  //This would likely be a service (RESTful or DB) that retrieves some data and
  // marshals them into HexGridChild objects
  List<HexGridChild> createHexGridChildren(int numOfChildren) {
    List<HexGridChild> children = [];

    for (int i = 0; i < numOfChildren; i++) {
     
      children.add(ExampleHexGridChild(i));
    }

    return children;
  }
}

//This class can contain all the properties you'd like, but it must extends
// HexGridChild and thus implement the toHexWidget and getScaledSized methods.
// The methods provide most fields the HexGridWidget is aware of to allow for
// as much flexibility when building and sizing your HexGridChild widget.
class ExampleHexGridChild extends HexGridChild {
  final int index;
 

  ExampleHexGridChild(this.index);

  //This is only one example of the customization you can expect from these
  // framework hooks
  @override
  Widget toHexWidget(BuildContext context, HexGridContext hexGridContext,
      double size, UIHex hex) {
    return Container(
        width: size,
        height: size,
        padding: EdgeInsets.all((hexGridContext.maxSize - size) / 2),
        child: getPolygon()
        
        // Container(
        //     width: size,
        //     height: size,
        //     decoration: BoxDecoration(
        //       color: orbitalColors[hex.orbital % orbitalColors.length],
        //       //shape: BoxShape.circle,
        //     ))
            
            );
  }

  Widget getPolygon(){
return ClipPolygon(  
 sides: 6, 
 borderRadius: 5.0, // Default 0.0 degrees
 //rotate: 90.0, // Default 0.0 degrees
 boxShadows: [  
  PolygonBoxShadow(color: Colors.black, elevation: 1.0),
  PolygonBoxShadow(color: Colors.grey, elevation: 5.0)
 ],
 child: Container(color: Colors.limeAccent),
);

  }
  

  @override
  double getScaledSize(
      HexGridContext hexGridContext, double distanceFromOrigin) {
    double scaledSize = hexGridContext.maxSize -
        (distanceFromOrigin * hexGridContext.scaleFactor);
    return max(scaledSize, hexGridContext.minSize);
  }
}

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ExpandableWidget extends StatelessWidget {
  final Widget collapsedWidget;
  final Widget expandedWidget;
  final bool initExpanded;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  const ExpandableWidget(
      {super.key,
      required this.collapsedWidget,
      required this.expandedWidget,
      this.padding,
      this.borderRadius = 0,
      this.initExpanded = false, });

  @override
  Widget build(BuildContext context) {
    return Container(
    decoration: BoxDecoration(
      color: Colors.white, 
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 0),
          color: Colors.black.withOpacity(0.2),
          blurRadius: 10, // Shadow blur
        ),
      ],
    ),
      child: ExpandableNotifier(
          initialExpanded: initExpanded,
          child: ScrollOnExpand(
            child: Expandable(
              collapsed: _buildCollapsed(),
              expanded: _buildExpanded(),
            ),
          )),
    );
  }

  Widget _buildCollapsed() {
    return Builder(builder: (context) {
      return InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: () => _toggleExpanded(context),
        child:  collapsedWidget,
      );
    });
  }

  Widget _buildExpanded() {
    return Builder(builder: (context) {
      return InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: () => _toggleExpanded(context),
        child: expandedWidget,
      );
    });
  }

   
  void _toggleExpanded(BuildContext context) {
    var controller = ExpandableController.of(context, required: true)!;
    controller.toggle();
  }
}

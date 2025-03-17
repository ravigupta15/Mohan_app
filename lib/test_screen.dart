import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mohan_impex/core/widget/app_text.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {

  @override
  Widget build(BuildContext context) {
    return MyTabBarPage();
  }
  }

  class MyTabBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Invoice"),
      ),
      body:DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 350.0,
                backgroundColor: Colors.white,
                floating: true,
                // snap: false,
                
                // pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  // title: Text("Top Container"),
                  background: Container(
                    // color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.yellow,
                            width: double.infinity,
                            height: 40.0,
                            child: Center(child: Text('Widget 1', style: TextStyle(color: Colors.white))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.yellow,
                            width: double.infinity,
                            height: 40.0,
                            child: Center(child: Text('Widget 2', style: TextStyle(color: Colors.white))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.yellow,
                            width: double.infinity,
                            height: 40.0,
                            child: Center(child: Text('Widget 3', style: TextStyle(color: Colors.white))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.yellow,
                            width: double.infinity,
                            height: 40.0,
                            child: Center(child: Text('Widget 4', style: TextStyle(color: Colors.white))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.yellow,
                            width: double.infinity,
                            height: 40.0,
                            child: Center(child: Text('Widget 5', style: TextStyle(color: Colors.white))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // background: Container(color: Colors.blue),
                ),
                
                bottom: PreferredSize(
                    preferredSize: Size.fromHeight(48.0), // TabBar height
                  child: Padding(
                padding: EdgeInsets.only(top: 10),
                  child: TabBar(
                    padding: EdgeInsets.only(top: 20),
                    dividerHeight: 0,
                    tabs: [
                      Tab(child: Text("Tab 1")),
                      Tab(child: Text("Tab 2")),
                    ],
                  ),
                ),
                )
              ),
            ];
          },
          body: TabBarView(
            children: [
              DynamicHeightContainer(),
              DynamicHeightContainer(),
            ],
          ),
        ),
      ),);}
}

class DynamicHeightContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 50,
      // physics: const ScrollAction(),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Item ${index + 1}'),
        );
      },
    );
  }
}

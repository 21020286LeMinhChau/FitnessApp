// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'dart:collection';

import 'package:fitness/common/color_extension.dart';
import 'package:fitness/common_widget/tab_button.dart';
import 'package:fitness/view/home/home_view.dart';
import 'package:fitness/view/main_tab/select_view.dart';
import 'package:fitness/view/photo_progress/photo_progress_view.dart';
import 'package:fitness/view/profile/profile_view.dart';
import 'package:fitness/view/workout_tracker/workout_tracker_view.dart';
import 'package:flutter/material.dart';
import 'package:fitness/view/running/map_view.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

enum TabView { homeView, selectView, mapView, photoProgressView, profileView }

class _MainTabViewState extends State<MainTabView> {
  TabView selectTab = TabView.homeView;
  Widget currentTab = HomeView();
  final PageStorageBucket pageBucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {},
          child: Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: TColor.primaryG),
              borderRadius: BorderRadius.circular(35),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  offset: Offset(0, -2),
                )
              ],
            ),
            child: Icon(
              Icons.search,
              color: TColor.white,
              size: 35,
            ),
          ),
        ),
      ),
      body: PageStorage(bucket: pageBucket, child: currentTab),
      bottomNavigationBar: BottomAppBar(
        // color: TColor.white,

        child: Container(
          decoration: BoxDecoration(
            color: TColor.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                offset: Offset(0, -2),
              ),
            ],
          ),
          height: kToolbarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TabButton(
                icon: "assets/img/home_tab.png",
                selectIcon: "assets/img/home_tab_select.png",
                isActive: selectTab == TabView.homeView,
                onTap: () {
                  selectTab = TabView.homeView;
                  currentTab = const HomeView();
                  if (mounted) {
                    setState(() {});
                  }
                },
              ),
              TabButton(
                icon: "assets/img/activity_tab.png",
                selectIcon: "assets/img/activity_tab_select.png",
                isActive: selectTab == TabView.selectView,
                onTap: () {
                  selectTab = TabView.selectView;
                  currentTab = const SelectView();
                  if (mounted) {
                    setState(() {});
                  }
                },
              ),
              TabButton(
                // icon: "assets/img/camera_tab.png",
                icon: "assets/img/run_tab.png",
                selectIcon: "assets/img/run_tab.png",
                isActive: selectTab == TabView.mapView,
                onTap: () {
                  // selectTab = TabView.mapView;
                  // // currentTab = PhotoProgressView();\
                  // currentTab = MapView();
                  // if (mounted) {
                  //   setState(() {});
                  // }
                },
              ),
              SizedBox(
                width: 40,
              ),
              TabButton(
                icon: "assets/img/camera_tab.png",
                selectIcon: "assets/img/camera_tab_select.png",
                isActive: selectTab == TabView.photoProgressView,
                onTap: () {
                  selectTab = TabView.photoProgressView;
                  // currentTab = PhotoProgressView();\
                  currentTab = PhotoProgressView();
                  if (mounted) {
                    setState(() {});
                  }
                },
              ),
              TabButton(
                // icon: "assets/img/camera_tab.png",
                icon: "assets/img/run_tab.png",
                selectIcon: "assets/img/run_tab_select.png",
                isActive: selectTab == TabView.mapView,
                onTap: () {
                  selectTab = TabView.mapView;
                  // currentTab = PhotoProgressView();\
                  currentTab = MapView();
                  if (mounted) {
                    setState(() {});
                  }
                },
              ),
              TabButton(
                icon: "assets/img/profile_tab.png",
                selectIcon: "assets/img/profile_tab_select.png",
                isActive: selectTab == TabView.profileView,
                onTap: () {
                  selectTab = TabView.profileView;
                  currentTab = ProfileView();
                  if (mounted) {
                    setState(() {});
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:bookie/views/pages/home_page.dart';
import 'package:bookie/views/pages/library_page.dart';
import 'package:bookie/views/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:bookie/viewmodels/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  final List<Widget> _pages = [HomePage(), LibraryPage(), ProfilePage()];
  final List<String> titles = ["Home Page", "My Library", "My Profile"];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        floatingActionButton: model.shouldShowFAB
            ? FloatingActionButton(
                onPressed: () {
                  model.navigateToAddView();
                },
                child: Icon(Icons.add),
              )
            : null,
        appBar: AppBar(
          title: Text(titles[model.currentIndex]),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (i) => model.setIndex(i),
          currentIndex: model.currentIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: "Library"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
          ],
        ),
        body: _pages[model.currentIndex],
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}

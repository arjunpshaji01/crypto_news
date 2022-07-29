import 'package:flutter/material.dart';

class NewsDetails extends StatelessWidget {
  ///this constructor receives data through page route
  NewsDetails(this.title, this.domain);
  final String title;
  final String domain;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
        subtitle: Text(
          domain,
          style: const TextStyle(fontSize: 15),
        ),
      ),
    ));
  }
}

// listener: (context, state) {
// Future.delayed(const Duration(seconds: 1), () {
// context.read<NewsBloc>().add(LoadApiEvent());
// });
// },

// buildWhen: (previous, current) {
// return current is NewsLoadedState;
// },

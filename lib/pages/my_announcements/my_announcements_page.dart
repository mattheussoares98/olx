import 'package:flutter/material.dart';
import 'package:olx/utils/app_routes.dart';

class MyAnnouncementsPage extends StatefulWidget {
  const MyAnnouncementsPage({Key? key}) : super(key: key);

  @override
  State<MyAnnouncementsPage> createState() => _MyAnnouncementsPageState();
}

class _MyAnnouncementsPageState extends State<MyAnnouncementsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Meus anúncios'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.newAnnouncement);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

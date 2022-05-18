import 'package:flutter/material.dart';
import 'package:olx/pages/announcement/announcements_provider.dart';
import 'package:olx/pages/announcement/announcements_widget.dart';
import 'package:olx/utils/app_routes.dart';
import 'package:provider/provider.dart';

class MyAnnouncementsPage extends StatefulWidget {
  const MyAnnouncementsPage({Key? key}) : super(key: key);

  @override
  State<MyAnnouncementsPage> createState() => _MyAnnouncementsPageState();
}

class _MyAnnouncementsPageState extends State<MyAnnouncementsPage> {
  @override
  void initState() {
    AnnouncementsProvider announcementsProvider =
        Provider.of(context, listen: false);

    announcementsProvider.listenChanges();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AnnouncementsProvider announcementsProvider =
        Provider.of(context, listen: true);

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
      body: RefreshIndicator(
        onRefresh: () => announcementsProvider.listenChanges(),
        child: AnnouncementsWidget(
          isCurrentUserAnnouncementsPage: true,
          stream: announcementsProvider.announcementStreamController.stream,
          announcementsList: announcementsProvider.currentUserAnnouncementsList,
          isLoading: announcementsProvider.isLoading,
        ),
      ),
    );
  }
}

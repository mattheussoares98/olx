import 'package:flutter/material.dart';
import 'package:olx/pages/announcement/announcements_provider.dart';
import 'package:provider/provider.dart';

class CurrentAnnouncementPage extends StatelessWidget {
  const CurrentAnnouncementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final index = ModalRoute.of(context)!.settings.arguments as int;

    AnnouncementsProvider announcementsProvider =
        Provider.of(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Meu anúncio'),
      ),
      body: Column(
        children: [
          Container(
            child: Image.network(
              announcementsProvider
                  .myAnnouncementsList[index].urlImagesDownload[0],
            ),
          ),
          Text(
            announcementsProvider.myAnnouncementsList[index].name,
          ),
          Text(
            announcementsProvider.myAnnouncementsList[index].description,
          ),
          Text(
            announcementsProvider.myAnnouncementsList[index].phoneNumber,
          ),
          Text(
            announcementsProvider.myAnnouncementsList[index].price,
          ),
          Text(
            announcementsProvider.myAnnouncementsList[index].state,
          ),
          Text(
            announcementsProvider.myAnnouncementsList[index].type,
          ),
        ],
      ),
    );
  }
}

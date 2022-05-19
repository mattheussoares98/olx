import 'package:flutter/material.dart';
import 'package:olx/pages/announcement/announcements_model.dart';
import 'package:olx/pages/announcement/announcements_provider.dart';
import 'package:provider/provider.dart';

class CurrentAnnouncementPage extends StatelessWidget {
  const CurrentAnnouncementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnnouncementsModel announcementsModel =
        ModalRoute.of(context)!.settings.arguments as AnnouncementsModel;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Meu anúncio'),
      ),
      body: Column(
        children: [
          SizedBox(
            child: Image.network(
              announcementsModel.urlImagesDownload[0],
            ),
          ),
          Text(
            announcementsModel.name,
          ),
          Text(
            announcementsModel.description,
          ),
          Text(
            announcementsModel.phoneNumber,
          ),
          Text(
            announcementsModel.price,
          ),
          Text(
            announcementsModel.state,
          ),
          Text(
            announcementsModel.type,
          ),
        ],
      ),
    );
  }
}

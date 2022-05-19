import 'package:flutter/material.dart';
import 'package:olx/pages/announcement/announcements_model.dart';

class DetailsAnnouncementPage extends StatelessWidget {
  const DetailsAnnouncementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnnouncementsModel announcementsModel =
        ModalRoute.of(context)!.settings.arguments as AnnouncementsModel;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Detalhes do anúncio'),
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

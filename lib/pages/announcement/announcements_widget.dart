import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:olx/pages/announcement/announcements_provider.dart';
import 'package:olx/utils/app_routes.dart';
import 'package:provider/provider.dart';

class AnnouncementsWidget extends StatefulWidget {
  const AnnouncementsWidget({Key? key}) : super(key: key);

  @override
  State<AnnouncementsWidget> createState() => _AnnouncementsWidgetState();
}

class _AnnouncementsWidgetState extends State<AnnouncementsWidget> {
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

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: announcementsProvider.announcementsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: announcementsProvider.announcementsList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.currentAnnouncement,
                    arguments: index,
                  );
                },
                child: Card(
                  elevation: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Container(
                          width: 120,
                          height: 120,
                          color: Colors.orange,
                          child: Image.network(
                            announcementsProvider
                                .announcementsList[index].urlImagesDownload[0],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              announcementsProvider
                                  .announcementsList[index].name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              announcementsProvider
                                  .announcementsList[index].price,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}

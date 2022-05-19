import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:olx/components/show_dialog_component.dart';
import 'package:olx/components/snackbar_component.dart';
import 'package:olx/pages/announcement/announcements_model.dart';
import 'package:olx/pages/announcement/announcements_provider.dart';
import 'package:olx/utils/app_routes.dart';
import 'package:provider/provider.dart';

class AnnouncementsListViewWidget extends StatelessWidget {
  final bool isLoading;
  final List<AnnouncementsModel> announcementsList;
  final Stream<QuerySnapshot<Map<String, dynamic>>> stream;
  final bool isCurrentUserAnnouncementsPage;
  const AnnouncementsListViewWidget({
    required this.isCurrentUserAnnouncementsPage,
    required this.stream,
    required this.announcementsList,
    required this.isLoading,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnnouncementsProvider announcementsProvider =
        Provider.of(context, listen: true);
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: stream,
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: announcementsList.length,
          itemBuilder: (context, index) {
            // print(snapshot.data?.docs[index].data());
            // print(announcementsList[0].type);
            return InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.currentAnnouncement,
                  arguments: announcementsList[index],
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
                        color: Colors.grey[200],
                        child: Image.network(
                          announcementsList[index].urlImagesDownload[0],
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object object,
                              StackTrace? stackTrace) {
                            return const SizedBox(
                              child: Center(
                                child: Text(
                                  'Erro ao carregar a imagem',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      child: Center(
                        child: Padding(
                          padding: isCurrentUserAnnouncementsPage
                              ? const EdgeInsets.all(0)
                              : const EdgeInsets.only(right: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                announcementsList[index].name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                announcementsList[index].price,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (isCurrentUserAnnouncementsPage)
                      Flexible(
                        flex: 1,
                        child: IconButton(
                          onPressed: isLoading
                              ? null
                              : () async {
                                  ShowDialogComponent.showDialogComponent(
                                    context: context,
                                    title: 'Deseja confirmar a exclusão?',
                                    widgets: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.red,
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Não'),
                                          ),
                                          ElevatedButton(
                                            child: const Text('Sim'),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.green,
                                            ),
                                            onPressed: () async {
                                              await announcementsProvider
                                                  .deleteAnnouncement(
                                                      announcementsList[index]
                                                          .id);
                                              Navigator.of(context).pop();
                                              if (announcementsProvider
                                                      .errorMessage !=
                                                  '') {
                                                SnackBarComponent.showSnackbar(
                                                  message: announcementsProvider
                                                      .errorMessage,
                                                  context: context,
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
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
      },
    );
  }
}

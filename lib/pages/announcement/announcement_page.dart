import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olx/components/dropdownbutton_component.dart';
import 'package:olx/pages/announcement/announcements_model.dart';
import 'package:olx/pages/announcement/announcements_provider.dart';
import 'package:olx/pages/announcement/announcements_listview_widget.dart';
import 'package:olx/utils/app_routes.dart';
import 'package:olx/utils/restart_app.dart';
import 'package:provider/provider.dart';

class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({Key? key}) : super(key: key);

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  List<String> _popupMenuOptions = [];

  @override
  void initState() {
    AnnouncementsProvider _announcementsProvider =
        Provider.of(context, listen: false);
    _announcementsProvider.listenAllAnnouncements();
    _announcementsProvider.listenStatesAndTypesOfAnnouncements();

    if (FirebaseAuth.instance.currentUser != null) {
      _popupMenuOptions = [
        'Meus anúncios',
        'Deslogar',
      ];
    } else {
      _popupMenuOptions = [
        'Entrar/Cadastrar',
      ];
    }

    super.initState();
  }

  _selectedItem(Object item) {
    if (item == 'Entrar/Cadastrar') {
      Navigator.of(context).pushNamed(AppRoutes.login);
    } else if (item == 'Deslogar') {
      FirebaseAuth.instance.signOut();
      _popupMenuOptions = [
        'Entrar/Cadastrar',
      ];
    } else if (item == 'Meus anúncios') {
      Navigator.of(context).pushNamed(AppRoutes.myAnnouncements);
    }
  }

  @override
  Widget build(BuildContext context) {
    AnnouncementsModel announcementsModel = AnnouncementsModel();
    AnnouncementsProvider _announcementsProvider =
        Provider.of(context, listen: true);

    List<AnnouncementsModel> announcementsList =
        _announcementsProvider.allAnnouncementsList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Anúncios'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return _popupMenuOptions
                  .map(
                    (e) => PopupMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList();
            },
            onSelected: (teste) {
              _selectedItem(teste!);
            },
          )
        ],
      ),
      body: FirebaseAuth.instance.currentUser == null
          ? const Center(
              child: Text('Faça o login para ver os anúncios'),
            )
          : RefreshIndicator(
              onRefresh: () async => RestartWidget.restartApp(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    DropdownButtonComponent(
                      announcementsModel: announcementsModel,
                      isForm: false,
                      announcementsList: announcementsList,
                    ),
                    Expanded(
                      child: AnnouncementsListViewWidget(
                        isCurrentUserAnnouncementsPage: false,
                        stream: _announcementsProvider
                            .allAnnouncementStreamController.stream,
                        announcementsList: announcementsList,
                        isLoading: _announcementsProvider.isLoading,
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

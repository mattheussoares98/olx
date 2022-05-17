import 'dart:io';

import 'package:flutter/material.dart';
import 'package:olx/components/personalized_button_component.dart';
import 'package:olx/pages/announcement/announcements_provider.dart';
import 'package:olx/pages/new_announcement/new_announcement_dropdownbutton.dart';
import 'package:olx/pages/new_announcement/new_announcement_images_widget.dart';
import 'package:olx/pages/announcement/announcements_model.dart';
import 'package:olx/pages/new_announcement/new_announcement_provider.dart';
import 'package:olx/pages/new_announcement/new_announcement_textformfields.dart';
import 'package:provider/provider.dart';

class NewAnnouncementPage extends StatefulWidget {
  const NewAnnouncementPage({Key? key}) : super(key: key);

  @override
  State<NewAnnouncementPage> createState() => _NewAnnouncementPageState();
}

class _NewAnnouncementPageState extends State<NewAnnouncementPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<File> _images = [];
  final AnnouncementsModel _announcementsModel = AnnouncementsModel();

  @override
  Widget build(BuildContext context) {
    NewAnnouncementProvider _newAnnouncementProvider =
        Provider.of(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Novo anúncio'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                NewAnnouncementImagesWidget(
                  images: _images,
                ),
                NewAnnouncementDropdownButton(
                    newAnnouncementModel: _announcementsModel),
                const SizedBox(height: 10),
                AnnouncementsTextFormFields(
                    newAnnouncementModel: _announcementsModel),
                PersonalizedButtonComponent(
                  isLoading: _newAnnouncementProvider.isLoading,
                  onPressed: () async {
                    bool isValid = _formKey.currentState!.validate();

                    if (isValid) {
                      await _newAnnouncementProvider.saveAnnouncement(
                        images: _images,
                        announcementsModel: _announcementsModel,
                      );
                    }
                  },
                  text: 'Adicionar anúncio',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

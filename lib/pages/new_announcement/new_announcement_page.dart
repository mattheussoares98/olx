import 'dart:io';

import 'package:flutter/material.dart';
import 'package:olx/components/personalized_button_component.dart';
import 'package:olx/pages/new_announcement/new_announcement_dropdownbutton.dart';
import 'package:olx/pages/new_announcement/new_announcement_images_widget.dart';
import 'package:olx/pages/new_announcement/new_announcement_textformfields.dart';

class NewAnnouncementPage extends StatefulWidget {
  const NewAnnouncementPage({Key? key}) : super(key: key);

  @override
  State<NewAnnouncementPage> createState() => _NewAnnouncementPageState();
}

class _NewAnnouncementPageState extends State<NewAnnouncementPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<File> _images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Novo anúncio'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  NewAnnouncementImagesWidget(
                    images: _images,
                  ),
                  const NewAnnouncementDropdownButton(),
                  const SizedBox(height: 10),
                  const NewAnnouncementsTextFormFields(),
                  PersonalizedButtonComponent(
                    onPressed: () {
                      _formKey.currentState?.validate();
                    },
                    text: 'Adicionar anúncio',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

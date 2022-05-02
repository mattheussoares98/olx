import 'dart:io';

import 'package:flutter/material.dart';
import 'package:olx/components/personalized_button_component.dart';

class NewAnnouncementPage extends StatefulWidget {
  const NewAnnouncementPage({Key? key}) : super(key: key);

  @override
  State<NewAnnouncementPage> createState() => _NewAnnouncementPageState();
}

class _NewAnnouncementPageState extends State<NewAnnouncementPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<File> _images = [];

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
                  SizedBox(
                    height: 120,
                    width: double.infinity,
                    child: FormField<List>(
                      initialValue: _images,
                      validator: (images) {
                        if (images!.isEmpty) {
                          print('é vazio');
                          return 'Pelo menos uma imagem deve ser selecionada!';
                        }
                        return null;
                      },
                      builder: (state) {
                        return ListView.builder(
                          itemCount: _images.length + 1,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            if (index == _images.length) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.grey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_a_photo,
                                          size: 40,
                                          color: Colors.grey[100],
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          'Adicionar',
                                          style: TextStyle(
                                            color: Colors.grey[100],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (state.hasError)
                                    Text(
                                      state.errorText!,
                                      style: const TextStyle(
                                        color: Colors.red,
                                      ),
                                    )
                                ],
                              );
                            } else {
                              return CircleAvatar(
                                child: Text('teste'),
                                radius: 50,
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                  Row(
                    children: [
                      DropdownButton(
                        items: const [
                          DropdownMenuItem(
                            child: Text('Estado'),
                          ),
                          // DropdownMenuItem(
                          //   child: Text('Categoria'),
                          // ),
                        ],
                        onChanged: (dynamic value) {},
                      ),
                    ],
                  ),
                  // TextFormField(),
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

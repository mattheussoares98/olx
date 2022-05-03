import 'dart:io';

import 'package:flutter/material.dart';
import 'package:olx/components/show_dialog_component.dart';
import 'package:olx/pages/new_announcement/new_announcement_controller.dart';

class NewAnnouncementImagesWidget extends StatefulWidget {
  final List<File> images;
  const NewAnnouncementImagesWidget({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  State<NewAnnouncementImagesWidget> createState() =>
      _NewAnnouncementImagesWidgetState();
}

class _NewAnnouncementImagesWidgetState
    extends State<NewAnnouncementImagesWidget> {
  final NewAnnouncementController _newAnnouncementController =
      NewAnnouncementController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: double.infinity,
      child: FormField<List>(
        initialValue: widget.images,
        validator: (images) {
          if (images!.isEmpty) {
            return 'Pelo menos uma imagem deve ser selecionada!';
          }
          return null;
        },
        builder: (state) {
          return ListView.builder(
            itemCount: widget.images.length + 1,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index == widget.images.length) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _newAnnouncementController
                            .addImage(
                          context: context,
                          images: widget.images,
                        )
                            .then((value) {
                          setState(
                              () {}); //se não chamar o setState aqui, não atualiza a lista
                        });
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                    ),
                    if (state.hasError)
                      Text(
                        state.errorText!,
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                  ],
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GestureDetector(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: FileImage(widget.images[index]),
                  ),
                  onTap: () async {
                    await ShowDialogComponent().showDialogComponent(
                      context: context,
                      widgets: [
                        SizedBox(
                          child: Image.file(
                            widget.images[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              widget.images.removeAt(index);
                              Navigator.of(context).pop();
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Excluir',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.delete, color: Colors.red),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

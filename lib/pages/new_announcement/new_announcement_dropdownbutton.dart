import 'package:flutter/material.dart';

class NewAnnouncementDropdownButton extends StatelessWidget {
  const NewAnnouncementDropdownButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButton(
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
        ),
        const SizedBox(width: 20),
        Expanded(
          child: DropdownButton(
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
        ),
      ],
    );
  }
}

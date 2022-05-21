import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:olx/pages/announcement/announcements_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsAnnouncementPage extends StatefulWidget {
  const DetailsAnnouncementPage({Key? key}) : super(key: key);

  @override
  State<DetailsAnnouncementPage> createState() =>
      _DetailsAnnouncementPageState();
}

class _DetailsAnnouncementPageState extends State<DetailsAnnouncementPage> {
  bool _hasCallSupport = false;
  Future<void>? _launched;

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  void initState() {
    super.initState();
    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  Widget title(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AnnouncementsModel announcementsModel =
        ModalRoute.of(context)!.settings.arguments as AnnouncementsModel;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Detalhes do anúncio'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 300.0,
                    autoPlay: true,
                    pageSnapping: true,
                    enableInfiniteScroll: false,
                    padEnds: false,
                  ),
                  items: announcementsModel.urlImagesDownload.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 5.0,
                            vertical: 5,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              i,
                              errorBuilder: ((context, error, stackTrace) {
                                return Container(
                                  color: Theme.of(context).errorColor,
                                  child: const Center(
                                    child: Text(
                                      'NÃO FOI POSSÍVEL CARREGAR A IMAGEM',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                announcementsModel.price,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Divider(color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 10),
              title(announcementsModel.name),
              const SizedBox(height: 10),
              Divider(color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 10),
              title('Descrição'),
              const SizedBox(height: 10),
              Text(
                announcementsModel.description,
              ),
              const SizedBox(height: 10),
              Divider(color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 10),
              title('Estado: ${announcementsModel.state}'),
              const SizedBox(height: 10),
              Divider(color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 10),
              Text(
                "Telefone: " + announcementsModel.phoneNumber,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    maximumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                onPressed: () async {
                  await _makePhoneCall(announcementsModel.phoneNumber);
                },
                child: const Text(
                  'Ligar',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

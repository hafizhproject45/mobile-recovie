// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:recovie/core/utils/colors.dart';
import 'package:recovie/core/utils/text_style.dart';
import 'package:social_media_flutter/social_media_flutter.dart';
import '../../widgets/global/my_appbar.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String appVersion = '-';

  @override
  void initState() {
    super.initState();
    _getAppVersion();
  }

  Future<void> _getAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        appVersion = 'V ${packageInfo.version}';
      });
    } catch (e) {
      setState(() {
        appVersion = 'Failed to get version';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: MyAppBar(
        isMenu: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/images/my_foto.jpg',
                  width: 100,
                  height: 100,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'This app is developed by',
                textAlign: TextAlign.center,
                style: AppTextStyle.mediumWhite,
              ),
              const SizedBox(height: 10),
              const Text(
                'Hafizh Athallah Yovanka',
                textAlign: TextAlign.center,
                style: AppTextStyle.subHeadingWhite,
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),
              const Text(
                'Contact',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primary,
                ),
              ),
              const SizedBox(height: 10),
              SocialWidget(
                placeholderText: 'hafizh.project45@gmail.com',
                iconData: Icons.email,
                iconColor: Colors.white,
                link: '',
                placeholderStyle: AppTextStyle.bodySosmed,
              ),
              SocialWidget(
                placeholderText: 'hafizhproject45',
                iconData: SocialIconsFlutter.github,
                iconColor: Colors.white,
                link: '',
                placeholderStyle: AppTextStyle.bodySosmed,
              ),
              SocialWidget(
                placeholderText: 'Hafizh Athallah Yovanka',
                iconData: SocialIconsFlutter.linkedin,
                iconColor: Colors.white,
                link: '',
                placeholderStyle: AppTextStyle.bodySosmed,
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),
              const Text(
                'About this application',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primary,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: screenWidth * 0.9,
                child: RichText(
                  text: const TextSpan(
                    children: [
                      WidgetSpan(child: SizedBox(width: 15)),
                      TextSpan(
                        text:
                            'Selamat datang di aplikasi kami, platform terbaik untuk menemukan rekomendasi film yang sesuai dengan selera Anda! Aplikasi ini dirancang untuk para pecinta film yang selalu mencari rekomendasi film terbaru dan terbaik. Dengan antarmuka yang intuitif dan mudah digunakan, aplikasi ini akan menjadi teman setia Anda dalam menjelajahi dunia perfilman.\n\n\n',
                        style: AppTextStyle.mediumWhite,
                      ),
                      TextSpan(
                        text: 'Fitur Utama:\n\n',
                        style: AppTextStyle.subHeadingWhite,
                      ),
                      TextSpan(
                        text:
                            '- Rekomendasi Film: Dapatkan rekomendasi film berdasarkan preferensi Anda. Aplikasi kami menyediakan daftar film yang sedang trending, film yang mendapat ulasan positif, dan film yang disarankan khusus untuk Anda.\n\n',
                        style: AppTextStyle.mediumWhite,
                      ),
                      TextSpan(
                        text:
                            '- Informasi Lengkap: Setiap film dilengkapi dengan informasi lengkap seperti sinopsis, pemeran, trailer, dan ulasan pengguna. Anda dapat dengan mudah memutuskan film mana yang ingin ditonton.\n\n',
                        style: AppTextStyle.mediumWhite,
                      ),
                      TextSpan(
                        text:
                            '- Koneksi ke TMDb API: Aplikasi ini menggunakan API dari The Movie Database (TMDb), salah satu database film terbesar di dunia. Dengan data yang selalu diperbarui, Anda akan mendapatkan informasi terbaru tentang film-film favorit Anda.\n\n',
                        style: AppTextStyle.mediumWhite,
                      ),
                      TextSpan(
                        text:
                            '- Trailer Film: Tonton trailer film langsung di aplikasi kami. Dapatkan gambaran singkat tentang film sebelum memutuskan untuk menontonnya.\n\n',
                        style: AppTextStyle.mediumWhite,
                      ),
                      TextSpan(
                        text:
                            '- Ulasan dan Penilaian: Baca ulasan dari pengguna lain dan lihat penilaian mereka. Anda juga dapat memberikan ulasan dan penilaian Anda sendiri setelah menonton film.\n\n\n',
                        style: AppTextStyle.mediumWhite,
                      ),
                      TextSpan(
                        text: 'Mengapa Memilih Aplikasi Ini?\n\n',
                        style: AppTextStyle.subHeadingWhite,
                      ),
                      TextSpan(
                        text:
                            '- Selalu Terbaru: Dengan menggunakan API dari TMDb, kami memastikan bahwa Anda selalu mendapatkan informasi terbaru dan rekomendasi film yang up-to-date.\n\n',
                        style: AppTextStyle.mediumWhite,
                      ),
                      TextSpan(
                        text:
                            '- Pengalaman Pengguna yang Menyenangkan: Desain antarmuka yang menarik dan mudah digunakan memastikan pengalaman pengguna yang menyenangkan dan tidak membingungkan.\n\n',
                        style: AppTextStyle.mediumWhite,
                      ),
                      TextSpan(
                        text:
                            '- Gratis: Aplikasi ini dapat digunakan secara gratis! Nikmati semua fitur tanpa biaya tambahan.\n\n\n',
                        style: AppTextStyle.mediumWhite,
                      ),
                      TextSpan(
                        text: 'Hubungi Kami\n\n',
                        style: AppTextStyle.subHeadingWhite,
                      ),
                      WidgetSpan(child: SizedBox(width: 15)),
                      TextSpan(
                        text:
                            'Jika Anda memiliki pertanyaan, saran, atau membutuhkan bantuan, jangan ragu untuk menghubungi kami di hafizh.project45@gmail.com. Kami senang mendengar dari Anda dan siap membantu Anda dengan segala kebutuhan terkait aplikasi.\n\n',
                        style: AppTextStyle.mediumWhite,
                      ),
                      WidgetSpan(child: SizedBox(width: 15)),
                      TextSpan(
                        text:
                            'Aplikasi ini adalah pilihan tepat bagi Anda yang selalu ingin mendapatkan rekomendasi film terbaik dan terbaru. Terima kasih telah menggunakan aplikasi kami, dan selamat menikmati film-film pilihan Anda!',
                        style: AppTextStyle.mediumWhite,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'App Version',
                style: AppTextStyle.medium,
              ),
              Text(
                appVersion,
                style: AppTextStyle.bodyWhite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

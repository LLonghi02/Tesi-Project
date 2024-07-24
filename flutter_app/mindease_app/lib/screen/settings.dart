import 'dart:io';
import 'package:mindease_app/provider/importer.dart';



class SettingPage extends ConsumerWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backcolor = ref.watch(detProvider); // Retrieve background color from provider
    String nickname = ref.watch(nicknameProvider); // Retrieve nickname value from provider
    final profileImage = ref.watch(profileImageProvider); // Retrieve profile image file from provider

    return Scaffold(
      backgroundColor: backcolor,
      appBar: const TopBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               CircleAvatar(
                radius: 50,
                 backgroundImage: profileImage != null && profileImage.isNotEmpty
                    ? profileImage.startsWith('assets/')
                        ? AssetImage(profileImage) as ImageProvider
                        : FileImage(File(profileImage))
                    : const AssetImage('assets/images/user/profilo.png'),
              ),
              const SizedBox(height: 10),
              Text(
                nickname,
                style: AppFonts.settTitle,
              ),
              const SizedBox(height: 10),
              Center(
                child: Container(
                  width: 300, // Set the desired width
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                    color: const Color(0xffECFEF1),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildListItem(context, 'Nickname', Icons.person, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const NicknamePage()),
                        );
                      }),
                      _buildListItem(context, 'Password', Icons.lock, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PasswordPage()),
                        );
                      }),
                      _buildListItem(context, 'Profile Image', Icons.image, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  ProfileImagePage()),
                        );
                      }),
                      _buildListItem(context, 'Theme', Icons.brush, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ThemeSelectionPage()),
                        );
                      }),
                      _buildListItem(context, 'Share with Therapist', Icons.share, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SharePage()),
                        );
                      }),
                      _buildListItem(context, 'About Us', Icons.info, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AboutPage()),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }

  Widget _buildListItem(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF4FA69E)),
      title: Text(
        title,
        style: AppFonts.sett,
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: const Color(0xFF4FA69E)),
      onTap: onTap,
    );
  }
}

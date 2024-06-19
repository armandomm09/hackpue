import 'package:flutter/material.dart';
import 'package:hackpue/services/userInfo/UserInfoService.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {

  String _disability = 'Loading...'; // Valor predeterminado
  String _hobbies = 'Loading...';
  String _age = 'Loading...';
  String _study = 'Loading...';
  String _interests = 'Loading...';

  initData() async {
    
    String newdisability = await UserInfoService.getSpecificInfo(UserSpecificInfo.Disability);
    String newhobbies = await UserInfoService.getSpecificInfo(UserSpecificInfo.Hobbies);
    String newage = await UserInfoService.getSpecificInfo(UserSpecificInfo.Age);
    String newstudy = await UserInfoService.getSpecificInfo(UserSpecificInfo.Studies);
    String newinterests = await UserInfoService.getSpecificInfo(UserSpecificInfo.Interests);

    setState(() {
      _disability = newdisability;
      _hobbies = newhobbies;
      _age = newage;
      _study = newstudy;
      _interests = newinterests;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          PopupMenuButton<ProfileMenuState>(
            onSelected: (value) {
              switch (value) {
                case ProfileMenuState.EDIT:
                  
                  break;
                case ProfileMenuState.LOG_OUT:
                  print("Log out");
                  // Implementar la funcionalidad de cerrar sesión aquí
                  break;
              }
            },
            icon: const Icon(Icons.more_vert_sharp),
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: ProfileMenuState.EDIT,
                  child: Text("Edit"),
                ),
                const PopupMenuItem(
                  value: ProfileMenuState.LOG_OUT,
                  child: Text("Log out"),
                ),
              ];
            },
            color: Colors.amber,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const UserAvatar(size: 100),
            const SizedBox(height: 10),
            const Text(
              "Armando",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Text(
              "Mac Beath",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatColumn("Followers", "5887"),
                _buildStatColumn("Touches", "190"),
                _buildStatColumn("Following", "2593"),
              ],
            ),
            const Divider(
              thickness: 2,
              height: 20,
              color: Colors.amber,
            ),
            _buildUserInfoSection("Discapacidad", _disability),
            _buildUserInfoSection("Hobbies", _hobbies),
            _buildUserInfoSection("Edad", _age),
            _buildUserInfoSection("Estudios", _study),
            _buildUserInfoSection("Temas de Interés", _interests),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildUserInfoSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const Divider(
            thickness: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

enum ProfileMenuState {
  EDIT,
  LOG_OUT,
}

class UserAvatar extends StatelessWidget {
  final double size;

  const UserAvatar({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      backgroundImage: AssetImage('assets/images/rexy.JPG'), // Asegúrate de tener una imagen de avatar en la carpeta assets
    );
  }
}

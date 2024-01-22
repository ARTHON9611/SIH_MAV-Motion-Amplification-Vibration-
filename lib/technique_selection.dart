import 'package:flutter/material.dart';
import 'package:mav/eulerian_magnification_page.dart';
import 'package:mav/phase_magnification_page.dart';

class TechniqueSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Choose a Technique',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          TechniqueTile(
            title: 'Eulerian Video Magnification',
            subtitle: 'Magnify subtle color and motion changes',
            icon: Icons.video_collection,
            onTap: () {
              // Handle selection of Eulerian Video Magnification
              // You can navigate to the specific page or perform actions here
              // For example: Navigator.push(context, MaterialPageRoute(builder: (context) => EulerianMagnificationPage()));
            },
          ),
          Divider(
            color: Colors.white,
          ),
          TechniqueTile(
            title: 'Phase-Based Magnification',
            subtitle: 'Magnify phase changes in videos',
            icon: Icons.blur_on,
            onTap: () {
              // Handle selection of Phase-Based Magnification
              // Similar to above, you can navigate or perform actions here
              // For example: Navigator.push(context, MaterialPageRoute(builder: (context) => PhaseBasedMagnificationPage()));
            },
          ),
        ],
      ),
    );
  }
}

class TechniqueTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Function onTap;

  const TechniqueTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _navigateToParameterSelection(context),
      splashColor: Colors.white.withOpacity(0.3), // Customize the splash color
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.white, // Set the icon color to white
              size: 32,
            ),
            SizedBox(height: 16.0),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
    void _navigateToParameterSelection(BuildContext context) {
    if (title == 'Eulerian Video Magnification') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EulerianMagnificationPage(),
        ),
      );
    } else if (title == 'Phase-Based Magnification') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PhaseMagnificationPage(),
        ),
      );
    }
  }
}


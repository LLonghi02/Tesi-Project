import 'package:mindease_app/provider/importer.dart';


class ClickableImage extends StatelessWidget {
  final String imageUrl;
  final String text;
  final double? height;
  final double? width;
  final Widget destination; // Add the destination parameter

  const ClickableImage({
    super.key,
    required this.imageUrl,
    required this.text,
    required this.destination, // Required destination parameter
    this.height, // Optional height parameter
    this.width, // Optional width parameter
  });

  @override
  Widget build(BuildContext context) {
    return Center( // Center the content horizontally
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        child: Container(
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white, // Background color for the image opacity
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: 0.5, // Opacity of the image
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: width ?? 340, // Use the passed width or default to 340
                    height: height ?? 200, // Use the passed height or default to 200
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: AppFonts.sign,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:read/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Book extends StatefulWidget {
  final String name;
  Book({
    super.key,
    required this.name,
  });

  @override
  State<Book> createState() => _BookState();
}

class _BookState extends State<Book> {
  DocumentSnapshot<Map<String, dynamic>>? bookSnapshot;
  Object? ids;
  String? downloadUrl;

  @override
  void initState() {
    super.initState();
    fetchEbook();
  }

  Future<void> fetchEbook() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot = await firestore.collection('ebooks').get();

      for (var doc in querySnapshot.docs) {
        if (doc.id == widget.name) {
          print(doc.id);
          setState(() {
            bookSnapshot = doc as DocumentSnapshot<Map<String, dynamic>>?;
            downloadUrl = bookSnapshot!.data()?['file'];
          });
          break;
        }
      }
    } catch (e) {
      print('Error fetching ebook: $e');
    }
  }

  Future<void> _launchURL() async {
    final url = Uri.parse(bookSnapshot?.data()?['file']);
    if (url != null && await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print('Could not launch $url');
    }
  }

  void _openPDF(BuildContext context) {
    if (downloadUrl != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PDFViewerScreen(url: downloadUrl!),
        ),
      );
    } else {
      print('No URL found in document.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return bookSnapshot == null
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            backgroundColor: white,
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => _launchURL(),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width * 3 / 4 - 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: primaryColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "download.",
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 25,
                                color: white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width / 4,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black54,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.share,
                    ),
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              toolbarHeight: 80,
              backgroundColor: white,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                ),
              ),
              automaticallyImplyLeading: false,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 30,
                      height: MediaQuery.of(context).size.height / 3,
                      child: Image(
                        image: NetworkImage(
                          bookSnapshot!.data()?["imageUrl"],
                        ),
                      ),
                    ),
                    Text(
                      bookSnapshot!.data()?["name"],
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.07,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "- " + bookSnapshot!.data()?["author"],
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      bookSnapshot!.data()?['about'],
                      style: GoogleFonts.poppins(),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

class PDFViewerScreen extends StatelessWidget {
  final String url;

  PDFViewerScreen({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: PDFView(
        filePath: url,
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
      ),
    );
  }
}

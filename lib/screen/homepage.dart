import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:read/constants/colors.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String greeting() {
    final time = DateTime.now().hour;
    if (time >= 4 && time < 12) {
      return ('Good Morning,');
    } else if (time >= 12 && time < 18) {
      return ('Good Afternoon,');
    } else {
      return ('Good Evening,');
    }
  }

  String category = "All";

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/back.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Scaffold(
        backgroundColor: transparent,
        appBar: AppBar(
          backgroundColor: white,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [white, Colors.white38], // Colors for the gradient
            ),
          ),
          child: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        greeting(),
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.08,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "What do you want to read today?   ",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  //Search Bar
                  TextFormField(
                    style: GoogleFonts.poppins(),
                    cursorColor: primaryColor,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: primaryColor,
                        ),
                      ),
                      prefixIcon: const Icon(Icons.search_rounded),
                      hintText: "Search...",
                      hintStyle: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      filled: true,
                      fillColor: primaryColor.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //Categories
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _category("All", category, (selected) {
                          setState(() {
                            category = selected; // Update selected category
                          });
                        }),
                        const SizedBox(
                          width: 10,
                        ),
                        _category("Fiction", category, (selected) {
                          setState(() {
                            category = selected; // Update selected category
                          });
                        }),
                        const SizedBox(
                          width: 10,
                        ),
                        _category("Autobiography", category, (selected) {
                          setState(() {
                            category = selected; // Update selected category
                          });
                        }),
                        const SizedBox(
                          width: 10,
                        ),
                        _category("Motivational", category, (selected) {
                          setState(() {
                            category = selected; // Update selected category
                          });
                        }),
                        const SizedBox(
                          width: 10,
                        ),
                        _category("Romantic", category, (selected) {
                          setState(() {
                            category = selected; // Update selected category
                          });
                        }),
                        const SizedBox(
                          width: 10,
                        ),
                        _category("History", category, (selected) {
                          setState(() {
                            category = selected; // Update selected category
                          });
                        }),
                        const SizedBox(
                          width: 10,
                        ),
                        _category("General Knowledge", category, (selected) {
                          setState(() {
                            category = selected; // Update selected category
                          });
                        }),
                        const SizedBox(
                          width: 10,
                        ),
                        _category("Mystery", category, (selected) {
                          setState(() {
                            category = selected; // Update selected category
                          });
                        }),
                        const SizedBox(
                          width: 10,
                        ),
                        _category("Self-Help", category, (selected) {
                          setState(() {
                            category = selected; // Update selected category
                          });
                        }),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  //Books
                  StreamBuilder(
                    stream: _getBooksStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData) {
                        return const Text('No data available');
                      } else {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: snapshot.data!.docs.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final book = snapshot.data!.docs[index];
                            return _buildBookContainer(
                              book['name'],
                              book['imageUrl'],
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          )),
        ),
      ),
    ]);
  }

  GestureDetector _category(
      String title, String category, Function(String) onTap) {
    bool isSelected = title == category;
    return GestureDetector(
      onTap: () {
        onTap(title);
      },
      child: Container(
        padding: const EdgeInsets.only(
          top: 5,
          bottom: 5,
          left: 10,
          right: 10,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? primaryColor : black,
          ),
          borderRadius: BorderRadius.circular(30),
          color: isSelected ? primaryColor : null,
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
            color: isSelected ? Colors.white : null,
          )),
        ),
      ),
    );
  }

  Stream<QuerySnapshot> _getBooksStream() {
    CollectionReference ebooksRef =
        FirebaseFirestore.instance.collection('ebooks');

    if (category == 'All') {
      return ebooksRef.snapshots();
    } else {
      return ebooksRef.where('category', isEqualTo: category).snapshots();
    }
  }

  // Function to build a container for each book
  Widget _buildBookContainer(String title, String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image(
            image: NetworkImage(
              imageUrl,
            ),
            fit: BoxFit.contain,
            height: 150,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

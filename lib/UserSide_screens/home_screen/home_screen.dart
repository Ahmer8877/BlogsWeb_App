import 'package:blog_with_ai_chatbot/WIDGETS/homeScreen_widget/homeScreen_widget.dart';
import 'package:blog_with_ai_chatbot/data/Providers/auth_providers/auth_providers.dart';
import 'package:blog_with_ai_chatbot/data/model/Blog_mddel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //initialize FirebaseFirestore
  final FirebaseFirestore db = FirebaseFirestore.instance;

  //initialize whatsApp Url for me contact support
  Uri contactUrl=Uri.parse('https://wa.me/qr/ECJDRCYFI53AA1');

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    // Responsive columns
    int crossAxisCount = 1;

    if(width > 1400){
      crossAxisCount = 4;
    }
    else if(width > 1100){
      crossAxisCount = 3;
    }
    else if(width > 700){
      crossAxisCount = 2;
    }

    //main root of screen
    return Scaffold(

      backgroundColor: const Color(0xFFF4ECE6),

      //Floating action button

      floatingActionButton: FloatingActionButton(
        backgroundColor:  Colors.greenAccent,
          onPressed: (){
            context.goNamed('aiChatBot');
          },child:Icon(Icons.message_outlined,color: Colors.white,)
      ),

      //body with safe area
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 20,
          ),

          child: Column(
            children: [

              //TOP BAR
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

                children: [

                  // LOGO
                  Row(
                    children: const [

                      Icon(
                        Icons.auto_awesome,
                        color: Colors.greenAccent,
                      ),

                      SizedBox(width: 8),

                      //App name
                      Text(
                        "Mir_Blogs",

                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  Spacer(),

                  Expanded(
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,

                      children: [

                        // MY BLOGS button with list icon
                        TextButton(
                          onPressed: () {
                            context.goNamed('myBlog');
                          },
                          child: Icon(Icons.list_alt,size: 30,)
                        ),

                        // ADD BLOG button
                        TextButton(
                          onPressed: () {
                            context.goNamed('addBlog');
                          },

                          child:Icon(Icons.add,size: 30,)
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton(
                      itemBuilder: (context)=>[

                        //logOut Button
                        PopupMenuItem(
                            child: TextButton.icon(
                                onPressed: (){
                                  Provider.of<AuthProviders>(context,listen: false).logOut(context);
                                },
                                label: Text('SignOut'),
                                icon: Icon(Icons.logout)
                            )
                        ),
                        //contact us button(whatsApp)
                        PopupMenuItem(
                          onTap: ()async{
                           await launchUrl(contactUrl);
                          },
                            child: Row(children: [Icon(Icons.call),Text('Contact Us')],)
                        ),
                        PopupMenuItem(
                          onTap: (){},
                            child: Text('About v1.0')
                        )
                      ]
                  ),
                ],
              ),

              const SizedBox(height: 35),

              // TITLE
              const Align(
                alignment: Alignment.centerLeft,

                child: Text(
                  "Latest Articles",

                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // BLOGS
              Flexible(
                child: StreamBuilder<QuerySnapshot>(

                  stream: db.collection('Blogs').where('status', isEqualTo: 'approved',
                  ).orderBy('createAt', descending: true,
                  )
                      .snapshots(),

                  builder: (context, snapshot) {

                    // LOADING
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator(),
                      );
                    }

                    // EMPTY
                    if(!snapshot.hasData || snapshot.data!.docs.isEmpty){

                      return const Center(
                        child: Text(
                          "No Blogs Found",

                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      );
                    }

                    // DATA
                    final blogs = snapshot.data!.docs
                        .map((e) => BlogModel.fromMap(
                      e.data() as Map<String,dynamic>,
                    ))
                        .toList();

                    return GridView.builder(

                      itemCount: blogs.length,

                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(

                        crossAxisCount: crossAxisCount,

                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,

                        childAspectRatio: 1.1,
                      ),

                      itemBuilder: (context, index) {

                        // BlogCard widget
                        return BlogCard(
                          blog: blogs[index],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
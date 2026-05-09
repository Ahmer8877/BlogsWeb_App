import 'package:blog_with_ai_chatbot/UserSide_screens/BlogDeatil_Screen/BlogDetail_screen.dart';
import 'package:blog_with_ai_chatbot/data/model/Blog_mddel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BlogCard extends StatelessWidget {

  final BlogModel blog;

  const BlogCard({
    super.key,
    required this.blog,
  });

  @override
  Widget build(BuildContext context) {

    //formate date

    final formattedDate = DateFormat('dd MMM yyyy').format(blog.createAt);

    return InkWell(

      onTap: (){
       Navigator.push(context, MaterialPageRoute(builder: (_)=>
           BlogDetailScreen(
           title: blog.title,
           content: blog.des,
           author: blog.author,
           date: DateFormat('dd MMM yyyy').format(blog.createAt)
       )
       ));
      },

      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),

          gradient: LinearGradient(
            colors: [
              Colors.green.withOpacity(0.25),
              Colors.black.withOpacity(0.85),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),

          border: Border.all(
            color: Colors.green.withOpacity(0.2),
          ),
        ),

        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // TITLE & author
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    blog.title,

                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Icon(Icons.person,color: Colors.greenAccent.shade100,),
                Expanded(child: Text(blog.author))
              ],
            ),

            const SizedBox(height: 10),

            // DESCRIPTION
            Text(
              blog.des,

              maxLines: 2,
              overflow: TextOverflow.ellipsis,

              style: TextStyle(
                height: 1.5,
              ),
            ),

            const SizedBox(height: 14),

            // DATE
            Row(
              children: [

                Icon(
                  Icons.access_time_rounded,
                  color: Colors.greenAccent.shade100,
                  size: 16,
                ),

                const SizedBox(width: 6),

                Text(
                  formattedDate,

                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
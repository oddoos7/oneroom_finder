import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'room_details_screen.dart';

class PostCard extends StatefulWidget {
  final QueryDocumentSnapshot post;
  final String title;
  final String content;
  final String location;
  final String price;
  final String author;
  final String image;
  final int reviewsCount;
  final String postId;
  final String tag;

  const PostCard({
    super.key,
    required this.post,
    required this.title,
    required this.content,
    required this.location,
    required this.price,
    required this.author,
    required this.image,
    required this.reviewsCount,
    required this.postId,
    required this.tag,
  });

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12.0),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RoomDetailsScreen(postId: widget.post.id),
            ),
          );
        },
        leading: widget.image.isNotEmpty
            ? Image.network(
                widget.image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              )
            : const SizedBox(
                width: 100,
                height: 100,
                child: Icon(Icons.image, color: Colors.grey),
              ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.tag.isNotEmpty)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  widget.tag,
                  style: const TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(height: 4),
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.location} | ${widget.price}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '작성자: ${widget.author}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.orange,
              ),
            ),
            Text(
              widget.content,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '후기 ${widget.reviewsCount}개',
                  style: const TextStyle(color: Colors.grey),
                ),
                IconButton(
                  icon: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: _isFavorite ? Colors.red : Colors.black,
                  ),
                  onPressed: _toggleFavorite,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

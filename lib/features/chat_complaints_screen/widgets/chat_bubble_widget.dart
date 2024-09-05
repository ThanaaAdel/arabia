import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final String time;
  final bool isCurrentUser;
  final String? imageUrl;

  ChatBubble({
    super.key,
    required this.text,
    required this.time,
    required this.isCurrentUser,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisAlignment:
        isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isCurrentUser)
            CircleAvatar(
              radius: 15.sp,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, size: 25.sp, color: Colors.white),
            ),
          if (!isCurrentUser) SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: isCurrentUser
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7),
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: isCurrentUser
                      ? Colors.blue.shade100
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    if (imageUrl != null) ...[
                      SizedBox(height: 10.h),
                      Image.network(imageUrl!),
                    ],
                    SizedBox(height: 5.h),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        time,
                        style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (isCurrentUser) SizedBox(width: 10.w),
          if (isCurrentUser)
            CircleAvatar(
              radius: 15.sp,
              backgroundColor: Colors.orange,
              child: Icon(Icons.person, size: 25.sp, color: Colors.white),
            ),
        ],
      ),
    );
  }
}
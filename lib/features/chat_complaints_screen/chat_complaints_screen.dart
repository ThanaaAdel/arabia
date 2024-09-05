import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/core/widgets/shared_appbar.dart';
import 'package:arabia/features/chat_complaints_screen/widgets/chat_bubble_widget.dart';
import 'package:arabia/features/chat_complaints_screen/widgets/send_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/utils/assets_manager.dart';

class ChatComplaintsScreen extends StatelessWidget {
  const ChatComplaintsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: const SharedAppbar(text: "شكوي 1"),
            ),
            Expanded(
              child: ListView(
                children: [
                  ChatBubble(
                    text:
                        "هذا النص هو مثال للنص يمكن أن يستبدل في نفس المساحة لقد تم توليد هذا النص من مولد النص العربي",
                    time: "7:00 PM",
                    isCurrentUser: true,
                    imageUrl: null,
                  ),
                  ChatBubble(
                    text: "مرحبا",
                    time: "7:00 PM",
                    isCurrentUser: false,
                    imageUrl:
                        "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
                  ),
                ],
              ),
            ),
           const SendMessageWidget()
          ],
        ),
      ),
    );
  }
}

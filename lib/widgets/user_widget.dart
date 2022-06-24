import 'package:flutter/material.dart';
import 'package:flutter_task/helpers/app_colors.dart';
import 'package:flutter_task/helpers/images.dart';
import 'package:flutter_task/model/user.dart';
import 'package:google_fonts/google_fonts.dart';

class UserWidget extends StatelessWidget {
  final User user;
  const UserWidget({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6.5),
      padding: const EdgeInsets.all(12),
      width: MediaQuery.of(context).size.width,
      height: 68,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.05),
              offset: const Offset(0, 4),
              blurRadius: 12,
              spreadRadius: 0)
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: const AssetImage(Images.noImage),
            backgroundColor: Colors.transparent,
            radius: 22,
            foregroundImage: NetworkImage(user.image!),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user.fullName!,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w800,
                  fontSize: 17,
                  color: AppColors.textColor,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                user.gender!,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                  color: AppColors.textColor,
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}

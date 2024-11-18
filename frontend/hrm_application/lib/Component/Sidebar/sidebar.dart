import 'package:flutter/material.dart';
import 'package:hrm_application/Config/Services/Firebase/Auth/auth.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:sidebarx/sidebarx.dart';

class CustomSidebar extends StatelessWidget {
  const CustomSidebar({
    Key? key,
    required SidebarXController controller,
    required VoidCallback onLogout,
  })  : _controller = controller,
        _onLogout = onLogout,
        super(key: key);

  final VoidCallback _onLogout;
  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: snackBarColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: Colors.transparent,
        textStyle: TextStyle(color: textColor),
        selectedTextStyle: const TextStyle(color: textColor),
        hoverTextStyle: const TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: snackBarColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [authThemeColor, snackBarColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: textColor.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: textColor,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: snackBarColor,
        ),
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return extended
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          imgUrl != null ? NetworkImage(imgUrl!) : null,
                      child: imgUrl == null
                          ? const Icon(
                              Icons.person,
                              size: 20,
                            )
                          : Container(),
                    ),
                  ),
                  Text(
                    name ?? userEmail!,
                    style: const TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )
                ],
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      imgUrl != null ? NetworkImage(imgUrl!) : null,
                  child: imgUrl == null
                      ? const Icon(
                          Icons.person,
                          size: 20,
                        )
                      : Container(),
                ),
              );
      },
      items: [
        SidebarXItem(
          icon: Icons.home,
          label: 'Home',
          onTap: () {
            debugPrint('Home');
          },
        ),
        SidebarXItem(icon: Icons.assignment, label: 'Tasks', onTap: () {}),
        SidebarXItem(icon: Icons.settings, label: 'Settings', onTap: () {}),
        SidebarXItem(icon: Icons.logout, label: 'Log out', onTap: _onLogout),
      ],
    );
  }
}

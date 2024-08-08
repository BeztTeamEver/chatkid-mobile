import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/enum/todo.dart';
import 'package:chatkid_mobile/models/menu_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/target_store.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/todo_page/todo_create_page.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/target_page/target_template_page.dart';
import 'package:chatkid_mobile/pages/routes/target_create_route.dart';
import 'package:chatkid_mobile/pages/routes/todo_create_route.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/bottom_menu.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MainPage extends ConsumerStatefulWidget {
  final int index;
  const MainPage({super.key, this.index = 0});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  int _currentIndex = 0;
  late UserModel _currentAccount;

  @override
  void initState() {
    super.initState();

    setState(() {
      _currentIndex = widget.index;
      _currentAccount = LocalStorage.instance.getUser();
    });
  }

  void onTap(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final data =
    //     ref.watch(userProvider.notifier).getUser(currentAccount.id!, null);
    List<Widget> menu =
        MenuList(role: _currentAccount.role ?? RoleConstant.Child).getWidgets();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            if (!didPop) {
              return;
            }
            Navigator.of(context).pop();
          },
          child: IndexedStack(
            index: _currentIndex,
            children: menu,
          ),
        ),
      ),
      floatingActionButton: _currentAccount.role == RoleConstant.Parent
          ? Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor.withOpacity(0.08),
                      spreadRadius: 0,
                      blurRadius: 0.5,
                      offset: const Offset(0, -1),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                child: FloatingActionButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CreateTaskModal();
                      },
                    );
                  },
                  elevation: 0,
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.add_sharp,
                    size: 42,
                    color: Colors.white,
                  ),
                  backgroundColor: primary.shade500,
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      bottomNavigationBar: SafeArea(
        maintainBottomViewPadding: false,
        child: BottomMenu(
          currentIndex: _currentIndex,
          onTap: onTap,
        ),
      ),
    );
  }
}

class CreateTaskModal extends StatefulWidget {
  const CreateTaskModal({super.key});

  @override
  State<CreateTaskModal> createState() => _CreateTaskModalState();
}

class _CreateTaskModalState extends State<CreateTaskModal> {
  void onSelectedCreateType(TodoCreateType type) {
    switch (type) {
      case TodoCreateType.TASK:
        Navigator.of(context).push(createRoute(() => TodoCreateRoute()));
        break;
      case TodoCreateType.CAMPAIGN:
        Navigator.of(context).push(createRoute(() => TargetCreateRoute()));
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(12),
      contentPadding: EdgeInsets.all(12),
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomCard(
                  padding: EdgeInsets.all(8),
                  onTap: () => onSelectedCreateType(TodoCreateType.TASK),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: primary.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 145,
                        child: SvgPicture.asset(
                          'assets/todoPage/createCard1.svg',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tạo công việc',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontSize: 16,
                              ),
                    ),
                  ],
                ),
                CustomCard(
                  padding: EdgeInsets.all(8),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: primary.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 145,
                        child: SvgPicture.asset(
                          'assets/todoPage/createCard2.svg',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tạo mục tiêu',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontSize: 16,
                              ),
                    ),
                  ],
                  onTap: () {
                    onSelectedCreateType(TodoCreateType.CAMPAIGN);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              padding: EdgeInsets.all(8),
              icon: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: primary.shade500,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                  size: 32,
                  weight: 700,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:chatkid_mobile/models/paging_model.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/widgets/category_item.dart';
import 'package:chatkid_mobile/pages/home_page/widgets/custom_tab_bar.dart';
import 'package:chatkid_mobile/providers/task_categories_provider.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/button_icon.dart';
import 'package:chatkid_mobile/widgets/secondary_button.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class TodoCreatePage extends ConsumerStatefulWidget {
  const TodoCreatePage({super.key});

  @override
  ConsumerState<TodoCreatePage> createState() => _TodoCreatePageState();
}

class _TodoCreatePageState extends ConsumerState<TodoCreatePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final TodoFormCreateController todoFormCreateController = Get.find();

  int pageNumber = 0;
  int pageSize = 10;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final taskCategories = ref.watch(getTaskCategoriesProvider(
            PagingModel(pageSize: pageSize, pageNumber: pageNumber))
        .future);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          ButtonIcon(
            onPressed: () {},
            icon: 'edit',
          ),
        ],
        leading: Container(
          padding: const EdgeInsets.all(8),
          child: SecondaryButton(
            child: SvgIcon(
              icon: 'chevron-left',
              color: primary.shade500,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        centerTitle: true,
        title: Text(
          'Tạo công việc',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]),
              padding: const EdgeInsets.all(4),
              child: CustomTabbar(
                tabs: ['Tất cả', "Đã ghim"],
                onTabChange: (index) {
                  setState(() {
                    _tabController.animateTo(index);
                  });
                },
                tabController: _tabController,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: taskCategories,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  Logger().e(snapshot.error);
                  return const Center(
                    child: const Text('Đã xảy ra lỗi, vui lòng thử lại sau!'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  final items = snapshot.data;
                  if (items == null || items.isEmpty) {
                    return const Center(
                      child: Text('Không có dữ liệu'),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.only(top: 8, bottom: 26),
                    scrollDirection: Axis.vertical,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              items[index].name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    fontSize: 18,
                                    letterSpacing: 0.1,
                                  ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Wrap(
                              alignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              direction: Axis.horizontal,
                              spacing: 24,
                              runSpacing: 12,
                              children: items[index]
                                  .taskTypes
                                  .map(
                                    (item) => CategoryItem(
                                      imageUrl: item.imageUrl ?? '',
                                      title: item.name,
                                      selected: false,
                                      id: item.id,
                                      onTap: (id) {
                                        Logger().i(id);
                                      },
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:chatkid_mobile/models/target_model.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/target_store.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/target_page/target_form_page.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/target_page/widgets/template_card.dart';
import 'package:chatkid_mobile/pages/routes/target_create_route.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TargetTemplatePage extends StatefulWidget {
  const TargetTemplatePage({
    super.key,
  });

  @override
  State<TargetTemplatePage> createState() => _TargetTemplatePageState();
}

class _TargetTemplatePageState extends State<TargetTemplatePage> {
  final user = LocalStorage.instance.getUser();
  final TargetFormStore targetFormStore = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: FullWidthButton(
                onPressed: () {
                  targetFormStore.increaseStep();
                  targetFormStore.updateProgress();
                  Navigator.of(context)
                      .push(createRoute(() => TargetFormPage()));
                },
                child: Text(
                  'Tạo phong trào thi đua mới',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Hoặc ',
              style:
                  Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              'Mẫu Phong trào thi đua đã tạo',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Expanded(
              child: ListView(
                children: [
                  TemplateCard(
                    targetModel: TargetModel(
                      id: "1",
                      memberId: user.id ?? "1",
                      endTime: DateTime.now(),
                      message: 'Học bài 1',
                      startTime: DateTime.now(),
                      missions: [],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

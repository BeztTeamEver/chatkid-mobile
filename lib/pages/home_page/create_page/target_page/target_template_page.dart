import 'package:chatkid_mobile/models/target_model.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/target_store.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/target_page/target_form_page.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/target_page/widgets/template_card.dart';
import 'package:chatkid_mobile/pages/routes/target_create_route.dart';
import 'package:chatkid_mobile/providers/tartget_provider.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class TargetTemplatePage extends ConsumerStatefulWidget {
  const TargetTemplatePage({
    super.key,
  });

  @override
  ConsumerState<TargetTemplatePage> createState() => _TargetTemplatePageState();
}

class _TargetTemplatePageState extends ConsumerState<TargetTemplatePage> {
  final user = LocalStorage.instance.getUser();
  final TargetFormStore targetFormStore = Get.find();

  @override
  Widget build(BuildContext context) {
    final templates = ref.watch(getTemplateTargets.future);
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: FullWidthButton(
                onPressed: () {
                  targetFormStore.resetFields();
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
              child: FutureBuilder(
                future: templates,
                builder: (contextFuture, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Có lỗi xảy ra'),
                    );
                  }

                  final List<TargetModel> targetModels =
                      snapshot.data as List<TargetModel>;

                  return ListView.builder(
                    itemCount: targetModels.length,
                    itemBuilder: (context, index) {
                      final target = targetModels[index];

                      return TemplateCard(
                        targetModel: target,
                        onTap: () {
                          targetFormStore.setTarget(target);
                          targetFormStore.increaseStep();
                          targetFormStore.updateProgress();
                          Navigator.of(context)
                              .push(createRoute(() => TargetFormPage()));
                        },
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

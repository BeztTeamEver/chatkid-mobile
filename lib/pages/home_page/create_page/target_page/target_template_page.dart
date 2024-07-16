import 'package:chatkid_mobile/models/target_model.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/target_page/widgets/template_card.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TargetTemplatePage extends StatefulWidget {
  const TargetTemplatePage({
    super.key,
  });

  @override
  State<TargetTemplatePage> createState() => _TargetTemplatePageState();
}

class _TargetTemplatePageState extends State<TargetTemplatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: FullWidthButton(
                onPressed: () {},
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
                  TemplateCard(),
                  TemplateCard(),
                  TemplateCard(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

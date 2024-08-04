import 'package:chatkid_mobile/models/target_model.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TemplateCard extends StatefulWidget {
  final TargetModel targetModel;
  final void Function()? onTap;

  const TemplateCard({super.key, required this.targetModel, this.onTap});

  @override
  State<TemplateCard> createState() => _TemplateCardState();
}

class _TemplateCardState extends State<TemplateCard> {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      height: 180,
      onTap: widget.onTap,
      padding: EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.targetModel.message,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  // TODO: implement missions
                  Container(
                    height: 100,
                    child: ListView.builder(
                      itemCount: widget.targetModel.missions.length,
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        final mission = widget.targetModel.missions[index];
                        return Text("${mission.name} x ${mission.quantity}");
                      }),
                    ),
                  )
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.network(
                    widget.targetModel.rewardImageUrl ?? "",
                  ),
                ),
                Container(
                  width: 100,
                  child: Text(
                    widget.targetModel.reward ??
                        "asdlfjhasdklfhsadkjlfhsadlkjhflsakdjhflaskdjfhlkjsdahf lksadhfljksad fljksadh flkj sadlkjf asdlhf lkjasdh flkjashf kljas",
                    softWrap: true,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:chatkid_mobile/models/bot_asset_model.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardAssetItem extends StatelessWidget {
  final BotAssetModel botAsset;
  final String idLoading;
  final bool isSell;
  final bool isSellSelected;
  final Function(BotAssetModel) onClick;

  const CardAssetItem(
      {super.key,
      required this.botAsset,
      required this.idLoading,
      this.isSell = false,
      this.isSellSelected = false,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(22.0)),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(0.09),
                spreadRadius: 0,
                blurRadius: 12,
                offset: const Offset(1, 6),
              ),
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(0.06),
                spreadRadius: 0,
                blurRadius: 2,
                offset: const Offset(1, -1),
              ),
            ],
          ),
          child: Card(
            shadowColor: Colors.transparent,
            margin: const EdgeInsets.all(0),
            color: isSellSelected
                ? secondary.shade100
                : botAsset.status == 'Equipped'
                    ? primary.shade100
                    : Colors.white,
            child: InkWell(
              onTap: () => onClick(botAsset),
              child: Stack(
                children: <Widget>[
                  Image.network(
                    botAsset.previewImageUrl ??
                        'https://static.thenounproject.com/png/4974686-200.png',
                    width: (MediaQuery.of(context).size.width - 56) / 3,
                    height: (MediaQuery.of(context).size.width - 56) / 3,
                    fit: BoxFit.fitHeight,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: (MediaQuery.of(context).size.width - 56) / 3,
                        height: (MediaQuery.of(context).size.width - 56) / 3,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Visibility(
                      visible: botAsset.id == idLoading,
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 56) / 3,
                        height: (MediaQuery.of(context).size.width - 56) / 3,
                        color: Colors.black38,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: isSell,
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(22.0)),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withOpacity(0.09),
                    spreadRadius: 0,
                    blurRadius: 12,
                    offset: const Offset(1, 6),
                  ),
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withOpacity(0.06),
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: const Offset(1, -1),
                  ),
                ],
              ),
              width: (MediaQuery.of(context).size.width - 56) / 3,
              height: 30,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icons/diamond_icon.png",
                      width: 16,
                    ),
                    Text(
                      botAsset.price.toString(),
                    ),
                  ]),
            ),
          ),
        ),
      ],
    );
  }
}

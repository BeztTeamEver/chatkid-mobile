import 'dart:convert';

import 'package:chatkid_mobile/models/bot_asset_model.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CardAssetItem extends StatelessWidget {
  final BotAssetModel botAsset;
  final String idLoading;
  final Function(String, String) onClick;

  const CardAssetItem(
      {super.key,
      required this.botAsset,
      required this.idLoading,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        color: botAsset.status == 'Equipped' ? primary.shade100 : Colors.white,
        child: InkWell(
          onTap: () => Logger().i(jsonEncode(botAsset)),
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
    );
  }
}

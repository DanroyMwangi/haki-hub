import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:haki_hub/domain/models/helpline.dart';
import 'package:haki_hub/domain/value_objects/utils.dart';
import 'package:haki_hub/domain/value_objects/enums.dart';
import 'package:haki_hub/domain/value_objects/strings.dart';
import 'package:haki_hub/presentation/shared/app_scaffold.dart';
import 'package:haki_hub/presentation/helplines/widgets/helpline_tile.dart';

class AmbulanceHelplinePage extends StatelessWidget {
  const AmbulanceHelplinePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Helpline> ambulanceHelplines = helplineData.where(
      (Helpline helpline) => helpline.category == HelplineCategory.Ambulance
    ).toList();

    return AppScaffold(
      title: ambulanceHelplinesString,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: ambulanceHelplines.map((Helpline helpline) {
            return HelplineTile(
                title: helpline.title,
                phone: helpline.phone,
                onPressed: () async {
                  final Uri uri = Uri(scheme: 'tel', path: helpline.phone);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  } else {
                    throw 'Could not launch $uri';
                  }
                });
          }).toList(),
        ),
      ),
    );
  }
}

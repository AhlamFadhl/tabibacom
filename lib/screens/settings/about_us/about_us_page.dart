import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_image.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_sized_box.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text.dart';
import 'package:tabibacom_doctor/shared/components/images.dart';
import 'package:tabibacom_doctor/shared/styles/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('طبيبكم'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomImage(
            url: iconLogo,
            height: 300,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomText(
              'منصة الكترونيه لحجز الأطباء في عدن',
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          CustomSizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomText(
              '''تطبيق يعمل على جمع منشئات الرعايه الصحيه والاطباء في مكان واحد تهدف الى تسهيل وتحسين حجز مواعيد الاطباء .. المشروع يستهدف من يرغبون في الحصول على خدمة طبيه سريعه ومريحه .
          نهدف إلى تحسين تجربة المرضى في حجز ومتابعة الرعاية الطبية، وتوفير حلاً شاملاً وموثوقًا للمرضى والأطباء على حد سواء. من خلال توفير منصة سهلة وموثوقة لحجز الأطباء، تساهم في تحسين الرعاية الصحية و وتوفير راحة بال المرضئ  وعدم إهدار وقتهم في الانتظار لساعات طويله حتئ يحين دورهم.''',
              textAlign: TextAlign.center,
            ),
          ),
          CustomSizedBox(
            height: 20,
          ),
          CustomText(
            'تواصل معنا على',
            color: textGrayColor,
          ),
          CustomSizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomSizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      FontAwesomeIcons.whatsapp,
                      color: primaryColor,
                    ),
                  ),
                  CustomSizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.email,
                      color: primaryColor,
                    ),
                  ),
                  CustomSizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      FontAwesomeIcons.facebookF,
                      color: primaryColor,
                    ),
                  ),
                  CustomSizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      FontAwesomeIcons.instagram,
                      color: primaryColor,
                    ),
                  ),
                  CustomSizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      FontAwesomeIcons.linkedinIn,
                      color: primaryColor,
                    ),
                  ),
                  CustomSizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

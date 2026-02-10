import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff08A1A7),
        title: const Text('Privacy Policy'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Text(
                'Last updated: December 14, 2022\n\nThis Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.\n\nWe use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy.',
                style: TextStyle(fontSize: 16.0),
              ),

              SizedBox(height: 16.0),
              Text(
                'Interpretation and Definitions',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'Interpretation',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),

              Text(
                'Definitions',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'For the purposes of this Privacy Policy:\n',
                style: TextStyle(fontSize: 16.0),
              ),

              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '• Account ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                      'means a unique account created for You to access our Service or parts of our Service.\n\n',
                    ),
                    TextSpan(
                      text: '• Affiliate ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                      'means an entity that controls, is controlled by or is under common control with a party, where "control" means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election of directors or other managing authority.\n\n',
                    ),
                    TextSpan(
                      text: '• Application ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                      'means the software program provided by the Company downloaded by You on any electronic device, named KP Super App\n\n',
                    ),
                    TextSpan(
                      text: '• Company ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                      '(referred to as either "the Company", "We", "Us" or "Our" in this Agreement) refers to Khyber Pakhtunkhwa Government, Khyber Pakhtunkhwa IT Board 134, Industrial Estate, Hayatabad, Peshawar, Khyber Pakhtunkhwa, Pakistan.\n\n',
                    ),
                    TextSpan(
                      text: '• Country ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                      'refers to: Pakistan\n\n',
                    ),
                    TextSpan(
                      text: '• Device ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                      'means any device that can access the Service such as a computer, a cellphone or a digital tablet.\n\n',
                    ),
                    TextSpan(
                      text: '• Personal Data ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                      'is any information that relates to an identified or identifiable individual.\n\n',
                    ),
                    TextSpan(
                      text: '• Service ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                      'refers to the Application.\n\n',
                    ),
                    TextSpan(
                      text:'• Service Provider ',
                      style :TextStyle(fontWeight :FontWeight.bold),
                    ),
                    TextSpan(text:'means any natural or legal person who processes the data on behalf of the Company. It refers to third-party companies or individuals employed by the Company to facilitate the Service, to provide the Service on behalf of the Company, to perform services related to the Service or to assist the Company in analyzing how the Service is used.\n\n'),
                    TextSpan(text:'• You ',style :TextStyle(fontWeight :FontWeight.bold)),
                    TextSpan(text:'means the individual accessing or using the Service, or the company, or other legal entity on behalf of which such individual is accessing or using the Service, as applicable.'),
                  ],
                ),
              ),
              SizedBox(height: 18,),
              Text(
                'Collecting and Using Your Personal Data',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),

              Text(
                'Types of Data Collected',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),

              Text(
                'Personal Data',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.0),
              Text(
                'While using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to:\n',
                style: TextStyle(fontSize: 16.0),
              ),

              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '   • ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                      'Email address\n',
                    ),

                    TextSpan(
                      text: '   • ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                      'First name and last name\n',
                    ),


                    TextSpan(
                      text: '   • ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                      'Phone number\n',
                    ),

                    TextSpan(
                      text: '   • ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                      'Address, State, Province, ZIP/Postal code, City\n',
                    ),


                    TextSpan(
                      text: '   • ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                      'Usage Data\n',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8,),

              Text(
                'Usage Data',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.0),
              Text(

                'Usage Data is collected automatically when using the Service.\n\nUsage Data may include information such as Your Device\'s Internet Protocol address (e.g. IP address), browser type, browser version, the pages of our Service that You visit, the time and date of Your visit, the time spent on those pages, unique device identifiers and other diagnostic data.\n\nWhen You access the Service by or through a mobile device, We may collect certain information automatically, including, but not limited to, the type of mobile device You use, Your mobile device unique ID, the IP address of Your mobile device, Your mobile operating system, the type of mobile Internet browser You use, unique device identifiers and other diagnostic data.\n\nWe may also collect information that Your browser sends whenever You visit our Service or when You access the Service by or through a mobile device.',
                style: TextStyle(fontSize: 16.0),
              ),

              SizedBox(height: 10.0),

              Text(
                '\nInformation Collected while Using the Application',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.0),
              Text(
                "While using Our Application, in order to provide features of Our Application, We may collect, with Your prior permission:",
   style: TextStyle(fontSize: 16.0),
              ),

              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '\n   • ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                      'Information regarding your location\n',
                    ),


                    TextSpan(
                      text: '   • ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                      'Information from your Device''s phone book (contacts list)\n',
                    ),

                    TextSpan(
                      text: '   • ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                      'Pictures and other information from your Device''s camera and photo library\n',
                    ),



                  ],
                ),
              ),

              SizedBox(height: 5.0),
              Text(
                "We use this information to provide features of Our Service, to improve and customize Our Service. The information may be uploaded to the Company's servers and/or a Service Provider's server or it may be simply stored on Your device.\n\nYou can enable or disable access to this information at any time, through Your Device settings.",
                style: TextStyle(fontSize: 16.0),
              ),

              SizedBox(height: 20.0),
              Text(
                'Use of Your Personal Data',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'The Company may use Personal Data for the following purposes:\n',
                style: TextStyle(fontSize: 16.0),
              ),

              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '• To provide and maintain our Service, ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                      'including to monitor the usage of our Service.\n\n',
                    ),
                    TextSpan(
                      text: '• To manage Your Account: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                      'to manage Your registration as a user of the Service. The Personal Data You provide can give You access to different functionalities of the Service that are available to You as a registered user.\n\n',
                    ),
                    TextSpan(
                      text: '• For the performance of a contract: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                      'the development, compliance and undertaking of the purchase contract for the products, items or services You have purchased or of any other contract with Us through the Service.\n\n',
                    ),
                    TextSpan(
                      text: '• To contact You: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                      'To contact You by email, telephone calls, SMS, or other equivalent forms of electronic communication, such as a mobile application''s push notifications regarding updates or informative communications related to the functionalities, products or contracted services, including the security updates, when necessary or reasonable for their implementation.\n\n',
                    ),
                    TextSpan(
                      text: '• To provide You ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                      'with news, special offers and general information about other goods, services and events which we offer that are similar to those that you have already purchased or enquired about unless You have opted not to receive such information.\n\n',
                    ),
                    TextSpan(
                      text: '• To manage Your requests: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                      'To attend and manage Your requests to Us.\n\n',
                    ),
                    TextSpan(
                      text: '• For business transfers: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                      'We may use Your information to evaluate or conduct a merger, divestiture, restructuring, reorganization, dissolution, or other sale or transfer of some or all of Our assets, whether as a going concern or as part of bankruptcy, liquidation, or similar proceeding, in which Personal Data held by Us about our Service users is among the assets transferred.\n\n',
                    ),
                    TextSpan(
                      text: '• For other purposes: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                      'We may use Your information for other purposes, such as data analysis, identifying usage trends, determining the effectiveness of our promotional campaigns and to evaluate and improve our Service, products, services, marketing and your experience.\n\n',
                    ),
                  ],
                ),
              ),

              Text(
                'We may share Your personal information in the following situations:\n',
                style: TextStyle(fontSize: 16.0),
              ),

              SizedBox(height: 10,),

              Text.rich(
                TextSpan(
                  children: [


                    TextSpan(
                      text:'• With Service Providers: ',
                      style :TextStyle(fontWeight :FontWeight.bold),
                    ),
                    TextSpan(text:'We may share Your personal information with Service Providers to monitor and analyze the use of our Service, to contact You.\n\n'),
                    TextSpan(text:'• For business transfers: ',style :TextStyle(fontWeight :FontWeight.bold)),
                    TextSpan(text:' We may share or transfer Your personal information in connection with, or during negotiations of, any merger, sale of Company assets, financing, or acquisition of all or a portion of Our business to another company.'),
                    TextSpan(text:'\n\n• With Affiliates: ',style :TextStyle(fontWeight :FontWeight.bold)),
                    TextSpan(text:' We may share Your information with Our affiliates, in which case we will require those affiliates to honor this Privacy Policy. Affiliates include Our parent company and any other subsidiaries, joint venture partners or other companies that We control or that are under common control with Us.'),



                    TextSpan(text:'\n\n• With business partners: ',style :TextStyle(fontWeight :FontWeight.bold)),
                    TextSpan(text:' We may share Your information with Our business partners to offer You certain products, services or promotions.'),


                    TextSpan(text:'\n\n• With other users: ',style :TextStyle(fontWeight :FontWeight.bold)),
                    TextSpan(text:' when You share personal information or otherwise interact in the public areas with other users, such information may be viewed by all users and may be publicly distributed outside.'),

                    TextSpan(text:'\n\n• With Your consent: ',style :TextStyle(fontWeight :FontWeight.bold)),
                    TextSpan(text:'  We may disclose Your personal information for any other purpose with Your consent.'),





                  ],
                ),
              ),




              SizedBox(height: 20.0),
              Text(
                'Retention of Your Personal Data',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'The Company will retain Your Personal Data only for as long as is necessary for the purposes set out in this Privacy Policy. We will retain and use Your Personal Data to the extent necessary to comply with our legal obligations (for example, if we are required to retain your data to comply with applicable laws), resolve disputes, and enforce our legal agreements and policies.\n\nThe Company will also retain Usage Data for internal analysis purposes. Usage Data is generally retained for a shorter period of time, except when this data is used to strengthen the security or to improve the functionality of Our Service, or We are legally obligated to retain this data for longer time periods.',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 8.0),




              SizedBox(height: 20.0),
              Text(
                'Transfer of Your Personal Data',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
               "Your information, including Personal Data, is processed at the Company's operating offices and in any other places where the parties involved in the processing are located. It means that this information may be transferred to — and maintained on — computers located outside of Your state, province, country or other governmental jurisdiction where the data protection laws may differ than those from Your jurisdiction.\n\nYour consent to this Privacy Policy followed by Your submission of such information represents Your agreement to that transfer.\n\nThe Company will take all steps reasonably necessary to ensure that Your data is treated securely and in accordance with this Privacy Policy and no transfer of Your Personal Data will take place to an organization or a country unless there are adequate controls in place including the security of Your data and other personal information.",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 8.0),





              SizedBox(height: 20.0),
              Text(
                'Delete Your Personal Data',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
               "You have the right to delete or request that We assist in deleting the Personal Data that We have collected about You.\n\nOur Service may give You the ability to delete certain information about You from within the Service\n\nYou may update, amend, or delete Your information at any time by signing in to Your Account, if you have one, and visiting the account settings section that allows you to manage Your personal information. You may also contact Us to request access to, correct, or delete any personal information that You have provided to Us.\n\nPlease note, however, that We may need to retain certain information when we have a legal obligation or lawful basis to do so.",
                   style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 8.0),



              SizedBox(height: 20.0),
              Text(
                'Disclosure of Your Personal Data',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),




              SizedBox(height: 10.0),
              Text(
                'Business Transactions',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
               "If the Company is involved in a merger, acquisition or asset sale, Your Personal Data may be transferred. We will provide notice before Your Personal Data is transferred and becomes subject to a different Privacy Policy.",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 8.0),











              SizedBox(height: 10.0),
              Text(
                'Law enforcement',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                "Under certain circumstances, the Company may be required to disclose Your Personal Data if required to do so by law or in response to valid requests by public authorities (e.g. a court or a government agency).",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 8.0),





              SizedBox(height: 10.0),
              Text(
                'Other legal requirements',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                "The Company may disclose Your Personal Data in the good faith belief that such action is necessary to:",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 8.0),

              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: '   • ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    TextSpan(text: 'Comply with a legal obligation\n', style: TextStyle(fontSize: 14)),
                    TextSpan(text: '   • ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    TextSpan(text: 'Protect and defend the rights or property of the Company\n', style: TextStyle(fontSize: 14)),
                    TextSpan(text: '   • ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    TextSpan(text: 'Prevent or investigate possible wrongdoing in connection with the Service\n', style: TextStyle(fontSize: 14)),
                    TextSpan(text: '   • ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    TextSpan(text: 'Protect the personal safety of Users of the Service or the public\n', style: TextStyle(fontSize: 14)),
                    TextSpan(text: '   • ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    TextSpan(text: 'Protect against legal liability\n', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),





              SizedBox(height: 10.0),
              Text(
                'Security of Your Personal Data',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                "The security of Your Personal Data is important to Us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While We strive to use commercially acceptable means to protect Your Personal Data, We cannot guarantee its absolute security.",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 8.0),








              SizedBox(height: 10.0),
              Text(
                'Children\'s Privacy',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                "Our Service does not address anyone under the age of 13. We do not knowingly collect personally identifiable information from anyone under the age of 13. If You are a parent or guardian and You are aware that Your child has provided Us with Personal Data, please contact Us. If We become aware that We have collected Personal Data from anyone under the age of 13 without verification of parental consent, We take steps to remove that information from Our servers.\n\nIf We need to rely on consent as a legal basis for processing Your information and Your country requires consent from a parent, We may require Your parent's consent before We collect and use that information.",
                   style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 8.0),







              SizedBox(height: 10.0),
              Text(
                'Links to Other Websites',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
               "Our Service may contain links to other websites that are not operated by Us. If You click on a third party link, You will be directed to that third party's site. We strongly advise You to review the Privacy Policy of every site You visit.\n\nWe have no control over and assume no responsibility for the content, privacy policies or practices of any third party sites or services.",
                 style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 8.0),








              SizedBox(height: 10.0),
              Text(
                'Changes to this Privacy Policy',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                "We may update Our Privacy Policy from time to time. We will notify You of any changes by posting the new Privacy Policy on this page.\n\nWe will let You know via email and/or a prominent notice on Our Service, prior to the change becoming effective and update the \"Last updated\" date at the top of this Privacy Policy.\n\nYou are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page",
                 style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),

              ),
              SizedBox(height: 8.0),



              SizedBox(height: 10.0),
              Text(
                'Contact Us',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                "If you have any questions about this Privacy Policy, You can contact us:",
                   style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),

              ),
              SizedBox(height: 8.0),

              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: '• ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    TextSpan(text: 'By email: info@kpitb.gov.pk\n', style: TextStyle(fontSize: 14)),
                    TextSpan(text: '• ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    TextSpan(text: 'By visiting this page on our website: https://www.kpitb.gov.pk/\n', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),


              SizedBox(height: 18.0),



            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/modules/auth/controllers/register_controller.dart';
import 'package:my_egabat/app/shared/styles/text_field_styles.dart';

class Register extends GetView<RegisterController> {
  const Register({super.key});

  Widget selectTypeWidget(
          List typesList, void Function(dynamic newValue) onSelectedFun) =>
      PopupMenuButton(
        icon: const Icon(
          Icons.arrow_drop_down_sharp,
        ),
        onSelected: onSelectedFun,
        itemBuilder: (_) => (typesList)
            .map(
              (type) => PopupMenuItem(
                value: type,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(type.name),
                  ],
                ),
              ),
            )
            .toList(),
      );
  @override
  Widget build(BuildContext context) {
    final double pageHeight =
        Get.size.height - MediaQuery.of(context).padding.top;
    controller.getSections();

    return SizedBox(
      height: pageHeight / 2,
      child: Form(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller.nameController,
                  decoration: authInputDecoration(labelText: "الاسم"),
                  textInputAction: TextInputAction.next,
                  validator: (value) => value?.isEmpty ?? true
                      ? "ادخل اسمك من فضلك"
                      : value!.length < 3
                          ? "يجب ان يكون اسمك من 3 حروف على الاقل"
                          : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller.nickNameController,
                  decoration: authInputDecoration(labelText: "الاسم المستعار"),
                  textInputAction: TextInputAction.next,
                  validator: (value) => value?.isEmpty ?? true
                      ? "ادخل اسمك المستعار من فضلك"
                      : value!.length < 3
                          ? "يجب ان يكون الاسم المستعار من 3 حروف على الاقل"
                          : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller.emailController,
                  decoration:
                      authInputDecoration(labelText: "البريد الالكتروني"),
                  textInputAction: TextInputAction.next,
                  validator: (value) => value?.isEmpty ?? true
                      ? "ادخل برديك الالكتروني"
                      : !value!.contains("@") || !value.contains(".")
                          ? "ادخل بريد الالكتروني صحيح"
                          : null,
                ),
              ),

              // get section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  readOnly: true,
                  controller: controller.sectionController,
                  decoration: authInputDecoration(hintText: "اختر نوع المدرسة")
                      .copyWith(
                    suffixIcon: selectTypeWidget(
                      controller.sections,
                      (newSection) async {
                        controller.sectionId = newSection.id;
                        controller.sectionController.text = newSection.name;
                        await controller.getStages();
                      },
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller.stageController,
                  readOnly: true,
                  decoration:
                      authInputDecoration(labelText: "اختر المرحلة الدراسية")
                          .copyWith(
                    suffixIcon: selectTypeWidget(
                      controller.sections,
                      (newStage) async {
                        controller.stageId = newStage.id;
                        controller.stageController.text = newStage.name;
                        await controller.getGrades();
                      },
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller.gradeController,
                  readOnly: true,
                  decoration:
                      authInputDecoration(labelText: "اختر الصف الدراسي")
                          .copyWith(
                    suffixIcon: selectTypeWidget(
                      controller.grades,
                      (newGrade) async {
                        controller.gradeId = newGrade.id;
                        controller.gradeController.text = newGrade.name;
                      },
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


// class Registration extends StatefulWidget {
//   const Registration({super.key});

//   @override
//   State<Registration> createState() => _RegistrationState();
// }

// bool hasInternet = true;

// class _RegistrationState extends State<Registration> {
//   final GlobalKey<FormState> _name = GlobalKey();
//   final GlobalKey<FormState> _nickName = GlobalKey();
//   final GlobalKey<FormState> _email = GlobalKey();
//   TextEditingController name = TextEditingController();
//   TextEditingController nickname = TextEditingController();
//   TextEditingController email = TextEditingController();
//   List sections = [];
//   String? userSecId;
//   String? sectionselected;
//   var id = Get.arguments[2];
//   //stage part
//   List stages = [];
//   String? stageId;
//   String? stageSelected;
//   //grage part

//   String? gradId;
//   String? gradeSelected;
// //constants
//   String? _token;

//   String? mobile;
//   String? profileImage;

//   bool hasInternet = true;
//   // final ImagePicker _picker = ImagePicker();
//   // XFile? image;
//   File? imagefile;

//   bool loadimage = false;

//   var countryId = Get.arguments[0];
//   String num = Get.arguments[1];

//   @override
//   void initState() {
//     print(stageSelected);
//     getSection();
//     getStage();
//     getGrade();

//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     AppImage().getAppLogo().then((value) {
//       setState(() {});
//     });
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final scaffoldKey = GlobalKey<ScaffoldState>();
//     return SafeArea(
//         child: WillPopScope(
//       onWillPop: () async => false,
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: lightMood ? Colors.white : Colors.black,
//         key: scaffoldKey,
//         endDrawer: const MyDrawer(),
//         body: Column(
//           children: <Widget>[
//             Container(
//               color: Colors.green,
//               child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       onPressed: () async {
//                         SharedPreferences pref =
//                             await SharedPreferences.getInstance();
//                         pref.clear();
//                         // name);
//                         Get.to(const AuthScreen());
//                       },
//                       icon: Icon(
//                         Icons.arrow_back_ios_new_sharp,
//                         color: lightMood ? Colors.black : Colors.white,
//                         size: 30,
//                       ),
//                     ),
//                     const Spacer(),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width / 1.28,
//                       child: (appLogo == null)
//                           ? Image(
//                               fit: BoxFit.fill,
//                               image: AssetImage(
//                                 defaltAppLogo,
//                               ),
//                               width: 90,
//                               height: 70,
//                             )
//                           : Image(
//                               fit: BoxFit.fill,
//                               image: NetworkImage('$imageurl$appLogo'),
//                               width: 90,
//                               height: 70,
//                             ),
//                     ),
//                     const Spacer(),
//                   ]),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height / 1.3,
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(
//                           left: MediaQuery.of(context).size.width / 4,
//                           right: MediaQuery.of(context).size.width / 4),
//                       child: Container(
//                         height: MediaQuery.of(context).size.height / 7,
//                         decoration: BoxDecoration(
//                           image: loadimage
//                               ? DecorationImage(
//                                   image: FileImage(
//                                     File(
//                                       imagefile!.path.toString(),
//                                     ),
//                                   ),
//                                   fit: BoxFit.contain)
//                               : const DecorationImage(
//                                   image: AssetImage(
//                                     'assets/user.png',
//                                   ),
//                                 ),
//                           border: Border.all(
//                             color: Colors.lightGreen,
//                           ),
//                           shape: BoxShape.circle,
//                         ),
//                         child: InkWell(
//                           onTap: () {
//                             showDialog<void>(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return AlertDialog(
//                                     title: Text('select'.tr),
//                                     content: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             InkWell(
//                                               onTap: () {
//                                                 getimagefromgalleryandcamera(
//                                                     ImageSource.camera);
//                                               },
//                                               child: const Icon(
//                                                 Icons.camera,
//                                                 color: Colors.green,
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               width: 20,
//                                             ),
//                                             Text(
//                                               "camera".tr,
//                                               style: const TextStyle(
//                                                 fontWeight: FontWeight.w500,
//                                                 color: Colors.black,
//                                                 fontSize: 20,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         const SizedBox(
//                                           height: 20,
//                                         ),
//                                         Row(
//                                           children: [
//                                             InkWell(
//                                               onTap: () {
//                                                 getimagefromgalleryandcamera(
//                                                     ImageSource.gallery);
//                                               },
//                                               child: const Icon(
//                                                 Icons.image,
//                                                 color: Colors.green,
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               width: 20,
//                                             ),
//                                             Text(
//                                               "gallery".tr,
//                                               style: const TextStyle(
//                                                 fontWeight: FontWeight.w500,
//                                                 color: Colors.black,
//                                                 fontSize: 20,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ));
//                               },
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                     Container(
//                       margin:
//                           const EdgeInsets.only(left: 30, right: 30, top: 10),
//                       alignment: Alignment.center,
//                       child: Form(
//                         key: _name,
//                         child: TextFormField(
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'ادخل الاسم'.tr;
//                             }
//                             return null;
//                           },
//                           controller: name,
//                           style: GoogleFonts.cairo(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color: (lightMood) ? Colors.black : Colors.white),
//                           decoration: InputDecoration(
//                             focusedErrorBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(
//                                   color:
//                                       (lightMood) ? Colors.grey : Colors.white,
//                                   width: 1.0),
//                             ),
//                             errorBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(
//                                   color:
//                                       (lightMood) ? Colors.white : Colors.grey,
//                                   width: 1.0),
//                             ),
//                             prefixIcon: const Icon(
//                               Icons.person,
//                               color: Colors.green,
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(
//                                   color:
//                                       (lightMood) ? Colors.grey : Colors.white,
//                                   width: 1.0),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(
//                                   color:
//                                       (lightMood) ? Colors.grey : Colors.white,
//                                   width: 1.0),
//                             ),
//                             label: Text(
//                               "الاسم".tr,
//                               style: GoogleFonts.cairo(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500,
//                                   color: (lightMood)
//                                       ? Colors.black
//                                       : Colors.white),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       margin:
//                           const EdgeInsets.only(left: 30, right: 30, top: 10),
//                       alignment: Alignment.center,
//                       child: Form(
//                         key: _nickName,
//                         child: TextFormField(
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'ادخل الاسم المستعار'.tr;
//                             }
//                             return null;
//                           },
//                           controller: nickname,
//                           style: GoogleFonts.cairo(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color: (lightMood) ? Colors.black : Colors.white),
//                           decoration: InputDecoration(
//                             focusedErrorBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(
//                                   color:
//                                       (lightMood) ? Colors.grey : Colors.white,
//                                   width: 1.0),
//                             ),
//                             errorBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(
//                                   color:
//                                       (lightMood) ? Colors.white : Colors.grey,
//                                   width: 1.0),
//                             ),
//                             prefixIcon: const Icon(
//                               Icons.person,
//                               color: Colors.green,
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(
//                                   color:
//                                       (lightMood) ? Colors.grey : Colors.white,
//                                   width: 1.0),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(
//                                   color:
//                                       (lightMood) ? Colors.grey : Colors.white,
//                                   width: 1.0),
//                             ),
//                             label: Text(
//                               "الاسم المستعار".tr,
//                               style: GoogleFonts.cairo(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500,
//                                   color: (lightMood)
//                                       ? Colors.black
//                                       : Colors.white),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       margin:
//                           const EdgeInsets.only(left: 30, right: 30, top: 10),
//                       alignment: Alignment.center,
//                       child: Form(
//                         key: _email,
//                         child: TextFormField(
//                           showCursor: true,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'ادخل البريد الالكترونى'.tr;
//                             }
//                             return null;
//                           },
//                           controller: email,
//                           keyboardType: TextInputType.emailAddress,
//                           style: GoogleFonts.cairo(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color: (lightMood) ? Colors.black : Colors.white),
//                           decoration: InputDecoration(
//                             focusedErrorBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(
//                                   color:
//                                       (lightMood) ? Colors.grey : Colors.white,
//                                   width: 1.0),
//                             ),
//                             errorBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(
//                                   color:
//                                       (lightMood) ? Colors.white : Colors.grey,
//                                   width: 1.0),
//                             ),
//                             prefixIcon: const Icon(
//                               Icons.email_outlined,
//                               color: Colors.green,
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(
//                                   color:
//                                       (lightMood) ? Colors.grey : Colors.white,
//                                   width: 1.0),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(
//                                   color:
//                                       (lightMood) ? Colors.grey : Colors.white,
//                                   width: 1.0),
//                             ),
//                             label: Text(
//                               "البريد الالكترونى",
//                               style: GoogleFonts.cairo(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500,
//                                   color: (lightMood)
//                                       ? Colors.black
//                                       : Colors.white),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       margin:
//                           const EdgeInsets.only(left: 30, right: 30, top: 10),
//                       height: 70,
//                       child: DropdownButtonFormField2(
//                         alignment: Alignment.topCenter,
//                         hint: Text(
//                           'اختر نوع المدرسة'.tr,
//                           style: GoogleFonts.cairo(
//                               fontWeight: FontWeight.w600,
//                               color: (lightMood) ? Colors.black : Colors.white,
//                               fontSize: 13),
//                         ),
//                         dropdownStyleData: DropdownStyleData(
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                               colors: [
//                                 (lightMood)
//                                     ? const Color.fromARGB(156, 202, 200, 197)
//                                         .withOpacity(0.9)
//                                     : Colors.white,
//                                 (lightMood) ? Colors.amber : Colors.white,
//                               ],
//                             ),
//                           ),
//                         ),
//                         iconStyleData: const IconStyleData(
//                           icon: Icon(
//                             Icons.arrow_drop_down,
//                             color: Colors.green,
//                           ),
//                         ),
//                         decoration: InputDecoration(
//                           prefixIcon: const Icon(
//                             Icons.school_outlined,
//                             color: Colors.green,
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide(
//                                 color: (lightMood) ? Colors.grey : Colors.white,
//                                 width: 1.0),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide(
//                                 color: (lightMood) ? Colors.grey : Colors.white,
//                                 width: 1.0),
//                           ),
//                         ),
//                         style: GoogleFonts.cairo(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: (lightMood) ? Colors.black : Colors.white),
//                         value: sectionselected,
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             sectionselected = newValue!;
//                           });
//                         },
//                         items: sections
//                             .map<DropdownMenuItem<String>>(
//                               (e) => DropdownMenuItem(
//                                 onTap: () {
//                                   userSecId = e["sectionId"].toString();
//                                 },
//                                 value: e["sectionId"].toString(),
//                                 child: Text(
//                                   e["sectionName"],
//                                   style: GoogleFonts.cairo(
//                                       color: lightMood
//                                           ? Colors.black
//                                           : Colors.white,
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 13),
//                                 ),
//                               ),
//                             )
//                             .toList(),
//                       ),
//                     ),
//                     Container(
//                       margin:
//                           const EdgeInsets.only(left: 30, right: 30, top: 10),
//                       height: 70,
//                       child: DropdownButtonFormField2(
//                         alignment: Alignment.topCenter,
//                         hint: Text(
//                           'اختر المرحلة الدراسية'.tr,
//                           style: GoogleFonts.cairo(
//                               fontWeight: FontWeight.w600,
//                               color: (lightMood) ? Colors.black : Colors.white,
//                               fontSize: 13),
//                         ),
//                         dropdownStyleData: DropdownStyleData(
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                               colors: [
//                                 (lightMood)
//                                     ? const Color.fromARGB(156, 202, 200, 197)
//                                         .withOpacity(0.9)
//                                     : Colors.white,
//                                 (lightMood) ? Colors.amber : Colors.white,
//                               ],
//                             ),
//                           ),
//                         ),
//                         iconStyleData: const IconStyleData(
//                           icon: Icon(
//                             Icons.arrow_drop_down,
//                             color: Colors.green,
//                           ),
//                         ),
//                         decoration: InputDecoration(
//                           prefixIcon: const Icon(
//                             Icons.grade,
//                             color: Colors.green,
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide(
//                                 color: (lightMood) ? Colors.grey : Colors.white,
//                                 width: 1.0),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide(
//                                 color: (lightMood) ? Colors.grey : Colors.white,
//                                 width: 1.0),
//                           ),
//                         ),
//                         style: GoogleFonts.cairo(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: (lightMood) ? Colors.black : Colors.white),
//                         value: stageSelected,
//                         onChanged: (String? newValue) async {
//                           setState(() {
//                             gradeSelected = null;

//                             stageSelected = newValue!;
//                           });
//                           await getGrade();
//                         },
//                         items: stages
//                             .map<DropdownMenuItem<String>>(
//                               (e) => DropdownMenuItem(
//                                 onTap: () {
//                                   stageSelected = e["stageName"];
//                                   stageId = e['stageId'];
//                                 },
//                                 value: e["stageId"].toString(),
//                                 child: Text(
//                                   e["stageName"],
//                                   style: GoogleFonts.cairo(
//                                       color: lightMood
//                                           ? Colors.black
//                                           : Colors.white,
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 13),
//                                 ),
//                               ),
//                             )
//                             .toList(),
//                       ),
//                     ),
//                     Container(
//                       margin:
//                           const EdgeInsets.only(left: 30, right: 30, top: 10),
//                       height: 70,
//                       child: DropdownButtonFormField2(
//                         alignment: Alignment.topCenter,
//                         hint: Text(
//                           'اختر الصف الدراسى'.tr,
//                           style: GoogleFonts.cairo(
//                               fontWeight: FontWeight.w600,
//                               color: (lightMood) ? Colors.black : Colors.white,
//                               fontSize: 13),
//                         ),
//                         dropdownStyleData: DropdownStyleData(
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                               colors: [
//                                 (lightMood)
//                                     ? const Color.fromARGB(156, 202, 200, 197)
//                                         .withOpacity(0.9)
//                                     : Colors.white,
//                                 (lightMood) ? Colors.amber : Colors.white,
//                               ],
//                             ),
//                           ),
//                         ),
//                         iconStyleData: const IconStyleData(
//                           icon: Icon(
//                             Icons.arrow_drop_down,
//                             color: Colors.green,
//                           ),
//                         ),
//                         decoration: InputDecoration(
//                           prefixIcon: const Icon(
//                             Icons.numbers_outlined,
//                             color: Colors.green,
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide(
//                                 color: (lightMood) ? Colors.grey : Colors.white,
//                                 width: 1.0),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide(
//                                 color: (lightMood) ? Colors.grey : Colors.white,
//                                 width: 1.0),
//                           ),
//                         ),
//                         style: GoogleFonts.cairo(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: (lightMood) ? Colors.black : Colors.white),
//                         value: gradeSelected,
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             gradeSelected = newValue!;
//                           });
//                         },
//                         items: grades
//                             .map<DropdownMenuItem<String>>(
//                               (e) => DropdownMenuItem(
//                                 onTap: () {
//                                   gradId = e["gradeId"].toString();
//                                 },
//                                 value: e["gradeId"].toString(),
//                                 child: Text(
//                                   e["gradeName"],
//                                   style: GoogleFonts.cairo(
//                                       color: lightMood
//                                           ? Colors.black
//                                           : Colors.white,
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 13),
//                                 ),
//                               ),
//                             )
//                             .toList(),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                           left: 70.0, right: 70, bottom: 20),
//                       child: ElevatedButton(
//                           onPressed: () async {
//                             if (_name.currentState!.validate() &&
//                                 _email.currentState!.validate() &&
//                                 _nickName.currentState!.validate()) {
//                               await register();
//                               sendMessage();
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             backgroundColor: (Colors.green),
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 120),
//                             textStyle: GoogleFonts.cairo(
//                               color: Theme.of(context)
//                                   .primaryTextTheme
//                                   .labelLarge!
//                                   .color,
//                             ),
//                           ),
//                           child: const Text(
//                             'Save',
//                             style: TextStyle(color: Colors.white),
//                           )),
//                     ),
//                   ],
//                 ),
//               ),
//             )

//             //N
//           ],
//         ),
//         bottomSheet: ClipPath(
//           clipper: OvalTopBorderClipper(),
//           child: Container(
//             color: Colors.green[700],
//             height: MediaQuery.of(context).size.height / 9,
//             child: Align(
//               alignment: Alignment.topCenter,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 10),
//                 child: ElevatedButton.icon(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green[700],
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(40)),
//                       side: const BorderSide(
//                         width: 2.0,
//                         color: Colors.white,
//                       )),
//                   icon: const Icon(FontAwesome.whatsapp),
//                   label: Text(
//                     'Help',
//                     style: GoogleFonts.cairo(color: Colors.white, fontSize: 20),
//                   ),
//                   onPressed: () async {
//                     _launchWhatsapp(
//                         context: context, phoneNumber: '+96599811025');
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     ));
//   }

//   void getimagefromgalleryandcamera(ImageSource source) async {
//     try {
//       image = await _picker.pickImage(source: source);
//       // cropimage(image!.path);
//       if (image == null) return;
//       File? img = File(image!.path);
//       setState(() {
//         imagefile = img;
//         loadimage = true;
//       });
//       Get.back();
//     } on PlatformException catch (_) {
//       Navigator.pop(context);
//       rethrow;
//     }
//   }

//   Future<List> getStage() async {
//     await SharedPreferences.getInstance().then((value) {
//       _token = value.getString('token');
//     });
//     final url = '${baseurl}Stage/GetStages?countryId=$countryId';
//     final response = await http.get(Uri.parse(url), headers: {
//       "Content-Type": "application/json",
//       "Authorization": "Bearer" ' ' + _token!,
//     }).catchError((onError) {
//       Get.defaultDialog(
//         title: 'حدث خطأ',
//         middleText: hasInternet
//             ? 'لديك مشكلة فى الاتصال بالانترنت'.tr
//             : 'حدث خطأ فى الخادم ، راجع الدعم الفنى'.tr,
//         backgroundColor: lightMood ? Colors.white : Colors.black,
//         titleStyle: TextStyle(
//           color: lightMood ? Colors.black : Colors.white,
//         ),
//         middleTextStyle: TextStyle(
//           color: lightMood ? Colors.black : Colors.white,
//         ),
//       );
//       return onError;
//     });
//     List stageData = json.decode(response.body);

//     setState(() {
//       stages = stageData;
//     });

//     return stages;
//   }

//   //gettinig sections
//   Future<List> getSection() async {
//     await SharedPreferences.getInstance().then((value) {
//       _token = value.getString('token');
//     });
//     final url = '${baseurl}Section/GetSections?countryId=$countryId';
//     final response = await http.get(Uri.parse(url), headers: {
//       "Content-Type": "application/json",
//       "Authorization": "Bearer" ' ' + _token!,
//     }).catchError((onError) {
//       Get.defaultDialog(
//         title: 'حدث خطأ',
//         middleText: hasInternet
//             ? 'لديك مشكلة فى الاتصال بالانترنت'.tr
//             : 'حدث خطأ فى الخادم ، راجع الدعم الفنى'.tr,
//         backgroundColor: lightMood ? Colors.white : Colors.black,
//         titleStyle: TextStyle(
//           color: lightMood ? Colors.black : Colors.white,
//         ),
//         middleTextStyle: TextStyle(
//           color: lightMood ? Colors.black : Colors.white,
//         ),
//       );
//       return onError;
//     });

//     List sectionsData = json.decode(response.body);
//     setState(() {
//       sections = sectionsData;
//     });

//     return sections;
//   }

//   //getting grade
//   List grades = [];
//   Future<List> getGrade() async {
//     await SharedPreferences.getInstance().then((value) {
//       _token = value.getString('token');
//     });

//     grades = [];
//     final url = '${baseurl}Grade/GetGradesByStageId/$stageId';
//     final response = await http.get(Uri.parse(url), headers: {
//       "Content-Type": "application/json",
//       "Authorization": "Bearer" ' ' + _token!,
//     }).catchError((onError) {
//       Get.defaultDialog(
//         title: 'حدث خطأ',
//         middleText: hasInternet
//             ? 'لديك مشكلة فى الاتصال بالانترنت'.tr
//             : 'حدث خطأ فى الخادم ، راجع الدعم الفنى'.tr,
//         backgroundColor: lightMood ? Colors.white : Colors.black,
//         titleStyle: TextStyle(
//           color: lightMood ? Colors.black : Colors.white,
//         ),
//         middleTextStyle: TextStyle(
//           color: lightMood ? Colors.black : Colors.white,
//         ),
//       );
//       return onError;
//     });

//     var gradesdata = json.decode(response.body);

//     setState(() {
//       gradeSelected = null;
//       grades = gradesdata;
//     });
//     return grades;
//   }

//   Future<void> register() async {
//     Map<String, String> headers = {
//       "Authorization": "Bearer" ' ' + _token!,
//       "Content-Type": "multipart/form-data",
//     };
//     Future<http.MultipartFile> imgfile;
//     List<http.MultipartFile> multidata = [];
//     if (imagefile != null) {
//       imgfile = http.MultipartFile.fromPath(
//           'ProfileImage', imagefile!.path.toString());
//       multidata.add(await imgfile);
//     }

//     Map<String, String> requestBody = <String, String>{
//       'Name': name.text,
//       'NickName': nickname.text,
//       'GradeId': gradId!,
//       'Email': email.text,
//       'StageId': stageId!,
//       'SectionId': userSecId!,
//     };

//     final uri = Uri.parse('${baseurl}Student/StudentRegistration');

//     var request = http.MultipartRequest('Post', uri)
//       ..fields.addAll(requestBody)
//       ..files.addAll(
//         multidata,
//       );

//     request.headers.addAll(headers);
//     var response = await request.send().catchError((onError) {
//       Get.defaultDialog(
//         title: 'حدث خطأ',
//         middleText: hasInternet
//             ? 'لديك مشكلة فى الاتصال بالانترنت'.tr
//             : 'حدث خطأ فى الخادم ، راجع الدعم الفنى'.tr,
//         backgroundColor: lightMood ? Colors.white : Colors.black,
//         titleStyle: TextStyle(
//           color: lightMood ? Colors.black : Colors.white,
//         ),
//         middleTextStyle: TextStyle(
//           color: lightMood ? Colors.black : Colors.white,
//         ),
//       );
//       return onError;
//     });

//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     if (response.statusCode == 200) {
//       preferences.setBool('isexists', true);
//       Get.to(const Home());
//     }
//   }

//   Future<void> _launchWhatsapp(
//       {required BuildContext context, required String phoneNumber}) async {
//     // Phone number is in country code + number format (+11234567890)
//     var whatsappurl = "whatsapp://send?phone=$phoneNumber&text=اريد التواصل";
//     var androidUrl = Uri.parse(whatsappurl);
//     var iosUrlString = "wa.me/$phoneNumber?text=اريد التواصل";
//     var iosUrl = Uri.parse(iosUrlString);

//     // Will attempt to launch SMS message if the each platform's url cannot be launched ...
//     // Show snackbar error if failed
//     try {
//       if (Platform.isIOS) {
//         if (await canLaunchUrl(iosUrl)) {
//           await launchUrl(iosUrl,
//               mode: LaunchMode.externalApplication); // WORKS HERE
//         }
//       } else {
//         if (await canLaunchUrl(androidUrl)) {
//           await launchUrl(androidUrl,
//               mode: LaunchMode.externalNonBrowserApplication); // DOES NOT WORK
//         }
//       }
//     } on Exception {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("WhatsApp is not installed on the device"),
//         ),
//       );
//     }
//   }

//   Future<void> sendMessage() async {
//     final body = {
//       "isTeacher": false,
//       "message": ''' تم تسجيل طالب جديد  ''',
//       "senderId": id,
//       "MessageType": "Register",
//     };

//     var url = '${baseurl}Message/UserSendMessage';

//     Map<String, String> headers = {
//       "Content-Type": "application/json",
//       "Authorization": "Bearer" ' ' + _token!,
//     };
//     await http.post(Uri.parse(url), body: json.encode(body), headers: headers);
//     setState(() {});
//   }
// }

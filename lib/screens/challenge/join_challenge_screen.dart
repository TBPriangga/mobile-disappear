import 'package:disappear/themes/color_scheme.dart';
import 'package:disappear/view_models/challenge_modules/challenge_main_view_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';

class JoinChallengeScreen extends StatefulWidget {
  static const String routePath = '/join-challenge-screen';
  const JoinChallengeScreen({super.key});

  @override
  State<JoinChallengeScreen> createState() => _JoinChallengeScreenState();
}

class _JoinChallengeScreenState extends State<JoinChallengeScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController fileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();
    final arguments = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        elevation: 2.5,
        leading: const Icon(Icons.arrow_back_ios),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: primary40,
        title: Text(
          'Ikuti Tantangan',
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.only(left: 48, top: 50, right: 47.5),
          child: Consumer<ChallengeMainViewModel>(builder: (context, state, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Formulir bukti mengikuti',
                  style: GoogleFonts.inter().copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Username',
                  style: GoogleFonts.inter().copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Field tidak boleh kosong';
                    }
                    return null;
                  },
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan username instagram anda',
                    hintStyle: GoogleFonts.inter().copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    contentPadding: const EdgeInsets.only(left: 10),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Bukti',
                  style: GoogleFonts.inter().copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: 300,
                  height: 45,
                  // padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      filePicker(context),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field tidak boleh kosong';
                            }
                            return null;
                          },
                          controller: fileController,
                          readOnly: true,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(8),
                              border: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              fillColor: Colors.white,
                              filled: true),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 180),
                  child: ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        final int id = arguments as int;
                        final String username = usernameController.text;
                        final String filePath = fileController.text;
                        state.postChallenge(id, username, filePath);
                        Navigator.of(context).pop();
                      }
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                    child: const Text('Kirim'),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget filePicker(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.all(5)),
          minimumSize: MaterialStateProperty.all<Size>(
            const Size(30, 20),
          ),
        ),
        onPressed: () {
          _pickFile();
        },
        child: const Text(
          'Pilih Berkas',
          style: TextStyle(
            fontSize: 10,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ));
  }

  // void _pickFile() async {
  //   final result = await FilePicker.platform.pickFiles();
  //   if (result != null) {}

  //   // _openFile(file);
  // }

  void _pickFile() async {
    final ChallengeMainViewModel viewModel =
        Provider.of<ChallengeMainViewModel>(context, listen: false);


    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
       
      String filePath = result.files.single.path ?? ''; // Get the file path
      viewModel.filePath = filePath;
      fileController.text = filePath;
    }
  }

  // void _openFile(PlatformFile file) {
  //   OpenFile.open(file.path);
  //   debugPrint(file.path);
  // }

  
}
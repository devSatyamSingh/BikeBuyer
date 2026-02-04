import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final String name;
  final String number;

  const EditProfilePage({
    super.key,
    required this.name,
    required this.number,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}
class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController numberController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    numberController = TextEditingController(text: widget.number);
  }
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("Edit Profile", style: TextStyle(fontFamily: 'Poppins',),),
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        titleSpacing: 3,
      ),
      body: Padding(
        padding: EdgeInsets.all(w * 0.06),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(w * 0.0062),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purple.shade100,
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.2),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: w * 0.10,
                backgroundColor: Colors.grey.shade200,
                child: Text(
                  nameController.text.isNotEmpty
                      ? nameController.text[0].toUpperCase()
                      : "U",
                  style: TextStyle(
                    fontSize: w * 0.11,
                    fontFamily: 'Poppins',
                    color: Colors.purple,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
             SizedBox(height: h*0.033),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
                labelStyle: TextStyle(fontFamily: 'Poppins',),
                filled: true,
              ),
            ),
            SizedBox(height: h*0.020),
            TextField(
              controller: numberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Mobile Number",
                labelStyle: TextStyle(fontFamily: 'Poppins',),
                filled: true,
              ),
            ),
            SizedBox(height: h*0.045,),
            Row(
              children: [
                SizedBox(
                  height: h*0.050,
                  width: w*0.41,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Center(child: Text("Cancel", style: TextStyle(fontFamily: 'Poppins', fontSize: w*0.031),)),
                  ),
                ),
                SizedBox(width: w*0.030),
                SizedBox(
                  height: h*0.050,
                  width: w*0.41,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, {
                        "name": nameController.text,
                        "number": numberController.text,
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                    ),
                    child: Center(child: Text("Save Changes", style: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontSize: w*0.031),)),
                  ),
                ),
              ],
            ),
            Spacer(),
            Center(child: Text('BikeBuyer', style: TextStyle(color: Colors.grey.shade400),))
          ],
        ),
      ),
    );
  }
}

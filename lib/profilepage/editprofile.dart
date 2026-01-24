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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 2,
      ),
      body: Padding(
        padding: EdgeInsets.all(w * 0.06),
        child: Column(
          children: [
            CircleAvatar(
              radius: 44,
              backgroundColor: Colors.purple.shade100.withAlpha(100),
              child: Text(
                nameController.text.isNotEmpty
                    ? nameController.text[0].toUpperCase()
                    : "U",
                style: TextStyle(
                  fontSize: w*0.10,
                  color: Colors.purple,
                ),
              ),
            ),
             SizedBox(height: h*0.033),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
                filled: true,
              ),
            ),
            SizedBox(height: h*0.020),
            TextField(
              controller: numberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Mobile Number",
                filled: true,
              ),
            ),
            SizedBox(height: h*0.045,),
            Row(
              children: [
                SizedBox(
                  height: h*0.050,
                  width: w*0.40,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                ),
                SizedBox(width: w*0.033),
                SizedBox(
                  height: h*0.050,
                  width: w*0.40,
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
                    child: const Text("Save Changes", style: TextStyle(color: Colors.white),),
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

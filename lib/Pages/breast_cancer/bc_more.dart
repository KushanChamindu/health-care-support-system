import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/Pages/Auth/Service/Auth.dart';
import 'package:healthcaresupportsystem/Pages/Auth/UID.dart';
import 'package:healthcaresupportsystem/Pages/CKD_pages/Constant.dart';

import '../Popupmenu.dart';

class BC_More extends StatefulWidget {
  final BaseAuth auth=Auth();
  @override
  _BC_MoreState createState() => _BC_MoreState();
}

class _BC_MoreState extends State<BC_More> {
  
  @override
  Widget build(BuildContext context) {
    
    List cancer = [
      'Ductal carcinoma symptoms',
      'Lobular carcinoma symptoms',
      'Inflammatory breast cancer symptoms',
      'Metastatic breast cancer symptoms',
      'Papillary carcinoma symptoms',
      'Triple-negative breast cancer symptoms',
      'Male breast cancer symptoms',
    ];
    List description =[
      'Ductal carcinoma in situ (DCIS) does not cause any symptoms. Rarely, a woman may feel a lump in the breast or have nipple discharge. However, most cases of DCIS are detected with a mammogram.',
      'Lobular carcinoma in situ (LCIS) does not cause symptoms and cannot be seen with a mammogram. This condition is usually found when a doctor is doing a breast biopsy for another reason, such as to investigate an unrelated breast lump. If a person has LCIS, the breast cells will appear abnormal under a microscope',
      'Inflammatory breast cancer (IBC) rarely causes breast lumps and may not appear on a mammogram',
      'Metastatic breast cancer symptoms depend on the part of the body to which the cancer has spread and its stage. Sometimes, metastatic disease may not cause any symptoms.',
      'papillary carcinoma may not be present, a routine mammogram may detect its development',
      'Papillary carcinoma may not be present, a routine mammogram may detect its development. For those who do experience symptoms related to this type of cancer',
      'Male breast cancer symptoms can be similar to those experienced by women.',
    ];

    Color color = Theme.of(context).primaryColor;

    Widget containerSection = Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildContainerColumn('BCMoreSample',color, Icons.call, cancer[0], description[0], 'assets/breast_cancer_image/DCIS-1.jpg' ),
          _buildContainerColumn(null,color, Icons.security, cancer[1], description[1],'assets/breast_cancer_image/LCIS-1.webp'),
          _buildContainerColumn(null,color, Icons.share, cancer[2], description[2],'assets/breast_cancer_image/IBCS-1.jpg'),
          _buildContainerColumn(null,color, Icons.share, cancer[3], description[3],'assets/breast_cancer_image/MBCS-1.jpg'),
          _buildContainerColumn(null,color, Icons.share, cancer[4], description[4],'assets/breast_cancer_image/PCS-1.jpg'),
          _buildContainerColumn(null,color, Icons.share, cancer[5], description[5],'assets/breast_cancer_image/TNBS-1.jpg'),
          _buildContainerColumn(null,color, Icons.share, cancer[6], description[6],'assets/breast_cancer_image/MB-2.jpg'),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          key: ValueKey("BCMoreBackButton"),
          icon: Icon(Icons.arrow_back),
          onPressed: ()=>Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          Popupmenu(auth: widget.auth,)
        ],
        title: Align(
          alignment: Alignment.center,
          child: Text(
            "More...  - Breast Cancer",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ),
        //centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          containerSection
        ],
      )
      
      ,
    );
  }

   Column _buildContainerColumn(String id,Color color, IconData icon, String label,String description, String url) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            Align(
              alignment: Alignment.centerLeft,
              child: Titles(
                text1 : label,
                text2 : description
              ),
            ),
            Padding(
              key: ValueKey(id),
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: Image.asset(
              url,
              width: 600,
              height: 150,
              fit: BoxFit.cover,
          ),
            ),
          ],

     
    );
  }
}

class Titles extends StatefulWidget {
  final String text1, text2;
  bool visible = false;

  Titles({this.text1, this.text2});

  @override
  _TitlesState createState() => _TitlesState();
}

class _TitlesState extends State<Titles> {
  void get_visible() {
    setState(() {
      if (widget.visible) {
        widget.visible = false;
      } else {
        widget.visible = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          child: Column(
        children: <Widget>[
          FlatButton.icon(
              onPressed: () {
                get_visible();
              },
              icon: Icon(Icons.list),
              label: Expanded(
                  child: Text(widget.text1, 
                  style: TextStyle(
                    fontSize: 16,
                    ),
                  ),
                ),
                
            ),
          Visibility(
              visible: widget.visible,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 5, 8, 10),
                child: Text(
                  widget.text2,
                  style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                      ),
                ), 
              )
            )
        ],
      )),
    );
  }

}
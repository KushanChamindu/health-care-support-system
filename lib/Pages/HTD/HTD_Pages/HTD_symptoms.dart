import 'package:flutter/material.dart';
import 'package:healthcaresupportsystem/pages/HTD/Style.dart';
import 'package:healthcaresupportsystem/Pages/HTD/AppBar.dart';

class HTD_symptoms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: ValueKey('HTD_symptompage'),
        backgroundColor: Colors.blue[100],
        body: new Stack(
          children: <Widget>[
            new Container(
              margin:
                  new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: new BackButton(color: Colors.black),
            ),
            new Container(
              child: SafeArea(
                  child: GradientAppBar("Heart Disease-symptoms", '/HTD_home')),
            ),
            new Container(
              margin: new EdgeInsets.only(top: 90),
              child: new ListView.builder(
                itemBuilder: (BuildContext context, int index) =>
                    EntryItem(data[index]),
                itemCount: data.length,
              ),
            ),
          ],
        ));
  }
}

class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  //symptom 1

  Entry(
    'Symptoms of heart disease in your blood vessels (atherosclerotic disease)',
    <Entry>[
      Entry(
        'Description: Cardiovascular disease symptoms may be different for men and women. For instance, men are more likely to have chest pain; women are more likely to have other symptoms along with chest discomfort, such as shortness of breath, nausea and extreme fatigue.As the condition worsens, symptoms may include:',
        <Entry>[
          Entry(
              'Chest pain, chest tightness, chest pressure and chest discomfort (angina).'),
          Entry('Shortness of breath.'),
          Entry(
              'Pain, numbness, weakness or coldness in your legs or arms if the blood vessels in those parts of your body are narrowed.'),
          Entry('Pain in the neck, jaw, throat, upper abdomen or back'),
          Entry('Pain in the neck, jaw, throat, upper abdomen or back'),
        ],
      ),
    ],
  ),
  //symptom2
  Entry(
    'Heart disease symptoms caused by abnormal heartbeats (heart arrhythmias)',
    <Entry>[
      Entry(
        'Description: A heart arrhythmia is an abnormal heartbeat. Your heart may beat too quickly, too slowly or irregularly.As the condition worsens, symptoms may include:',
        <Entry>[
          Entry('Fluttering in your chest'),
          Entry('Racing heartbeat (tachycardia)'),
          Entry('Slow heartbeat (bradycardia)'),
          Entry('Chest pain or discomfort'),
          Entry('Shortness of breath'),
          Entry('Lightheadedness'),
          Entry('Dizziness'),
          Entry('Fainting (syncope) or near fainting'),
        ],
      ),
    ],
  ),
  //symptom3
  Entry(
    'Heart disease symptoms caused by weak heart muscle (dilated cardiomyopathy).',
    <Entry>[
      Entry(
        'Description: In early stages of cardiomyopathy, you may have no symptoms.As the condition worsens, symptoms may include:',
        <Entry>[
          Entry('Breathlessness with exertion or at rest'),
          Entry('Swelling of the legs, ankles and feet'),
          Entry('Fatigue'),
          Entry('Irregular heartbeats that feel rapid, pounding or fluttering'),
          Entry('Dizziness, lightheadedness and fainting'),
        ],
      ),
    ],
  ),

  //Symptom4
  Entry(
    'Heart disease symptoms caused by heart infections',
    <Entry>[
      Entry(
        'Description: Endocarditis is an infection that affects the inner membrane that separates the chambers and valves of the heart (endocardium).Symptoms can include:',
        <Entry>[
          Entry('Fever'),
          Entry('Shortness of breath'),
          Entry('Weakness or fatigue'),
          Entry('Swelling in your legs or abdomen'),
          Entry('Changes in your heart rhythm'),
          Entry('Dry or persistent cough'),
          Entry('Skin rashes or unusual spots'),
        ],
      ),
    ],
  ),

  //symptom5
  Entry(
    'Heart disease symptoms caused by valvular heart disease',
    <Entry>[
      Entry(
        'Description: The heart has four valves — the aortic, mitral, pulmonary and tricuspid valves — that open and close to direct blood flow through your heart. Valves may be damaged by a variety of conditions leading to narrowing (stenosis), leaking (regurgitation or insufficiency) or improper closing (prolapse).Symptoms can include:',
        <Entry>[
          Entry('Fatigue'),
          Entry('Shortness of breath'),
          Entry('Irregular heartbeat'),
          Entry('Swollen feet or ankles'),
          Entry('Chest pain'),
          Entry('Fainting (syncope)'),
        ],
      ),
    ],
  ),

  //symptom6
  Entry(
    'Heart disease symptoms caused by heart defects',
    <Entry>[
      Entry(
        'Serious congenital heart defects — defects you are born with — usually become evident soon after birth.Symptoms can include:',
        <Entry>[
          Entry('Pale gray or blue skin color (cyanosis)'),
          Entry('Swelling in the legs, abdomen or areas around the eyes'),
          Entry(
              'In an infant, shortness of breath during feedings, leading to poor weight gain.'),
        ],
      ),
      Entry(
        'Less serious congenital heart defects are often not diagnosed until later in childhood or during adulthood.Symptoms can include:',
        <Entry>[
          Entry('Easily getting short of breath during exercise or activity'),
          Entry('Easily tiring during exercise or activity'),
          Entry('Swelling in the hands, ankles or feet'),
        ],
      ),
    ],
  ),

  Entry(
    'Heart disease symptoms caused by abnormal heartbeats (heart arrhythmias)',
    <Entry>[
      Entry(
        'Description: A heart arrhythmia is an abnormal heartbeat. Your heart may beat too quickly, too slowly or irregularly.Symptoms can include:',
        <Entry>[
          Entry('Fluttering in your chest'),
          Entry('Racing heartbeat (tachycardia)'),
          Entry('Slow heartbeat (bradycardia)'),
          Entry('Chest pain or discomfort'),
          Entry('Shortness of breath'),
          Entry('Lightheadedness'),
          Entry('Dizziness'),
          Entry('Fainting (syncope) or near fainting'),
        ],
      ),
    ],
  ),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty)
      return ListTile(
        title: Text(
          root.title,
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.pink,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(
          Icons.favorite,
          color: Colors.black,
          size: 24.0,
          semanticLabel: 'Text to announce in accessibility modes',
        ),
      );

    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(
        root.title,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Icon(
        Icons.favorite,
        color: Colors.pink,
        size: 24.0,
        semanticLabel: 'Text to announce in accessibility modes',
      ),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}

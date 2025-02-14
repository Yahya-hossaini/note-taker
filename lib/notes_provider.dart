import 'package:flutter/material.dart';
import 'notes.dart';

class NotesProvider with ChangeNotifier {
  List<Notes> _notes = [
    Notes(
      id: '1',
      title: 'Math',
      content:
          'Why end might ask civil again spoil. She dinner she our horses depend. Remember at children by reserved to vicinity. In affronting unreserved delightful simplicity ye. Law own advantage furniture continual sweetness bed agreeable perpetual. Oh song well four only head busy it. Afford son she had lively living. Tastes lovers myself too formal season our valley boy. Lived it their their walls might to by young.',
    ),
    Notes(
      id: '2',
      title: 'English',
      content:
        'Fat new smallness few supposing suspicion two. Course sir people worthy horses add entire suffer. How one dull get busy dare far. At principle perfectly by sweetness do. As mr started arrival subject by believe. Strictly numerous outlived kindness whatever on we no on addition.',
    ),
    Notes(
      id: '3',
      title: 'Geometery',
      content:
        'Surprise steepest recurred landlord mr wandered amounted of. Continuing devonshire but considered its. Rose past oh shew roof is song neat. Do depend better praise do friend garden an wonder to. Intention age nay otherwise but breakfast. Around garden beyond to extent by.',
    ),
    Notes(
      id: '4',
      title: 'Literature',
      content:
        'Sociable on as carriage my position weddings raillery consider. Peculiar trifling absolute and wandered vicinity property yet. The and collecting motionless difficulty son. His hearing staying ten colonel met. Sex drew six easy four dear cold deny. Moderate children at of outweigh it. Unsatiable it considered invitation he travelling insensible.',
    ),
  ];
}

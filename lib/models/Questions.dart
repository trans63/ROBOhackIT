class Question {
  final int id, answer;
  final String question;
  final List<String> options;

  Question({required this.id, required this.question, required this.answer, required this.options});
}

const List sample_data = [
  {
    "id": 1,
    "question":
        "Which organization is credited with creating Bootstrap and contributing it to the open source community?",
    "options": ['Twitter', 'Google', 'Facebook', 'Apache'],
    "answer_index": 0,
  },
  {
    "id": 2,
    "question": "How many grid tiers, over which Bootstrap's layout system can adapt, are available in version 5?",
    "options": ['4', '5', '6', '12'],
    "answer_index": 2,
  },
  {
    "id": 3,
    "question": "Which JavaScript framework was required in Bootstrap version 4, but is no longer required in Bootstrap 5?",
    "options": ['NodeJS', 'Angular', 'jQuery', 'Dojo'],
    "answer_index": 2,
  },
  {
    "id": 4,
    "question": "A collection of properties in Sass is also called:",
    "options": ['Mixin', 'Variable', 'Props', 'Struct'],
    "answer_index": 0,
  },
  {
    "id": 5,
    "question": "Bootstrap icons are implements as:",
    "options": ['PNG files', 'JPG files', 'SVG files', 'TIFF files'],
    "answer_index": 2,
  },

];

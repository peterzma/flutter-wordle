class University {
  final String path;
  final String name;
  final String shortName;

  University({required this.path, required this.name}) 
      : shortName = name.split(' ').last; // Automatically extracts "Adelaide", "UQ", etc.
}

final List<University> universities = [
  University(path: 'assets/images/uq_logo.png', name: 'University of Adelaide'),
  University(path: 'assets/images/uq_logo.png', name: 'Australian National University'),
  University(path: 'assets/images/uq_logo.png', name: 'University of Melbourne'),
  University(path: 'assets/images/uq_logo.png', name: 'Monash University'),
  University(path: 'assets/images/uq_logo.png', name: 'UNSW Sydney'),
  University(path: 'assets/images/uq_logo.png', name: 'University of Queensland'),
  University(path: 'assets/images/uq_logo.png', name: 'University of Sydney'),
  University(path: 'assets/images/uq_logo.png', name: 'Queensland University of Technology'),
  University(path: 'assets/images/uq_logo.png', name: 'University of Tasmania'),
  University(path: 'assets/images/uq_logo.png', name: 'Deakin University'),
];
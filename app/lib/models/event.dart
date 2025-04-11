class Event {
  final String id;
  final String name;
  final String startDate;
  final String endDate;
  final String location;
  final String? description;
  final int maxParticipant;
  final String createdBy;
  final List<String> participants;

  Event({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.location,
    this.description,
    required this.maxParticipant,
    required this.createdBy,
    required this.participants,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'].toString(),
      name: json['name'],
      startDate: json['start_date'],  // Ensure the key name matches the response.
      endDate: json['end_date'],      // Same here.
      location: json['location'],
      description: json['description'] != null ? json['description'] : '', // Handle null case for description.
      maxParticipant: json['max_participant'],
      createdBy: json['created_by']['id'].toString(), // assuming createdBy is an object
      participants: (json['participants'] as List)
          .map((participant) => participant['id'].toString())
          .toList(),
    );
  }

  @override
  String toString() {
    return 'Event(id: $id, name: "$name", startDate: $startDate, endDate: $endDate, location: "$location", maxParticipant: $maxParticipant, createdBy: $createdBy, participants: $participants)';
  }
}
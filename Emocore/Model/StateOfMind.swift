import AppIntents
import HealthKit

struct StateOfMind: AppEntity {
    static var defaultQuery = StateOfMindQuery()

    init() {
        id = UUID()
    }

    var id: UUID

    @Property()
    var date: Date

    @Property()
    var kind: Kind

    @Property()
    var valence: Double

    @Property()
    var valenceClassification: ValenceClassification

    @Property()
    var labels: [Label]

    @Property()
    var associations: [Association]

    var healthKitStateOfMind: HKStateOfMind?

    var kindDescription: String {
        switch kind {
        case .momentaryEmotion: "Moment"
        case .dailyMood: "Day"
        @unknown default:
            fatalError("Unknown kind: \(kind)")
        }
    }

    var valenceClassificationDescription: String {
        switch valenceClassification {
        case .neutral: "Neutral"
        case .pleasant: "Pleasant"
        case .slightlyPleasant: "Slightly Pleasant"
        case .slightlyUnpleasant: "Slightly Unpleasant"
        case .unpleasant: "Unpleasant"
        case .veryPleasant: "Very Pleasant"
        case .veryUnpleasant: "Very Unpleasant"
        @unknown default:
            fatalError("Unknown valence classification: \(valenceClassification)")
        }
    }

    var name: String {
        "A \(valenceClassificationDescription) \(kindDescription)"
    }

    static var typeDisplayRepresentation = TypeDisplayRepresentation(
        name: "State of Mind Samples",
        numericFormat: "\(placeholder: .int) State of Mind samples",
        synonyms: ["Mood", "Emotion"]
    )

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(name)",
                              subtitle: "\(date.formatted(date: .numeric, time: .shortened))",
                              image: DisplayRepresentation.Image(systemName: "brain.head.profile"))
    }

    enum Kind: Int, AppEnum {
        case momentaryEmotion = 1
        case dailyMood = 2

        public static var typeDisplayRepresentation: TypeDisplayRepresentation = .init(name: "Kind")

        public static var caseDisplayRepresentations: [Self: DisplayRepresentation] = [
            .momentaryEmotion: .init(
                title: "Emotion",
                subtitle: "How you feel right now",
                image: .init(systemName: "clock")
            ),
            .dailyMood: .init(
                title: "Mood",
                subtitle: "How you've felt overall today",
                image: .init(systemName: "sun.horizon.fill")
            ),
        ]

        init?(from: HKStateOfMind.Kind) {
            self.init(rawValue: from.rawValue)
        }

        var toHKStateOfMindKind: HKStateOfMind.Kind? {
            HKStateOfMind.Kind(rawValue: rawValue)
        }
    }

    enum Label: Int, AppEnum {
        case amazed = 1
        case amused = 2
        case angry = 3
        case annoyed = 32
        case anxious = 4
        case ashamed = 5
        case brave = 6
        case calm = 7
        case confident = 33
        case content = 8
        case disappointed = 9
        case discouraged = 10
        case disgusted = 11
        case drained = 34
        case embarrassed = 12
        case excited = 13
        case frustrated = 14
        case grateful = 15
        case guilty = 16
        case happy = 17
        case hopeful = 35
        case hopeless = 18
        case indifferent = 36
        case irritated = 19
        case jealous = 20
        case joyful = 21
        case lonely = 22
        case overwhelmed = 37
        case passionate = 23
        case peaceful = 24
        case proud = 25
        case relieved = 26
        case sad = 27
        case satisfied = 38
        case scared = 28
        case stressed = 29
        case surprised = 30
        case worried = 31

        public static var typeDisplayRepresentation: TypeDisplayRepresentation = .init(name: "Label")

        public static var caseDisplayRepresentations: [Self: DisplayRepresentation] = [
            .amazed: "Amazed",
            .amused: "Amused",
            .angry: "Angry",
            .annoyed: "Annoyed",
            .anxious: "Anxious",
            .ashamed: "Ashamed",
            .brave: "Brave",
            .calm: "Calm",
            .confident: "Confident",
            .content: "Content",
            .disappointed: "Disappointed",
            .discouraged: "Discouraged",
            .disgusted: "Disgusted",
            .drained: "Drained",
            .embarrassed: "Embarrassed",
            .excited: "Excited",
            .frustrated: "Frustrated",
            .grateful: "Grateful",
            .guilty: "Guilty",
            .happy: "Happy",
            .hopeful: "Hopeful",
            .hopeless: "Hopeless",
            .indifferent: "Indifferent",
            .irritated: "Irritated",
            .jealous: "Jealous",
            .joyful: "Joyful",
            .lonely: "Lonely",
            .overwhelmed: "Overwhelmed",
            .passionate: "Passionate",
            .peaceful: "Peaceful",
            .proud: "Proud",
            .relieved: "Relieved",
            .sad: "Sad",
            .satisfied: "Satisfied",
            .scared: "Scared",
            .stressed: "Stressed",
            .surprised: "Surprised",
            .worried: "Worried",
        ]

        init?(from: HKStateOfMind.Label) {
            self.init(rawValue: from.rawValue)
        }

        var toHKStateOfMindLabel: HKStateOfMind.Label? {
            HKStateOfMind.Label(rawValue: rawValue)
        }
    }

    enum Association: Int, AppEnum {
        case community = 1
        case currentEvents = 2
        case dating = 3
        case education = 4
        case family = 5
        case fitness = 6
        case friends = 7
        case health = 8
        case hobbies = 9
        case identity = 10
        case money = 11
        case partner = 12
        case selfCare = 13
        case spirituality = 14
        case tasks = 15
        case travel = 16
        case work = 17
        case weather = 18

        public static var typeDisplayRepresentation: TypeDisplayRepresentation = .init(name: "Association")

        public static var caseDisplayRepresentations: [Self: DisplayRepresentation] = [
            .community: "Community",
            .currentEvents: "Current Events",
            .dating: "Dating",
            .education: "Education",
            .family: "Family",
            .fitness: "Fitness",
            .friends: "Friends",
            .health: "Health",
            .hobbies: "Hobbies",
            .identity: "Identity",
            .money: "Money",
            .partner: "Partner",
            .selfCare: "Self-Care",
            .spirituality: "Spirituality",
            .tasks: "Tasks",
            .travel: "Travel",
            .work: "Work",
            .weather: "Weather",
        ]

        init?(from: HKStateOfMind.Association) {
            self.init(rawValue: from.rawValue)
        }

        var toHKStateOfMindAssociation: HKStateOfMind.Association? {
            HKStateOfMind.Association(rawValue: rawValue)
        }
    }

    enum ValenceClassification: Int, AppEnum {
        case veryUnpleasant = 1
        case unpleasant = 2
        case slightlyUnpleasant = 3
        case neutral = 4
        case slightlyPleasant = 5
        case pleasant = 6
        case veryPleasant = 7

        public static var typeDisplayRepresentation: TypeDisplayRepresentation = .init(name: "Valence Classification")

        public static var caseDisplayRepresentations: [Self: DisplayRepresentation] = [
            .veryUnpleasant: "Very Unpleasant",
            .unpleasant: "Unpleasant",
            .slightlyUnpleasant: "Slightly Unpleasant",
            .neutral: "Neutral",
            .slightlyPleasant: "Slightly Pleasant",
            .pleasant: "Pleasant",
            .veryPleasant: "Very Pleasant",
        ]

        // Bounds were determined through trial and error, before realising they're at sevenths
        // The lower bound is inclusive, while the upper bound is strict (even when doing negatives)
        var bounds: (lower: Double, upper: Double) {
            switch self {
            case .veryUnpleasant: (lower: -7 / 7, upper: -5 / 7)
            case .unpleasant: (lower: -5 / 7, upper: -3 / 7)
            case .slightlyUnpleasant: (lower: -3 / 7, upper: -1 / 7)
            case .neutral: (lower: -1 / 7, upper: 1 / 7)
            case .slightlyPleasant: (lower: 1 / 7, upper: 3 / 7)
            case .pleasant: (lower: 3 / 7, upper: 5 / 7)
            case .veryPleasant: (lower: 5 / 7, upper: 7 / 7)
            }
        }

        init?(from: HKStateOfMind.ValenceClassification) {
            self.init(rawValue: from.rawValue)
        }

        var toHKStateOfMindValenceClassification: HKStateOfMind.ValenceClassification? {
            HKStateOfMind.ValenceClassification(rawValue: rawValue)
        }
    }
}

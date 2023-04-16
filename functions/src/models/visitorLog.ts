export class VisitorLog {
    visitorLogId = ``
    visitorName = ``
    description = ``
    imageUrl = ``
    createdAt?: FirebaseFirestore.Timestamp

    constructor(partial?: Partial<VisitorLog>) {
        Object.assign(this, partial)
    }
}

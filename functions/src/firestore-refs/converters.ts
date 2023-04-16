import { FieldValue, FirestoreDataConverter } from '@google-cloud/firestore'
import { VisitorLog } from '../models/visitorLog'

export const visitorLogConverter: FirestoreDataConverter<VisitorLog> = {
    fromFirestore(qds: FirebaseFirestore.QueryDocumentSnapshot): VisitorLog {
        const data = qds.data()
        return {
            visitorLogId: qds.id,
            visitorName: data.visitorName,
            description: data.description,
            imageUrl: data.imageUrl,
            createdAt: data.createdAt
        }
    },
    toFirestore(visitorLog: VisitorLog): FirebaseFirestore.DocumentData {
        return {
            visitorLogId: visitorLog.visitorLogId,
            visitorName: visitorLog.visitorName,
            description: visitorLog.description,
            imageUrl: visitorLog.imageUrl,
            createdAt: FieldValue.serverTimestamp()
        }
    }
}

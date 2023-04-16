import { CollectionReference, DocumentReference } from '@google-cloud/firestore'
import * as admin from 'firebase-admin'
import { VisitorLog } from '../models/visitorLog'
import { visitorLogConverter } from './converters'

/** undefined なプロパティを無視するよう設定した db オブジェクト。 */
const db = admin.firestore()
db.settings({ ignoreUndefinedProperties: true })

/** visitorLogs コレクションの参照 */
export const visitorLogsRef: CollectionReference<VisitorLog> = db
    .collection(`visitorLogs`)
    .withConverter<VisitorLog>(visitorLogConverter)

/** visitorLog ドキュメントの参照 */
export const visitorLogRef = ({
    visitorLogId
}: {
    visitorLogId: string
}): DocumentReference<VisitorLog> => visitorLogsRef.doc(visitorLogId)

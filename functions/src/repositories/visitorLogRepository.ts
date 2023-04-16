import { visitorLogRef } from '../firestore-refs/firestoreRefs'
import { VisitorLog } from '../models/visitorLog'

/** VisitorLog のリポジトリクラス */
export class VisitorLogRepository {
    /** 指定した VisitorLog を取得する。 */
    async fetchVisitorLog({
        visitorLogId
    }: {
        visitorLogId: string
    }): Promise<VisitorLog | undefined> {
        const ds = await visitorLogRef({ visitorLogId: visitorLogId }).get()
        return ds.data()
    }
}

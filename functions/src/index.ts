import * as admin from 'firebase-admin'
import * as serviceAccountKey from '../keys/service_account_key.json'

// サービスアカウントを環境変数から取得
const serviceAccount = {
    type: serviceAccountKey.type,
    projectId: serviceAccountKey.project_id,
    privateKeyId: serviceAccountKey.private_key_id,
    privateKey: serviceAccountKey.private_key.replace(/\\n/g, `\n`),
    clientEmail: serviceAccountKey.client_email,
    clientId: serviceAccountKey.client_id,
    authUri: serviceAccountKey.auth_uri,
    tokenUri: serviceAccountKey.token_uri,
    authProviderX509CertUrl: serviceAccountKey.auth_provider_x509_cert_url,
    clientC509CertUrl: serviceAccountKey.client_x509_cert_url
}

// Firebase Admin SDK の初期化
// https://firebase.google.com/docs/functions/config-env?hl=ja
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: `https://${serviceAccount.projectId}.firebaseio.com`
})

/**
 * ここでデプロイする関数をまとめる。
 * admin.initializeApp() の順序の問題でデプロイに失敗するため。
 *  */
import { generateDynamicMetaTags } from './https-functions/generateDynamicMetaTags'

/** index.ts で import してデプロイする関数一覧  */
export { generateDynamicMetaTags }

import * as functions from 'firebase-functions'

/**
 * besso-log-book の Flutter Web ページ（訪問記録詳細）のクエリパラメータにもとづい
 * 動的なメタタグを生成する。
 * */
export const generateDynamicMetaTags = functions
    .region(`asia-northeast1`)
    .https.onRequest(async (request, response) => {
        console.log(request, response)
    })

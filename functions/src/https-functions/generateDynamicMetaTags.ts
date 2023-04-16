import * as functions from 'firebase-functions'
import { VisitorLogRepository } from '../repositories/visitorLogRepository'

const siteTitle = `Flutter別荘 思い出ボード`

const defaultSiteDescription = `Flutter別荘を訪問しました！`

const baseUrl = `https://besso-log-book.web.app/#`

const defaultImageUrl = `https://firebasestorage.googleapis.com/v0/b/besso-log-book.appspot.com/o/2023-04-15%3A19%3A32%3A19_449315042.jpg?alt=media&token=8c5fea89-e0cc-4183-a8d2-bcf98879f36c`

/**
 * besso-log-book の Flutter Web ページ（訪問記録詳細）のクエリパラメータにもとづいて
 * 動的なメタタグを生成する。
 * */
export const generateDynamicMetaTags = functions
    .region(`asia-northeast1`)
    .https.onRequest(async (request, response) => {
        const visitorLogId = request.query.visitorLogId
        if (typeof visitorLogId !== `string`) {
            const html = generateHtml({
                title: siteTitle,
                content: defaultSiteDescription,
                imageUrl: defaultImageUrl
            })
            response.status(200).send(html)
            return
        }
        const visitorLogRepository = new VisitorLogRepository()
        const visitorLog = await visitorLogRepository.fetchVisitorLog({
            visitorLogId
        })
        if (visitorLog === undefined) {
            const html = generateHtml({
                title: siteTitle,
                content: defaultSiteDescription,
                imageUrl: defaultImageUrl
            })
            response.status(200).send(html)
            return
        }
        const html = generateHtml({
            visitorLogId: visitorLogId,
            title: siteTitle,
            content: `${visitorLog.visitorName}さんがFlutter別荘を訪問しました！「${visitorLog.description}」`,
            imageUrl: visitorLog.imageUrl
        })
        response.status(200).send(html)
    })

/** 動的な HTML を生成する。 */
const generateHtml = ({
    visitorLogId,
    title,
    content,
    imageUrl
}: {
    visitorLogId?: string
    title: string
    content: string
    imageUrl: string
}) => {
    const pageUrl = getPageUrl({ visitorLogId })
    return `
<!DOCTYPE html>
<html>
    <head>
        <meta name="description" content="${content}" />
        <meta property="og:url" content="${pageUrl}" />
        <meta property="og:site_name" content="${title}" />
        <meta property="og:title" content="${title}" />
        <meta property="og:description" content="${content}" />
        <meta property="og:type" content={'website'} />
        <meta property="og:locale" content={'ja_JP'} />
        <meta property="og:url" content="${pageUrl}" />
        <meta property="og:image" content="${imageUrl}" />
        <meta property="twitter:title" content="${title}" />
        <meta property="twitter:description" content="${content}" />
        <meta property="twitter:image" content="${imageUrl}" />
        <link rel="icon" href="/favicon.ico" />
    </head>
    <body>
        <script>
            window.location.href = '${pageUrl}';
        </script>
    </body>
</html>
`
}

const getPageUrl = ({ visitorLogId }: { visitorLogId?: string }) => {
    if (visitorLogId) {
        return `${baseUrl}/visitorLogs?visitorLogId=${visitorLogId}`
    }
    return `${baseUrl}/visitorLogs`
}

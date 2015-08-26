#include "appupdater.h"

AppUpdater::AppUpdater(QObject *parent) : QObject(parent)
{
    manager = new QNetworkAccessManager;
}


void AppUpdater::getLatestVersionNumber()
{
    QNetworkRequest req;
    req.setUrl(QUrl("https://api.github.com/repos/taaem/ohmoor-app/releases/latest"));

    connect(manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(replyFinished(QNetworkReply*)));

    manager->get(req);
}

void AppUpdater::replyFinished(QNetworkReply *reply)
{
    QString rep = (QString)reply->readAll();
    QJsonDocument doc = QJsonDocument::fromJson(rep.toUtf8());

    QJsonObject rootObj = doc.object();
    QVariantMap rootMap = rootObj.toVariantMap();

    // The Download URL for the latest Release
    QVariantList assets = rootMap["assets"].toList();
    QVariantMap assetsMap = assets[0].toMap();
    QVariant downloadUrl = assetsMap["browser_download_url"].toString();

    //The Version Number of the latest Release
    QVariant versionNumber = rootMap["tag_name"].toString();

    //The name of the release
    QVariant releaseName = rootMap["name"].toString();

    //The Changelog of the Release
    QVariant changelog = rootMap["body"].toString();

    //getting it all together
    QVariantList allData;
    allData.append(downloadUrl);
    allData.append(versionNumber);
    allData.append(releaseName);
    allData.append(changelog);

    Q_EMIT gotLatestVersionNumber(allData);
}

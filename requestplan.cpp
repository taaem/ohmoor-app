#include "requestplan.h"

RequestPlan::RequestPlan(QObject *parent) : QObject(parent)
{
    apiKey = new QByteArray("a173007dff88f52a8f1837e275930abf");
    manager = new QNetworkAccessManager();
}

void RequestPlan::getAllDates()
{
    QNetworkRequest req;
    req.setUrl(QUrl("https://iserv-taaem.rhcloud.com/dates"));
    req.setRawHeader(QByteArray("X-APIKey"), *apiKey);
    connect(manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(parseDates(QNetworkReply*)));
    manager->get(req);
    emit loadingDates();
}

void RequestPlan::getPlan(QString name)
{
    QNetworkRequest req;
    QUrl url = "https://iserv-taaem.rhcloud.com/plan/" + name;
    req.setUrl(url);
    req.setRawHeader(QByteArray("X-APIKey"), *apiKey);
    connect(manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(parsePlan(QNetworkReply*)));
    manager->get(req);
    emit loadingPlan();
}

void RequestPlan::verifyUser(QString uName, QString uPwd)
{
    QNetworkAccessManager *vManager = new QNetworkAccessManager;
    QNetworkRequest req;
    req.setUrl(QUrl("https://ohmoor.de/idesk/"));
    req.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded");
    QByteArray postData;
    postData.append("login_act=" + uName + "&");
    postData.append("login_pwd=" + uPwd + "");

    connect(vManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(authFinished(QNetworkReply*)));
    vManager->post(req, postData);
}

void RequestPlan::parseDates(QNetworkReply *reply)
{
    QString strReply= (QString)reply->readAll();
    QJsonDocument doc = QJsonDocument::fromJson(strReply.toUtf8());
    QJsonArray allDates = doc.array();
    foreach (QJsonValue date, allDates) {
        QJsonObject dateObj = date.toObject();
        QVariantMap dateMap = dateObj.toVariantMap();
        emit datesReceived(dateMap);
    }
    reply->deleteLater();
}

void RequestPlan::parsePlan(QNetworkReply *reply)
{
    QString strReply= (QString)reply->readAll();
    QJsonDocument doc = QJsonDocument::fromJson(strReply.toUtf8());
    QJsonObject docObj = doc.object();
    emit gotPlanDate(docObj["date"].toString());
    QJsonArray allItems = docObj["items"].toArray();
    foreach (QJsonValue item, allItems) {
        QVariantMap itemList = item.toObject().toVariantMap();
        emit planReceived(itemList);
    }
    reply->deleteLater();
}

void RequestPlan::authFinished(QNetworkReply *reply)
{
    QVariant statusCode = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);
    if(statusCode == 302)
    {
        emit userIsVerified();
    }
    else
    {
        emit verifiedFailed();
    }
    reply->deleteLater();
}


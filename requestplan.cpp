#include "requestplan.h"

RequestPlan::RequestPlan(QObject *parent) : QObject(parent)
{
    apiKey = new QByteArray(aKey);
    manager = new QNetworkAccessManager();
}

void RequestPlan::getAllDates()
{
    QNetworkRequest req;
    req.setUrl(QUrl("https://mar-eu-1-1lcyazw4.qtcloudapp.com/dates"));
    //req.setUrl(QUrl("https://iserv-taaem.rhcloud.com/dates"));
    req.setRawHeader(QByteArray("X-APIKey"), *apiKey);
    connect(manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(parseDates(QNetworkReply*)));
    manager->get(req);
    emit loadingDates();
}

void RequestPlan::getPlan(QString name)
{
    QNetworkAccessManager *aManager = new QNetworkAccessManager;
    QNetworkRequest req;
    QUrl url = "https://mar-eu-1-1lcyazw4.qtcloudapp.com/plan/" + name;
    req.setUrl(url);
    req.setRawHeader(QByteArray("X-APIKey"), *apiKey);
    connect(aManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(parsePlan(QNetworkReply*)));
    aManager->get(req);
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
    QNetworkReply *reply = vManager->post(req, postData);
    reply->ignoreSslErrors();
}

void RequestPlan::parseDates(QNetworkReply *reply)
{
    QString strReply= (QString)reply->readAll();
    if(strReply == "[]"){

        emit noPlansAvailable();

    }else{
        QJsonDocument doc = QJsonDocument::fromJson(strReply.toUtf8());
        QJsonArray allDates = doc.array();

        foreach (QJsonValue date, allDates) {
            QJsonObject dateObj = date.toObject();
            QVariantMap dateMap = dateObj.toVariantMap();
            emit datesReceived(dateMap);
        }
    }
    reply->deleteLater();
}

void RequestPlan::parsePlan(QNetworkReply *reply)
{
    QString strReply= (QString)reply->readAll();
    QJsonDocument doc = QJsonDocument::fromJson(strReply.toUtf8());
    QJsonObject docObj = doc.object();
    emit gotPlanDate(docObj["date"].toString());
    emit gotMsg(docObj["msg"].toArray().toVariantList());
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


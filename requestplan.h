#ifndef REQUESTPLAN_H
#define REQUESTPLAN_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonValue>

class RequestPlan : public QObject
{
    Q_OBJECT
public:
    explicit RequestPlan(QObject *parent = 0);
    Q_INVOKABLE void getAllDates();
    Q_INVOKABLE void getPlan(QString name);
    Q_INVOKABLE void verifyUser(QString uName, QString uPwd);


signals:
    void datesReceived(QVariantMap date);
    void planReceived(QVariantMap item);
    void loadingDates();
    void loadingPlan();
    void userIsVerified();
    void verifiedFailed();
    void gotPlanDate(QVariant date);

public slots:
    void parseDates(QNetworkReply *reply);
    void parsePlan(QNetworkReply *reply);
    void authFinished(QNetworkReply *reply);

private:
    QNetworkAccessManager *manager;
    QByteArray *apiKey;

};

#endif // REQUESTPLAN_H

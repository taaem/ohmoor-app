#ifndef APPUPDATER_H
#define APPUPDATER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>

class AppUpdater : public QObject
{
    Q_OBJECT
public:
    explicit AppUpdater(QObject *parent = 0);
    Q_INVOKABLE void getLatestVersionNumber();

signals:
    void gotLatestVersionNumber(QVariantList allData);

public slots:
    void replyFinished(QNetworkReply*);

private:
    QNetworkAccessManager *manager;
};

#endif // APPUPDATER_H

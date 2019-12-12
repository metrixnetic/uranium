#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

private slots:
    void on_go_clicked();

    void on_urlEdit_returnPressed();

    void on_webView_loadFinished(bool arg1);

private:
    Ui::MainWindow *ui;
};

#endif // MAINWINDOW_H

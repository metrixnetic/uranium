#include "mainwindow.h"
#include "ui_simpleUranium.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_go_clicked()
{
    ui->webView->load(ui->urlEdit->text());
}

void MainWindow::on_urlEdit_returnPressed()
{
    on_go_clicked();
}

void MainWindow::on_webView_loadFinished(bool arg1)
{
    if(arg1)
    {
        ui->urlEdit->setText(ui->webView->url().toString());
    }
}

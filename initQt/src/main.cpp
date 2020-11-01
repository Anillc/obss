#include <QApplication>

extern "C"{

void initQt(){
    int argc = 0;
    char** argv = NULL;
    QApplication a(argc, argv);
}

}

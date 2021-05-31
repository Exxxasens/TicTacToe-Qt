#ifndef GAME_H
#define GAME_H


#include <QAbstractListModel>
#include <vector>

class Game : public QAbstractListModel {
    Q_OBJECT
    Q_PROPERTY(int fieldSize READ getSize CONSTANT);

public:
    static constexpr size_t defaultFieldSize{3};
    Game(size_t size = defaultFieldSize, QObject * parent = nullptr);

    struct Cell {
        int x;
        int y;
        int type;
    };

    int rowCount(const QModelIndex & parent = QModelIndex {}) const override;
    QVariant data(const QModelIndex& index, int role = Qt::DisplayRole) const override;
    bool isSafe(int y, int x) const;
    int getSize();

    Q_INVOKABLE bool click(int y, int x);
    Q_INVOKABLE void setField(QVariantList const& arg);


private:
    std::vector<std::vector<Cell>> field;
    size_t size;
    bool flag;
    int nextPlayer = 1;
};

#endif // GAME_H

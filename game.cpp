#include "game.h"
#include <QAbstractListModel>
#include <QDebug>
#include <vector>

Game::Game(const size_t _size, QObject * parent) : QAbstractListModel {parent}, size { _size }
{
    for (unsigned int i = 0; i < size; i++)
    {
        std::vector<Cell> row;
        for (unsigned int j = 0; j < size; j++)
        {
            Cell cell;
            cell.y = i;
            cell.x = j;
            cell.type = 0;
            row.push_back(cell);
        }
        field.push_back(row);
    }

}


int Game::rowCount(const QModelIndex &/*parent*/) const
{
    return static_cast<int>(size*size);
}

bool Game::isSafe(int y, int x) const {
    if (y < 0 || x < 0) return false;
    if (y > size-1 || x > size-1) return false;
    return true;
}

QVariant Game::data(const QModelIndex &index, int role) const {
    if (!index.isValid() || role != Qt::DisplayRole) {
        qDebug() << "Not valid" << endl;
        return {};
    }

    const int rowIndex = index.row();

    int i = rowIndex / size;
    int j = rowIndex % size;

    if (!isSafe(i, j)) {
        return {};
    }

    if (field[i][j].type == 0) {
        return QVariant(QString(""));
    }

    if (field[i][j].type == 1) {
        return QVariant(QString("X"));
    }

    if (field[i][j].type == 2) {
        return QVariant(QString("O"));
    }
    return {};
}

int Game::getSize() {
    return size;
}

void Game::setField(const QVariantList &arg) {
    std::vector<std::vector<Cell>> updated_field;
    if (arg.size()) {
        size = arg.size();
        field.clear();
        for (unsigned int i = 0; i < size; i++)
        {
            std::vector<Cell> row;
            auto const p(arg[i].toList());
            for (unsigned int j = 0; j < size; j++)
            {
                Cell cell;
                cell.y = i;
                cell.x = j;
                cell.type = p[j].toInt();

                row.push_back(cell);
            }
            field.push_back(row);
        }

    emit dataChanged(createIndex(0, 0), createIndex(size * size, 0));
    emit layoutChanged();

    } else {
        qDebug() << "\nqqqq " << arg.size () << "\n";
    }
}

bool Game::click(int y, int x)
{
    qDebug() << "Click invoked!" << endl;
    if (isSafe(y, x)) {



    }
}


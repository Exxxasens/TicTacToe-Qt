import QtQuick 2.0
import Game 1.0

GridView {
    id: root
    model: GameField  {
        id: game_field_model
    }

    function handleClick(index) {
        if (currentGame['status'] !== 'started') return null;

        var y = Math.floor(index / root.model.fieldSize);
        var x = index % root.model.fieldSize;
''
        if ((currentGame['first_player'] === username && currentGame['next_step'] == 1) || (currentGame['second_player'] === username && currentGame['next_step'] == 2)) {

            currentGame['field'][y][x] = currentGame['next_step'];

            print('ok')

            if (currentGame['next_step'] === 1) {
                currentGame['next_step'] = 2
            } else {
                currentGame['next_step'] = 1;
            }

            updateField(currentGame['field']);

            fetchPost(baseURL + '/api/game/' + currentGameId + '/step', { y: y, x: x }, function() {

                console.log('ok')

            }, true);

        }

    }

    cellHeight: Math.min(Math.min(height, width) / root.model.fieldSize)
    cellWidth: Math.min(Math.min(height, width) / root.model.fieldSize)

    delegate: Cell {
        height: root.cellHeight
        width: root.cellWidth
        displayValue: display
    }
}

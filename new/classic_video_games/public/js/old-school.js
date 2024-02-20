function loadGameModalFromElem(elem) {
    const gameName = elem.getAttribute('data-game-name');
    document.querySelector('#gameModalLabel').innerHTML = gameName;
    document.querySelector('#gameModal #gameName').innerHTML = gameName;
    const gameID = elem.getAttribute('data-id');
    document.querySelector('#gameModal #gameID').setAttribute('data-id', gameID);
    document.querySelector('#gameModal #gamePublicationYear').innerHTML = elem.getAttribute('data-game-publication-year');
    document.querySelector('#gameModal #gameNotes').innerHTML = elem.getAttribute('data-game-notes');
    document.querySelector('#gameModal #gamePublishers').innerHTML = elem.getAttribute('data-game-publishers');
    document.querySelector('#gameModal #gameIsActive').innerHTML = elem.getAttribute('data-game-is-active');
    document.querySelector('#gameModal #gameLikes').innerHTML = elem.getAttribute('data-game-likes-count');

    const imageName = elem.getAttribute('data-game-image-name');
    document.querySelector('#gameModal #gameModalImage').innerHTML = '';
    if (imageName) {
        document.querySelector('#gameModal #gameModalImage').innerHTML = `<img alt="${gameName}" src="${imageName}">`;
    } else {
        // Be sure to clear if no game image; otherwise, previous game images will remain.
        document.querySelector('#gameModal #gameModalImage').innerHTML = '';
    }
}

document.querySelector('#likeButton').addEventListener('click', (event) => {
    const remoteIP = document.querySelector('#remoteIP').getAttribute('data-ip');
    console.log(`remoteip='${remoteIP}'`);
    const gameID = document.querySelector('#gameModal #gameID').getAttribute('data-id');
    const url = `/games/${gameID}/like`;
    let elem = null;
    document.querySelectorAll('.game-modal-trigger').forEach((e) => {
        if (e.getAttribute('data-id') == gameID) {
            elem = e;
            return;
        }
    });
    fetch(url, {
        'method': 'POST',
        'headers': {'Content-Type': 'application/json'},
        'body': JSON.stringify({'remote-ip': remoteIP}),
    }).then((response) => {
        if (!elem) {
            return;
        }
        if (response.status != 200 && response.status != 201) {
            return;
        }
        const likes = parseInt(elem.getAttribute('data-game-likes-count'));
        console.log(`old likes: ${likes}`);
        elem.setAttribute('data-game-likes-count', likes+1);
        loadGameModalFromElem(elem);
    });
});

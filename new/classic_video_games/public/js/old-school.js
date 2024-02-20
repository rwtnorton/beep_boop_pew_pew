function formatManufacturer(m) {
    let s = m['company'];
    if (m['region']) {
        s += ` (${m['region']})`;
    }
    return s;
}

function formatPublishers(game) {
    let manufacturers = game['manufacturers'] || [];
    let pubs = [];
    manufacturers.forEach(function(m) {
        pubs.push(formatManufacturer(m));
    });
    return pubs.join(' / ');
}

function populateModal(game) {
    document.querySelector('#gameModalLabel').innerHTML = game['name'];
    document.querySelector('#gameModal #gameID').setAttribute('data-id', game['id']);
    document.querySelector('#gameModal #gameName').innerHTML = game['name'];
    document.querySelector('#gameModal #gamePublicationYear').innerHTML = game['publication_year'];
    document.querySelector('#gameModal #gameNotes').innerHTML = game['notes'];
    document.querySelector('#gameModal #gamePublishers').innerHTML = formatPublishers(game);
    document.querySelector('#gameModal #gameIsActive').innerHTML = game['is_active'];
    document.querySelector('#gameModal #gameLikes').innerHTML = game['likes_count'];
}

function populateImage(data) {
    document.querySelector('#gameModal #gameModalImage').innerHTML = data['image_tag'];
}

function loadModalForGameID(gameID) {
    console.log(`called loadModalForGameID: gameid=${gameID}`);
    const getGameURL = `/games/${gameID}`;
    console.log(`url = ${getGameURL}`);
    fetch(getGameURL, {'method': 'GET', 'headers': {}})
        .then((response) => response.json())
        .then(game => {
            console.log(game);
            populateModal(game);
        });
}

function registerModalOnClicks() {
    document.querySelectorAll('.game-modal-trigger').forEach(function(e) {
        console.log(`trigger: ${e.innerHTML}`);
        e.addEventListener('click', (_event) => {
            let gameID = e.getAttribute('data-id');
            console.log(`gameid = ${gameID}`);
            loadModalForGameID(gameID);
        });
    });
}
// registerModalOnClicks();

document.addEventListener('DOMContentLoaded', (_event) => {
    console.log("reregistering");
    registerModalOnClicks();
});

const sleepNow = (delay) => new Promise((resolve) => setTimeout(resolve, delay));

document.querySelector('.atari_pagination .pagination').addEventListener('click', async (_event) => {
    await sleepNow(1000);
    console.log("awake");
    // while (document.readyState != 'complete') {
    //     console.log('not ready');
    // }
    console.log("reregistering");
    registerModalOnClicks();
});

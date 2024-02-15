import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

(function () {

function formatManufacturer(m) {
  let s = m['company'];
  if (m['region']) {
    s += ' (' + m['region'] + ')';
  }
  return s;
}

function formatPublishers(game) {
  let pubs = [];
  for (let manu of game['manufacturers']) {
    pubs.push(formatManufacturer(manu));
  }
  return pubs.join(' / ');
}

function populateModal(game) {
  $('#gameModalLabel').text(game['name']);
  $('#gameModal #gameID').attr('data-id', game['id']);
  $('#gameModal #gameName').text(game['name']);
  $('#gameModal #gamePublicationYear').text(game['publication_year']);
  $('#gameModal #gameNotes').text(game['notes']);
  $('#gameModal #gamePublishers').text(formatPublishers(game));
  $('#gameModal #gameIsActive').text(game['is_active']);
  $('#gameModal #gameLikes').text(game['likes_count']);
}

function populateImage(data) {
  $('#gameModal #gameModalImage').html(data['image_tag']);
}

function loadModalForGameID(game_id) {
  const url = "/games/" + game_id;
  let params = {
    "url": url,
    "success": populateModal
  };
  $.ajax(params);
  const image_url = url + "/image";
  let params2 = {
    "url": image_url,
    "success": populateImage
  };
  $.ajax(params2);
}

$("#gameModal").on(
  "show.bs.modal",
  function(e) {
    const game_id = $(e.relatedTarget).attr("data-id");
    loadModalForGameID(game_id);
  }
);

$("#likeButton").click(
  function() {
    const remote_ip = $("#remoteIP").attr("data-ip");
    const game_id = $("#gameModal #gameID").attr("data-id");
    let params = {
      "url": url,
      "method": "POST",
      "data": {"remote_ip": remote_ip}
    };
    $.ajax(params).done(function(_x) {
      loadModalForGameID(game_id);
    });
  }
);

})();

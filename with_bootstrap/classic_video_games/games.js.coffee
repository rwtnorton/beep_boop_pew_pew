# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
        formatManufacturer = (m)->
                s = m['company']
                if m['region']
                        s += ' (' + m['region'] + ')'
                s

        formatPublishers = (game)->
                pubs = (formatManufacturer(e) for e in game['manufacturers'])
                pubs.join(' / ')

        populateModal = (game)->
                $('#gameModalLabel').text(game['name'])
                $('#gameModal #gameID').attr('data-id', game['id'])
                $('#gameModal #gameName').text(game['name'])
                $('#gameModal #gamePublicationYear').text(game['publication_year'])
                $('#gameModal #gameNotes').text(game['notes'])
                $('#gameModal #gamePublishers').text(formatPublishers(game))
                $('#gameModal #gameIsActive').text(game['is_active'])
                $('#gameModal #gameLikes').text(game['likes_count'])

        populateImage = (data)->
                $('#gameModal #gameModalImage').html(data['image_tag'])

        loadModalForGameID = (game_id)->
                url = '/games/' + game_id
                params =
                        url:     url
                        success: populateModal
                $.ajax(params)
                image_url = url + '/image'
                params =
                        url:     image_url
                        success: populateImage
                $.ajax(params)


        $('#gameModal').on 'show.bs.modal',
                (e)->
                        game_id = $(e.relatedTarget).attr('data-id')
                        loadModalForGameID(game_id)

        $('#likeButton').click(
                ()->
                        remote_ip = $('#remoteIP').attr('data-ip')
                        game_id = $('#gameModal #gameID').attr('data-id')
                        url = '/games/' + game_id + '/like'
                        params =
                                url:     url
                                method: 'POST'
                                data:   {remote_ip: remote_ip}
                        $.ajax(params).done(
                                loadModalForGameID(game_id)
                        )
        )

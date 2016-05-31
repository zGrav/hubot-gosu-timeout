# Description:
#   Timeout a user for 15 seconds
#
# Dependencies:
#   None
#
# Configuration:
#   None
#

class Functions
    findKeyIndex: (arr, key, val) ->
        i = 0

        while i < arr.length
            if arr[i][key] == val
                return i
            i++
        null

    timeoutUser: (hubid, userid, username) ->
        query = {
            "hub_id": hubid,
            "editer_id": global.user_id,
            "user_id": userid,
            "type": 5,
            "fetch_existing": true,
            "fetch_pending": true,
            "fetch_banned": true,
            "ban_duration": 15
        }

        string_query = JSON.stringify(query)
        content_length = string_query.length

        robot.http(global.api + "/hub/#{hubid}/members")
        .headers('Accept': 'application/json', 'Content-Type': 'application/json', 'Content-Length': content_length, 'X-Token': global.user_token)
        .post() (err, res, body) ->
            try
              if res.statusCode isnt 200
                  robot.logger.error "Oh no! We errored under API :( - Response Code: #{res.statusCode}"
                  return

              robot.logger.info "User #{username} banned for 15 seconds."
            catch error
                robot.logger.error "Oh no! We errored :( - #{error} - API Response Code: #{res.statusCode}"

module.exports = (robot) ->
    funcs = new Functions

    robot.hear /capslock/i, (msg) ->
        getIdx = funcs.findKeyIndex(global.channels_by_index, 'id', msg.envelope.room)

        funcs.timeoutUser(global.channels_by_index[getIdx].hub_id, msg.envelope.user.id, msg.envelope.user.name)

        msg.reply "You have been timed out for 15 seconds due to triggering spam detection!"

    robot.hear /uppercase > lowercase/i, (msg) ->
        getIdx = funcs.findKeyIndex(global.channels_by_index, 'id', msg.envelope.room)

        funcs.timeoutUser(global.channels_by_index[getIdx].hub_id, msg.envelope.user.id, msg.envelope.user.name)

        msg.reply "You have been timed out for 15 seconds due to triggering spam detection!"

    robot.hear /word repetition/i, (msg) ->
        getIdx = funcs.findKeyIndex(global.channels_by_index, 'id', msg.envelope.room)

        funcs.timeoutUser(global.channels_by_index[getIdx].hub_id, msg.envelope.user.id, msg.envelope.user.name)

        msg.reply "You have been timed out for 15 seconds due to triggering spam detection!"

    robot.hear /letter repetition/i, (msg) ->
        getIdx = funcs.findKeyIndex(global.channels_by_index, 'id', msg.envelope.room)

        funcs.timeoutUser(global.channels_by_index[getIdx].hub_id, msg.envelope.user.id, msg.envelope.user.name)

        msg.reply "You have been timed out for 15 seconds due to triggering spam detection!"

    robot.hear /random text/i, (msg) ->
        getIdx = funcs.findKeyIndex(global.channels_by_index, 'id', msg.envelope.room)

        funcs.timeoutUser(global.channels_by_index[getIdx].hub_id, msg.envelope.user.id, msg.envelope.user.name)

        msg.reply "You have been timed out for 15 seconds due to triggering spam detection!"

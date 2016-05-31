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

    timeoutUser: (hubid, userid) ->
            string hub_id = 1;
            string editer_id = 2;
            string user_id = 3;
            string email = 4;
            MembershipEntry.MembershipType type = 5;
            bool fetch_existing = 6;
            bool fetch_pending = 7;
            bool fetch_banned = 8;
            int64 ban_duration = 9;
        query = {
            "hub_id": hubid,
            #"editer_id": global.user_id,
            "user_id": userid,
            "email": null,
            "type": "BANNED",
            "fetch_existing": false,
            "fetch_pending": false,
            "fetch_banned": false,
            "ban_duration": 10
        }

        string_query = JSON.stringify(query)
        content_length = string_query.length

        robot.http(global.api + "/hub/" + hubid + "/members")
        .headers('Accept': 'application/json', 'Content-Type': 'application/json', 'Content-Length': content_length, 'X-Token': global.user_token)
        .post() (err, res, body) ->
            try
              if res.statusCode isnt 200
                  robot.logger.error "Oh no! We errored under API :( - Response Code: #{res.statusCode}"
                  return

              robot.logger.info "User #{msg.envelope.user.display_name} banned for 10 seconds."
            catch error
                robot.logger.error "Oh no! We errored :( - #{error} - API Response Code: #{res.statusCode}"

module.exports = (robot) ->
    funcs = new Functions

    robot.hear /capslock/i, (msg) ->
        getIdx = funcs.findKeyIndex(global.channels_by_index, 'id', msg.envelope.channel)

        funcs.timeoutUser(global.channels_by_index[getIdx].hub_id, msg.envelope.user.id)

        msg.reply "You have been timed out for 15 seconds due to triggering spam detection!"

    robot.hear /uppercase > lowercase/i, (msg) ->
        getIdx = funcs.findKeyIndex(global.channels_by_index, 'id', msg.envelope.channel)

        funcs.timeoutUser(global.channels_by_index[getIdx].hub_id, msg.envelope.user.id)

        msg.reply "You have been timed out for 15 seconds due to triggering spam detection!"

    robot.hear /word repetition/i, (msg) ->
        getIdx = funcs.findKeyIndex(global.channels_by_index, 'id', msg.envelope.channel)

        funcs.timeoutUser(global.channels_by_index[getIdx].hub_id, msg.envelope.user.id)

        msg.reply "You have been timed out for 15 seconds due to triggering spam detection!"

    robot.hear /letter repetition/i, (msg) ->
        getIdx = funcs.findKeyIndex(global.channels_by_index, 'id', msg.envelope.channel)

        funcs.timeoutUser(global.channels_by_index[getIdx].hub_id, msg.envelope.user.id)

        msg.reply "You have been timed out for 15 seconds due to triggering spam detection!"

    robot.hear /random text/i, (msg) ->
        getIdx = funcs.findKeyIndex(global.channels_by_index, 'id', msg.envelope.channel)

        funcs.timeoutUser(global.channels_by_index[getIdx].hub_id, msg.envelope.user.id)

        msg.reply "You have been timed out for 15 seconds due to triggering spam detection!"

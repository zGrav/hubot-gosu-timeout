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

    timeoutUser: (channelID, userID, username, reason) ->
        query = {
            "duration": 15,
            "reason": reason
        }

        string_query = JSON.stringify(query)
        content_length = string_query.length

        robot.http(global.api + "/channel/#{channelID}/timeout/#{userID}")
        .headers('Accept': 'application/json', 'Content-Type': 'application/json', 'Content-Length': content_length, 'X-Token': global.user_token)
        .post(string_query) (err, res, body) ->
            try
              if res.statusCode isnt 200
                  robot.logger.error "Oh no! We errored under API :( - Response Code: #{res.statusCode}"
                  return

               robot.logger.info "User #{username} timed out for 15 seconds."
            catch error
                robot.logger.error "Oh no! We errored :( - #{error} - API Response Code: #{res.statusCode}"

module.exports = (robot) ->
    funcs = new Functions

    robot.hear /spamscript: capslock/i, (msg) ->
        getIdx = funcs.findKeyIndex(global.channels_by_index, 'id', msg.envelope.room)
        hubid = global.channels_by_index[getIdx].hub_id

        robot.http(global.api + "/hub/#{hubid}/members?fetch-existing=true&from=0&size=40")
        .headers('Accept': 'application/json', 'Content-Type': 'application/json', 'X-Token': global.user_token)
        .get() (err, res, body) ->
            result = JSON.parse(body)

            i = 0

            while i < result.existing_users.length
                if result.existing_users[i].user_id == global.user_id #selfperm check
                    if result.existing_users[i].type == 25 and global.is_sysop == false
                        global.robot.logger.warning("No permissions to timeout user: #{msg.envelope.user.name} on channel: #{msg.envelope.room} belonging to hub: #{hubid}")
                    else if global.is_sysop == true
                        funcs.timeoutUser(msg.envelope.room, msg.envelope.user.id, msg.envelope.user.name, msg.envelope.message.text)
                        msg.reply "You have been timed out for 15 seconds due to triggering spam detection!"
                    else if result.existing_users[i].type == 50
                        funcs.timeoutUser(msg.envelope.room, msg.envelope.user.id, msg.envelope.user.name, msg.envelope.message.text)
                        msg.reply "You have been timed out for 15 seconds due to triggering spam detection!"
                    else if result.existing_users[i].type == 75
                        funcs.timeoutUser(msg.envelope.room, msg.envelope.user.id, msg.envelope.user.name, msg.envelope.message.text)
                        msg.reply "You have been timed out for 15 seconds due to triggering spam detection!"
                i++

    robot.hear /spamscript: uppercase > lowercase/i, (msg) ->
        getIdx = funcs.findKeyIndex(global.channels_by_index, 'id', msg.envelope.room)
        hubid = global.channels_by_index[getIdx].hub_id

        robot.http(global.api + "/hub/#{hubid}/members?fetch-existing=true&from=0&size=40")
        .headers('Accept': 'application/json', 'Content-Type': 'application/json', 'X-Token': global.user_token)
        .get() (err, res, body) ->
            result = JSON.parse(body)

            i = 0

            while i < result.existing_users.length
                if result.existing_users[i].user_id == global.user_id #selfperm check
                    if result.existing_users[i].type == 25
                        global.robot.logger.warning("No permissions to timeout user: #{msg.envelope.user.name} on channel: #{msg.envelope.room} belonging to hub: #{hubid}")
                    else if result.existing_users[i].type == 50
                        funcs.timeoutUser(msg.envelope.room, msg.envelope.user.id, msg.envelope.user.name, msg.envelope.message.text)
                        msg.reply "You have been timed out for 15 seconds due to triggering spam detection!"
                    else if result.existing_users[i].type == 75
                        funcs.timeoutUser(msg.envelope.room, msg.envelope.user.id, msg.envelope.user.name, msg.envelope.message.text)
                        msg.reply "You have been timed out for 15 seconds due to triggering spam detection!"
                i++

    robot.hear /spamscript: emoji repetition/i, (msg) ->
        getIdx = funcs.findKeyIndex(global.channels_by_index, 'id', msg.envelope.room)
        hubid = global.channels_by_index[getIdx].hub_id

        robot.http(global.api + "/hub/#{hubid}/members?fetch-existing=true&from=0&size=40")
        .headers('Accept': 'application/json', 'Content-Type': 'application/json', 'X-Token': global.user_token)
        .get() (err, res, body) ->
            result = JSON.parse(body)

            i = 0

            while i < result.existing_users.length
                if result.existing_users[i].user_id == global.user_id #selfperm check
                    if result.existing_users[i].type == 25
                        global.robot.logger.warning("No permissions to timeout user: #{msg.envelope.user.name} on channel: #{msg.envelope.room} belonging to hub: #{hubid}")
                    else if result.existing_users[i].type == 50
                        funcs.timeoutUser(msg.envelope.room, msg.envelope.user.id, msg.envelope.user.name, msg.envelope.message.text)
                        msg.reply "You have been timed out for 15 seconds due to triggering spam detection!"
                    else if result.existing_users[i].type == 75
                        funcs.timeoutUser(msg.envelope.room, msg.envelope.user.id, msg.envelope.user.name, msg.envelope.message.text)
                        msg.reply "You have been timed out for 15 seconds due to triggering spam detection!"
                i++

    robot.hear /spamscript: word repetition/i, (msg) ->
        getIdx = funcs.findKeyIndex(global.channels_by_index, 'id', msg.envelope.room)
        hubid = global.channels_by_index[getIdx].hub_id

        robot.http(global.api + "/hub/#{hubid}/members?fetch-existing=true&from=0&size=40")
        .headers('Accept': 'application/json', 'Content-Type': 'application/json', 'X-Token': global.user_token)
        .get() (err, res, body) ->
            result = JSON.parse(body)

            i = 0

            while i < result.existing_users.length
                if result.existing_users[i].user_id == global.user_id #selfperm check
                    if result.existing_users[i].type == 25
                        global.robot.logger.warning("No permissions to timeout user: #{msg.envelope.user.name} on channel: #{msg.envelope.room} belonging to hub: #{hubid}")
                    else if result.existing_users[i].type == 50
                        funcs.timeoutUser(msg.envelope.room, msg.envelope.user.id, msg.envelope.user.name, msg.envelope.message.text)
                        msg.reply "You have been timed out for 15 seconds due to triggering spam detection!"
                    else if result.existing_users[i].type == 75
                        funcs.timeoutUser(msg.envelope.room, msg.envelope.user.id, msg.envelope.user.name, msg.envelope.message.text)
                        msg.reply "You have been timed out for 15 seconds due to triggering spam detection!"
                i++

    robot.hear /spamscript: letter repetition/i, (msg) ->
        getIdx = funcs.findKeyIndex(global.channels_by_index, 'id', msg.envelope.room)
        hubid = global.channels_by_index[getIdx].hub_id

        robot.http(global.api + "/hub/#{hubid}/members?fetch-existing=true&from=0&size=40")
        .headers('Accept': 'application/json', 'Content-Type': 'application/json', 'X-Token': global.user_token)
        .get() (err, res, body) ->
            result = JSON.parse(body)

            i = 0

            while i < result.existing_users.length
                if result.existing_users[i].user_id == global.user_id #selfperm check
                    if result.existing_users[i].type == 25
                        global.robot.logger.warning("No permissions to timeout user: #{msg.envelope.user.name} on channel: #{msg.envelope.room} belonging to hub: #{hubid}")
                    else if result.existing_users[i].type == 50
                        funcs.timeoutUser(msg.envelope.room, msg.envelope.user.id, msg.envelope.user.name, msg.envelope.message.text)
                        msg.reply "You have been timed out for 15 seconds due to triggering spam detection!"
                    else if result.existing_users[i].type == 75
                        funcs.timeoutUser(msg.envelope.room, msg.envelope.user.id, msg.envelope.user.name, msg.envelope.message.text)
                        msg.reply "You have been timed out for 15 seconds due to triggering spam detection!"
                i++

    robot.hear /spamscript: random text/i, (msg) ->
        getIdx = funcs.findKeyIndex(global.channels_by_index, 'id', msg.envelope.room)
        hubid = global.channels_by_index[getIdx].hub_id

        robot.http(global.api + "/hub/#{hubid}/members?fetch-existing=true&from=0&size=40")
        .headers('Accept': 'application/json', 'Content-Type': 'application/json', 'X-Token': global.user_token)
        .get() (err, res, body) ->
            result = JSON.parse(body)

            i = 0

            while i < result.existing_users.length
                if result.existing_users[i].user_id == global.user_id #selfperm check
                    if result.existing_users[i].type == 25
                        global.robot.logger.warning("No permissions to timeout user: #{msg.envelope.user.name} on channel: #{msg.envelope.room} belonging to hub: #{hubid}")
                    else if result.existing_users[i].type == 50
                        funcs.timeoutUser(msg.envelope.room, msg.envelope.user.id, msg.envelope.user.name, msg.envelope.message.text)
                        msg.reply "You have been timed out for 15 seconds due to triggering spam detection!"
                    else if result.existing_users[i].type == 75
                        funcs.timeoutUser(msg.envelope.room, msg.envelope.user.id, msg.envelope.user.name, msg.envelope.message.text)
                        msg.reply "You have been timed out for 15 seconds due to triggering spam detection!"
                i++

    robot.hear /spamscript: message repetition/i, (msg) ->
        getIdx = funcs.findKeyIndex(global.channels_by_index, 'id', msg.envelope.room)
        hubid = global.channels_by_index[getIdx].hub_id

        robot.http(global.api + "/hub/#{hubid}/members?fetch-existing=true&from=0&size=40")
        .headers('Accept': 'application/json', 'Content-Type': 'application/json', 'X-Token': global.user_token)
        .get() (err, res, body) ->
            result = JSON.parse(body)

            i = 0

            while i < result.existing_users.length
                if result.existing_users[i].user_id == global.user_id #selfperm check
                    if result.existing_users[i].type == 25
                        global.robot.logger.warning("No permissions to timeout user: #{msg.envelope.user.name} on channel: #{msg.envelope.room} belonging to hub: #{hubid}")
                    else if result.existing_users[i].type == 50
                        funcs.timeoutUser(msg.envelope.room, msg.envelope.user.id, msg.envelope.user.name, msg.envelope.message.text)
                        msg.reply "You have been timed out for 15 seconds due to triggering spam detection!"
                    else if result.existing_users[i].type == 75
                        funcs.timeoutUser(msg.envelope.room, msg.envelope.user.id, msg.envelope.user.name, msg.envelope.message.text)
                        msg.reply "You have been timed out for 15 seconds due to triggering spam detection!"
                i++

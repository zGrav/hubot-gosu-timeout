# Description:
#   Timeout a user for 10 seconds
#
# Dependencies:
#   None
#
# Configuration:
#   None
#

class Functions

    timeoutUser: (channelid, userid) ->
        query = {
            "channel_id": channelid,
            "kicked_id": userid,
            "ban": true,
            "ban_duration": 10
        }

        string_query = JSON.stringify(query)
        content_length = string_query.length

        robot.http(global.api + "/chat/channels/kickban")
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
        funcs.timeoutUser(msg.envelope.channel, msg.envelope.user.display_name)
        msg.send "You have been timed out for 15 seconds due to triggering spam detection!"

    robot.hear /uppercase > lowercase/i, (msg) ->
        funcs.timeoutUser(msg.envelope.channel, msg.envelope.user.display_name)
        msg.send "You have been timed out for 15 seconds due to triggering spam detection!"

    robot.hear /word repetition/i, (msg) ->
        funcs.timeoutUser(msg.envelope.channel, msg.envelope.user.display_name)
        msg.send "You have been timed out for 15 seconds due to triggering spam detection!"

    robot.hear /letter repetition/i, (msg) ->
        funcs.timeoutUser(msg.envelope.channel, msg.envelope.user.display_name)
        msg.send "You have been timed out for 15 seconds due to triggering spam detection!"

    robot.hear /random text/i, (msg) ->
        funcs.timeoutUser(msg.envelope.channel, msg.envelope.user.display_name)
        msg.send "You have been timed out for 15 seconds due to triggering spam detection!"

votesChannelFunctions = () ->

  if $('.comment-total-votes').length > 0
    App.votes_channel = App.cable.subscriptions.create {
      channel: "VotesChannel"
    },
    connected: () ->
      console.log("You have been connected")

    disconnected:() ->

    received: (data) ->
      console.log("Yay")
      $(".comment-total-votes[data-id=#{data.comment_id}]").replaceWith(data.value)

$(document).on 'turbolinks:load', votesChannelFunctions

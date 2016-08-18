votesChannelFunctions = () ->

  if $('.comment-total-votes').length > 0
    App.votes_channel = App.cable.subscriptions.create {
      channel: "VotesChannel"
    },
    connected: () ->

    disconnected:() ->

    received: () ->
      $('.comment-total-votes[data-id="<%= @vote.comment.id %>"]').html("<%= @vote.comment.total_votes%>")

$(document).on 'turbolinks:load', votesChannelFunctions

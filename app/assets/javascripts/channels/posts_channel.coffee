postsChannelFunctions = () ->

  checkMe = (comment_id, username) ->
    if $('meta[name=wizardwonka]').length < 1
      $(".commentpartial[data-id=#{comment_id}] .editdeletebutton").remove()
    $(".commentpartial[data-id=#{comment_id}]").removeClass("hidden")

  if $('.commentscontainer').length > 0
    App.posts_channel = App.cable.subscriptions.create {
      channel: "PostsChannel"
    },
    connected: () ->
      console.log("I'm loaded")

    disconnected: () ->

    received: (data) ->
      if $('.indexcomments').data().id == data.post.id && $(".comment[data-id=#{data.comment.id}]").length < 1
        $('#comments').append(data.partial)
        checkMe(data.comment.id)

$(document).on 'turbolinks:load', postsChannelFunctions

postsChannelFunctions = () ->

  checkMe = (comment_id, username) ->
    unless $('meta[name=admin]').length > 0 || $("meta[user=\"#{username}]\"").length > 0
      $("#commentpartial-#{comment_id} .editdeletebutton").remove()

  createComment = (data) ->
    console.log(data)
    if $('.indexcomments').data().id == data.post.id
      $('#comments').append(data.partial)
      checkMe(data.comment.id, data.username)

  updateComment = (data) ->
    console.log(data)
    if $('.indexcomments').data().id == data.post.id
      $("#commentpartial-#{data.comment.id}").replaceWith(data.partial)
      checkMe(data.comment.id, data.username)

  destroyComment = (data) ->
    console.log(data)
    $("#commentpartial-#{data.comment.id}").remove()

  if $('.indexcomments').length > 0
    App.posts_channel = App.cable.subscriptions.create {
      channel: "PostsChannel"
    },
    connected: () ->
      console.log("I'm loaded")

    disconnected: () ->
      console.log("I'm unloaded")

    received: (data) ->
      switch data.type
        when "create" then createComment(data)
        when "update" then updateComment(data)
        when "destroy" then destroyComment(data)

$(document).on 'turbolinks:load', postsChannelFunctions

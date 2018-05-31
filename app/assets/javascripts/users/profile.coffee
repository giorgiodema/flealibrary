
chat_controller = {}

# Hides chat when close button is clicked
chat_controller.hide_chat = () ->   
    $("[name='close_chat']").click ->
        $(this).parents(".chat_div").css("display","none")
        return


# View the selected chat from the chat index
chat_controller.show_chat = () ->   
    $(".chat_list_item").click ->
        $(".chat_div").css("display","none")
        id = $(this).children("[name='chat_id']").attr("content")
        $("#"+id.toString()).css("display","block")
        return

chat_controller.send_message = () ->
    $(".chat_div").keypress (e) ->
        if e.keyCode == 13
            msg = {
                chat_id: $(this).attr("id")
                text: $(this).children(".input_box").val()
            }
            chat_controller.post_message(msg)

        
chat_controller.post_message = (msg) ->

    token = $("[name='csrf-token']").attr("content")
    $.ajax '/send_message',
        type: 'POST'
        dataType: 'json'
        data: { msg }
        headers: {"X-CSRF-Token":token}
        error: (jqXHR, textStatus, errorThrown) ->
            console.log "error:chat_controller.post_message"
        success: (data, textStatus, jqXHR) ->
            console.log "Status:"+textStatus
            console.log "Data:"+data["myanswer"]
            $("#"+msg.chat_id).children(".input_box").val("")
            $("#"+msg.chat_id).children(".message_box").append("<li class=sent_message><p class=message_text> "+msg.text+" </p></li>")
            



$(document).ready ->

    

    chat_controller.show_chat()
    chat_controller.hide_chat()
    chat_controller.send_message()


    return

    


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
            loadDoc()
            console.log("KeyCode:"+e.keyCode)

        
loadDoc = () ->
    xhttp = new XMLHttpRequest
    ###
    xhttp.onreadystatechange = () -> 
    if this.readyState == 4 && this.status == 200) 
        document.getElementById("demo").innerHTML = this.responseText;
    ###
    xhttp.open("POST", "send_message", true);
    xhttp.setRequestHeader("Content-type", "application/json");

    body = {
        msg:"ciao"
    }

    xhttp.send(body)




$(document).ready ->


    chat_controller.show_chat()
    chat_controller.hide_chat()

    chat_controller.send_message()






    return

    
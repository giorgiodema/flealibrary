
###
$("*").click ->
    console.log("ciao")
    return
###
$(document).ready ->


    # Hides chat when close button is clicked
    $("[name='close_chat']").click ->
        $(this).parents(".chat_div").css("display","none")
        return
    

    # View the selected chat from the chat index
    $(".chat_list_item").click ->
        $(".chat_div").css("display","none")
        id = $(this).children("[name='chat_id']").attr("content")
        $("#"+id.toString()).css("display","block")
        return


    return

    
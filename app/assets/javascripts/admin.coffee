admin_search_users = () ->
    $("#users_searchbar").keyup ->


        filter = $('#users_searchbar').val().toUpperCase()
        ul = $("#admin_users_list")

        for item in $(ul).children()
            a = $(item).children("a")
            if $(a).text().toUpperCase().indexOf(filter) ==0
                $(item).css("display","")
            else
                $(item).css("display","none")

        return

$(document).ready ->

    admin_search_users()






    return
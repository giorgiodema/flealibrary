# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/




hide_flash_container = () ->   
    $(".flash_container").hover ->
        $(this).hide "slow",() -> 
            $(this).remove()
            return
        return



$(document).ready ->

    
    hide_flash_container()


    return
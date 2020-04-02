$(document).ready(function(){

    "use strict";

    $(".add_more").on("click", function(){
        $(this).parent().next().css({"display":"block"})
    })

});

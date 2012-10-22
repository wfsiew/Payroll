var app = ( function() {

    function init() {
      menu.init();
      utils.init_progress();
      utils.init_server_error_dialog();
    }

    return {
      init : init
    };
}());

$(app.init);
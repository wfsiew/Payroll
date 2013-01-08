var app = ( function() {

    function init() {
      menu.init();
      utils.init_progress();
      utils.init_server_error_dialog();
      theme.init();
      $('#menu_user').addClass('menu_active');
      user.load();
    }

    return {
      init : init
    };
}());

$(app.init);
var app = ( function() {

    function init() {
      menu.init();
      utils.init_progress();
      utils.init_server_error_dialog();
      theme.init();
      $('#menu_emp').addClass('menu_active');
      emp.load();
    }

    return {
      init : init
    };
}());

$(app.init);
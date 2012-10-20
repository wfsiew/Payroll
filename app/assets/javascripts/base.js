var app = ( function() {

    function init() {
      menu.init();
      utils.init_progress();
      utils.init_server_error_dialog();
    }

    function getUrl(a) {
      return a;
    }

    return {
      init : init,
      getUrl : getUrl
    };
}());

$(app.init); 
var payroll = ( function() {
    var url = {
      list : '/payroll/list/',
      report : '/payroll/report/'
    };

    function func_generate(id) {
      if (!id)
        return false;

      id = utils.get_itemid(id);
      var month = $('#id_monthselect').val();
      var f = 'width=800,height=400,menubar=1';
      open(url.report + id + '/' + month, '_blank', f);
      return false;
    }

    function init_list() {
      utils.bind_hoverlist($('.list_table tbody tr'));
      $('.list_table tbody').selectable({
        selected : function(evt, ui) {
          var id = ui.selected.id;
          func_generate(id);
        }
      });
    }

    function init() {
      $('#id_find').click(nav_list.show_list);
      $('#id_display,#id_selection').change(nav_list.show_list);
      $('#id_query').keypress(nav_list.query_keypress);
      $('#id_query').keyup(nav_list.query_keyup);
      utils.init_alert_dialog('#dialog-message');
      utils.bind_hover($('#id_find'));
      nav_list.config.list_url = url.list;
      nav_list.config.list_func = init_list;
      nav_list.init();
    }

    function load() {
      return menu.get('/payroll/', init);
    }

    return {
      load : load
    };
}());
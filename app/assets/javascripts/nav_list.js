var nav_list = ( function() {
    var config = {
      list_url : '',
      list_func : null,
      del_func : null
    };

    /**
     * @public
     * This function shows the list, and reset back the page number to 1.
     */
    function show_list() {
      $('#id_display').data('pgnum', 1);
      update_list();
    }

    /**
     * @public
     * This function reloads the list by using the same navigation parameters such as the
     * display size, current page no., and search parameters.
     */
    function update_list() {
      var d = $('#id_display').val();
      var pgnum = $('#id_display').data('pgnum');
      var s = get_search_query();
      $('#right_box').load(config.list_url + '?pgnum=' + pgnum + '&pgsize=' + d + s, init_navigate);
    }

    /**
     * @private
     * This function navigate the list to the previous page.
     */
    function go_prev() {
      var val = $('#id_pg').val();
      var arr = val.split(',');
      var d = $('#id_display').val();
      $('#id_display').data('pgnum', arr[2]);
      update_list();
    }

    /**
     * @private
     * This function navigate the list to the next page.
     */
    function go_next() {
      var val = $('#id_pg').val();
      var arr = val.split(',');
      var d = $('#id_display').val();
      $('#id_display').data('pgnum', arr[3]);
      update_list();
    }

    /**
     * @public
     * This function handles the keypress event on the search textbox.
     * It checks for <enter> key.
     */
    function query_keypress(evt) {
      if (evt.keyCode == '13') {
        evt.preventDefault();
        evt.stopPropagation();
        show_list();
      }
    }

    /**
     * @public
     * This function handles the keyup event on the search textbox.
     * It checks for <enter> key.
     */
    function query_keyup(evt) {
      if (evt.keyCode != '13')
        utils.countdown_filter(show_list);
    }

    /**
     * @public
     * This function sets the item text,
     * i.e 1 to 2 of 2
     * @param arg The text.
     */
    function set_item_msg(arg) {
      $('.item_display').text(arg);
    }

    /**
     * @private
     * This function initialize the navigation elements after the list has been loaded.
     * The initialization includes :<br>
     * 1. sets the page no. to 1<br>
     * 2. enable/disable the next/prev buttons<br>
     * 3. initialize the edit/delete/clone buttons
     */
    function init_navigate() {
      $('#id_display').data('pgnum', 1);
      if ($.isFunction(config.list_func))
        config.list_func();

      var val = $('#id_pg').val();
      var arr = val.split(',');
      if (arr[0] == '0') {
        utils.set_disabled('#id_prev', 1, null);
      }
      
      else {
        utils.set_disabled('#id_prev', 0, go_prev);
      }

      if (arr[1] == '0') {
        utils.set_disabled('#id_next', 1, null);
      }
      
      else {
        utils.set_disabled('#id_next', 0, go_next);
      }
      
      if ($.isFunction(config.del_func)) {
        if ($('.list_table').length > 0)
          utils.set_disabled('#id_delete', 0, config.del_func);
          
        else
          utils.set_disabled('#id_delete', 1, null);
      }

      set_item_msg(arr[4]);
    }

    /**
     * @private
     * This function returns the search query string based on the search parameters.
     * @return The search query string.
     */
    function get_search_query() {
      var id_selection = $('#id_selection');
      var search_by_qry = (id_selection[0] == null ? '' : '&find=' + id_selection.val());
      var keyword = $('#id_query').val();
      var s = (search_by_qry == '&find=0' && keyword == '' ? '' : search_by_qry + '&keyword=' + encodeURIComponent(keyword));
      return s;
    }

    function init() {
      init_navigate();
    }

    return {
      init : init,
      config : config,
      show_list : show_list,
      update_list : update_list,
      query_keypress : query_keypress,
      query_keyup : query_keyup,
      set_item_msg : set_item_msg
    };
}());
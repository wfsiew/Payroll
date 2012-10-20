var emp = ( function() {
    var url = {
      add : app.getUrl('/employee/add/'),
      edit : app.getUrl('/employee/edit/'),
      del : app.getUrl('/employee/delete/'),
      list : app.getUrl('/employee/list/')
    };

    var popup_dialog_opt = null;

    function init_ui_opt() {
      popup_dialog_opt = {
        autoOpen : false,
        width : 350,
        resizable : false,
        draggable : true,
        modal : false,
        stack : true,
        zIndex : 1000
      };
    }

    function show_form() {
      $('#dialog_add_body').load(url.add, function() {
        $('.save_button.save').click(func_save);
        $('.save_button.cancel').click(func_cancel_add);
        utils.bind_hover($('.save_button'));
        $('#dialog-add').dialog('open');
      });
    }

    function save_success() {
      func_cancel_add();
      nav_list.show_list();
    }

    function update_success() {
      func_cancel_edit();
      nav_list.show_list();
    }

    function func_cancel_add() {
      $('#dialog-add').dialog('close');
      return false;
    }

    function func_cancel_edit() {
      $('#dialog-edit').dialog('close');
      return false;
    }

    function func_save() {
      var data = get_data('add');
      $('#add-form input').next().remove();
      $('#add-form select').next().remove();
      $.post(url.add, data, function(result) {
        if (result.success == 1)
          save_success();
          
        else if (result.error == 1) {
          for (var e in result.errors) {
            var d = $('#error_' + e).get(0);
            if (!d) {
              var o = {
                field : e,
                msg : result.errors[e]
              };
              var h = new EJS({
                url : app.getUrl('/media/tpl/label_error.html'),
                ext : '.html'
              }).render(o);
              if (e == 'designation.id')
                $("#add-form select[name='" + e + "']").after(h);
              
              else
                $("#add-form input[name='" + e + "']").after(h);
            }
          }
        }
        
        else
          utils.show_dialog(2, result);
      });

      return false;
    }

    function func_edit(id) {
      if (!id)
        return false;

      id = utils.get_itemid(id);
      $('#dialog_edit_body').load(url.edit + id, function() {
        $('.save_button.save').click(function() {
          return func_update(id);
        });
        $('.save_button.cancel').click(func_cancel_edit);
        utils.bind_hover($('.save_button'));
        $('#dialog-edit').dialog('open');
      });
      return false;
    }

    function func_update(id) {
      var data = get_data('edit');
      $('#edit-form input').next().remove();
      $('#edit-form select').next().remove();
      $.post(url.edit + id, data, function(result) {
        if (result.success == 1)
          update_success();
        
        else if (result.error == 1) {
          for (var e in result.errors) {
            var d = $('#error_' + e).get(0);
            if (!d) {
              var o = {
                field : e,
                msg : result.errors[e]
              };
              var h = new EJS({
                url : app.getUrl('/media/tpl/label_error.html'),
                ext : '.html'
              }).render(o);
              if (e == 'designation.id')
                $("#edit-form select[name='" + e + "']").after(h);
              
              else
                $("#edit-form input[name='" + e + "']").after(h);
            }
          }
        }
        
        else
          utils.show_dialog(2, result);
      });

      return false;
    }

    function func_delete() {
      var a = $('.chk:checked');
      if (a.length < 1) {
        utils.show_dialog(2, 'Please select record(s).');
        return;
      }

      var l = [];
      var trlist = [];
      a.each(function(idx, elm) {
        var id = $(this).parent().parent().attr('id');
        trlist.push('#' + id);
        id = utils.get_itemid(id);
        l.push(id);
      });

      var arg = l.join(',');
      var val = $('#id_pg').val();
      var arr = val.split(',');
      var currpg = parseInt(arr[3], 10); --currpg;
      var pgsize = $('#id_display').val();
      var search_by = $('#id_selection').val();
      var keyword = $('#id_query').val();
      var data = {
        id : arg,
        pgnum : currpg,
        pgsize : pgsize,
        find : search_by,
        keyword : keyword
      };

      $.post(url.del, data, function(result) {
        if (result.success == 1) {
          nav_list.set_item_msg(result.itemscount);
          var tr = $(trlist.join(','));
          tr.remove();
          delete tr;
        }
      });
    }

    function select_all() {
      var a = $(this).attr('checked');
      if (a == 'checked')
        $('.chk').attr('checked', 'checked');
      
      else
        $('.chk').removeAttr('checked');
    }

    function get_data(t) {
      var form = (t == 'add' ? $('#add-form') : $('#edit-form'));

      var data = {
        code : form.find('#id_code').val(),
        icNo : form.find('#id_icno').val(),
        firstName : form.find('#id_firstname').val(),
        middleName : form.find('#id_middlename').val(),
        lastName : form.find('#id_lastname').val(),
        'designation.id' : form.find('#id_designation').val(),
        'designation.title' : form.find('#id_designation option:selected').text(),
        epfNo : form.find('#id_epfno').val(),
        socso : form.find('#id_socso').val(),
        salary : form.find('#id_salary').val(),
        'address.street' : form.find('#id_street').val(),
        'address.city' : form.find('#id_city').val(),
        'address.state' : form.find('#id_state').val(),
        'address.postalCode' : form.find('#id_postalcode').val(),
        'address.country' : form.find('#id_country').val()
      };

      return data;
    }

    function init_list() {
      $('.hdchk').click(select_all);
      utils.bind_hoverlist($('.list_table tbody tr'));
      $('.list_table tbody').selectable({
        selected : function(evt, ui) {
          var id = ui.selected.id;
          func_edit(id);
        }
      });
    }

    function init() {
      init_ui_opt();
      $('#id_add').click(show_form);
      $('#id_delete').click(func_delete);
      $('#id_find').click(nav_list.show_list);
      $('#id_display,#id_selection').change(nav_list.show_list);
      $('#id_query').keypress(nav_list.query_keypress);
      $('#id_query').keyup(nav_list.query_keyup);
      $('#dialog-add').dialog(popup_dialog_opt);
      $('#dialog-edit').dialog(popup_dialog_opt);
      utils.init_alert_dialog('#dialog-message');
      utils.bind_hover($('#id_add,#id_delete,#id_find'));
      nav_list.config.list_url = url.list;
      nav_list.config.list_func = init_list;
      nav_list.init();
    }

    function load() {
      return menu.get(app.getUrl('/employee/'), init);
    }

    return {
      load : load
    };
}()); 
var sort = ( function() {
    var icon = 'ui-icon';
    var icon_asc = 'ui-icon-triangle-1-n';
    var icon_desc = 'ui-icon-triangle-1-s';

    function set_sort_css(o) {
      var c = o.children().last();
      var id = o.attr('id');
      id = utils.get_itemid(id);
      var column = utils.safe_replace(id, '-', '.');
      var sort = {
        column : column,
        dir : 'ASC'
      };

      var isasc = c.hasClass(icon_asc);

      $('.sorticon').removeClass(icon + ' ' + icon_asc + ' ' + icon_desc);

      if (isasc) {
        c.addClass(icon +' ' + icon_desc);
        sort['dir'] = 'desc';
      }
      
      else {
        c.addClass(icon + ' ' + icon_asc);
      }
      
      return sort;
    }
    
    function init_sort(o, dir) {
      var c = (dir == 'ASC' ? icon_asc : icon_desc);
      o.children().last().addClass(icon + ' ' + c);
    }
    
    return {
      set_sort_css : set_sort_css,
      init_sort : init_sort
    }
}());
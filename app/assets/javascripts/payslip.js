var payslip = ( function() {
    function init() {
      utils.bind_hover($('.print_button'));
      $('.print_button').click(function() {
        print();
      });
      var w = opener;
      var theme = w.theme.current_theme;
      $.themes.init({defaultTheme : theme});
    }

    return {
      init : init
    };
}());

$(document).ready(payslip.init);
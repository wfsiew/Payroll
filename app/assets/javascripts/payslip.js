var payslip = ( function() {
    function init() {
      utils.bind_hover($('.print_button'));
      $('.print_button').click(function() {
        print();
      });
    }

    return {
      init : init
    };
}());

$(document).ready(payslip.init); 
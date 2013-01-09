var cht = ( function() {

    // Radialize the colors
    Highcharts.getOptions().colors = $.map(Highcharts.getOptions().colors, function(color) {
      return {
        radialGradient : {
          cx : 0.5,
          cy : 0.3,
          r : 0.7
        },
        stops : [[0, color], [1, Highcharts.Color(color).brighten(-0.3).get('rgb')] // darken
        ]
      };
    });

    function init() {
      $.getJSON('/admin/chart/data/', null, function(result) {
        chart1(result.pie);
        chart2(result.column);
      });
    }

    function chart1(result) {
      // Build the chart
      var chart = new Highcharts.Chart({
        chart : {
          renderTo : 'cht1',
          plotBackgroundColor : null,
          plotBorderWidth : null,
          plotShadow : false
        },
        title : {
          text : 'Hourly Payroll for 2012'
        },
        tooltip : {
          pointFormat : '{series.name}: <b>{point.percentage}%</b>',
          percentageDecimals : 1
        },
        plotOptions : {
          pie : {
            allowPointSelect : true,
            cursor : 'pointer',
            dataLabels : {
              enabled : true,
              color : '#000000',
              connectorColor : '#000000',
              formatter : function() {
                return '<b>' + this.point.name + '</b>: ' + this.percentage.toFixed(2) + ' %';
              }
            }
          }
        },
        series : [{
          type : 'pie',
          name : 'Hourly Payroll for 2012',
          data : result
        }]
      });
    }

    function chart2(result) {
      var chart = new Highcharts.Chart({
        chart : {
          renderTo : 'cht2',
          type : 'column'
        },
        title : {
          text : 'Hourly Payroll for 2012'
        },
        subtitle : {
          text : ''
        },
        xAxis : {
          categories : ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
        },
        yAxis : {
          min : 0,
          title : {
            text : 'Hourly Payroll for 2012'
          }
        },
        legend : {
          layout : 'vertical',
          backgroundColor : '#FFFFFF',
          align : 'left',
          verticalAlign : 'top',
          x : 100,
          y : 70,
          floating : true,
          shadow : true
        },
        tooltip : {
          formatter : function() {
            return '' + this.x + ': ' + this.y;
          }
        },
        plotOptions : {
          column : {
            pointPadding : 0.2,
            borderWidth : 0
          }
        },
        series : [{
          name : 'Hourly Payroll',
          data : result,
          showInLegend : false
        }]
      });
    }

    function load() {
      menu.get('/admin/chart/', init);
    }

    return {
      load : load
    };
  }());

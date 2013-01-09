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
      chart1();
      chart2();
    }

    function chart1() {

      // Build the chart
      var chart = new Highcharts.Chart({
        chart : {
          renderTo : 'cht',
          plotBackgroundColor : null,
          plotBorderWidth : null,
          plotShadow : false
        },
        title : {
          text : 'Browser market shares at a specific website, 2010'
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
                return '<b>' + this.point.name + '</b>: ' + this.percentage + ' %';
              }
            }
          }
        },
        series : [{
          type : 'pie',
          name : 'Payroll for 2013',
          data : [['January', 10], ['February', 10], ['March', 10], ['April', 40], ['May', 5], ['June', 5], ['July', 5], ['August', 5], {
            name : 'September',
            y : 12.8,
            sliced : true,
            selected : true
          }, ['October', 5], ['November', 3], ['December', 2]]
        }]
      });
    }

    function chart2() {
      var chart = new Highcharts.Chart({
        chart : {
          renderTo : 'cht1',
          type : 'column'
        },
        title : {
          text : 'Monthly Average Rainfall'
        },
        subtitle : {
          text : 'Source: WorldClimate.com'
        },
        xAxis : {
          categories : ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
        },
        yAxis : {
          min : 0,
          title : {
            text : 'Rainfall (mm)'
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
            return '' + this.x + ': ' + this.y + ' mm';
          }
        },
        plotOptions : {
          column : {
            pointPadding : 0.2,
            borderWidth : 0
          }
        },
        series : [{
          name : 'Tokyo',
          data : [49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4]

        }, {
          name : 'New York',
          data : [83.6, 78.8, 98.5, 93.4, 106.0, 84.5, 105.0, 104.3, 91.2, 83.5, 106.6, 92.3]

        }, {
          name : 'London',
          data : [48.9, 38.8, 39.3, 41.4, 47.0, 48.3, 59.0, 59.6, 52.4, 65.2, 59.3, 51.2]

        }, {
          name : 'Berlin',
          data : [42.4, 33.2, 34.5, 39.7, 52.6, 75.5, 57.4, 60.4, 47.6, 39.1, 46.8, 51.1]

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
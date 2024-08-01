/*
 ***
 ***
 Name: 			admin.js
 Written by: 	ThemeTrade 
 Theme Version:	1.0.0
 ***
 ***
 */
(function ($) {

    'use strict';

    var AdminBuilder = function () {

        var checkSelectorExistence = function (selectorName) {
            if (jQuery(selectorName).length > 0) {
                return true;
            } else {
                return false;
            }
        };

        var searchToggle = function () {
            $(".ttr-search-toggle").on("click", function (e) {
                e.preventDefault();
                $(".ttr-search-bar").toggleClass("active");
            })
        };

        var closeNav = function () {
            $(".ttr-overlay, .ttr-sidebar-toggle-button").on("click", function () {
                $("body").removeClass("ttr-opened-sidebar"), $("body").removeClass("ttr-body-fixed");
            })
        };

        var leftSidebar = function () {

            $(".ttr-toggle-sidebar").on("click", function () {
                if ($("body").hasClass("ttr-opened-sidebar")) {
                    $("body").removeClass("ttr-opened-sidebar"), $("body").removeClass("ttr-body-fixed");
                } else {
                    $(window).width() < 760 && $("body").addClass("ttr-body-fixed"), $("body").addClass("ttr-opened-sidebar");
                }
            });

            $(".ttr-sidebar-pin-button").on("click", function () {
                $("body").toggleClass("ttr-pinned-sidebar");
            });

            $(".ttr-sidebar-navi li.show > ul").slideDown(200);
            $(".ttr-sidebar-navi a").on("click", function (e) {
                var a = $(this);
                $(this).next().is("ul") ? (e.preventDefault(), a.parent().hasClass("show") ? (a.parent().removeClass("show"), a.next().slideUp(200)) : (a.parent().parent().find(".show ul").slideUp(200), a.parent().parent().find("li").removeClass("show"), a.parent().toggleClass("show"), a.next().slideToggle(200))) : (a.parent().parent().find(".show ul").slideUp(200), a.parent().parent().find("li").removeClass("show"), a.parent().addClass("show"))
            });

        };

        var waveEffect = function (e, a) {
            var s = ".ttr-wave-effect",
                    n = e.outerWidth(),
                    t = a.offsetX,
                    i = a.offsetY;
            e.prepend('<span class="ttr-wave-effect"></span>'), $(s).css({
                top: i,
                left: t
            }).animate({
                opacity: "0",
                width: 2 * n,
                height: 2 * n
            }, 500, function () {
                e.find(s).remove()
            });
        };

        var materialButton = function () {
            $(".ttr-material-button").on("click", function (e) {
                waveEffect($(this), e)
            });
        }

        var headerSubMenu = function () {
            $(".ttr-header-submenu").show();
            $(".ttr-header-submenu").parent().find("a:first").on("click", function (e) {
                e.stopPropagation();
                e.preventDefault();
                $(this).parents(".ttr-header-navigation").find(".ttr-header-submenu").not($(this).parents("li").find(".ttr-header-submenu")).removeClass("active");
                $(this).parents("li").find(".ttr-header-submenu").show().toggleClass("active");
            });
            $(document).on("click", function (e) {
                var a = $(e.target);
                !0 === $(".ttr-header-submenu").hasClass("active") && !a.hasClass("ttr-submenu-toggle") && a.parents(".ttr-header-submenu").length < 1 && $(".ttr-header-submenu").removeClass("active"), a.parents(".ttr-search-bar").length < 1 && !a.hasClass("ttr-search-bar") && !a.parent().hasClass("ttr-search-toggle") && !a.hasClass("ttr-search-toggle") && $(".ttr-search-bar").removeClass("active")
            });
        }

        var displayLineGraphAdmin = function () {
            if (!checkSelectorExistence('#chart1')) {
                return;
            }
            Chart.defaults.global.defaultFontFamily = "rubik";
            Chart.defaults.global.defaultFontColor = '#999';
            Chart.defaults.global.defaultFontSize = '12';

            var ctx = document.getElementById('chart1').getContext('2d');

            var chart = new Chart(ctx, {
                type: 'line',

                // The data for our dataset
                data: {
                    labels: ["January", "February", "March", "April", "May", "June"],
                    // Information about the dataset
                    datasets: [{
                            label: "Total",
                            backgroundColor: 'rgba(0,0,0,0.05)',
                            borderColor: '#4c1864',
                            borderWidth: "3",
                            data: [25000, 142000, 25000, 45000, 142000, 170000],
                            pointRadius: 4,
                            pointHoverRadius: 4,
                            pointHitRadius: 10,
                            pointBackgroundColor: "#fff",
                            pointHoverBackgroundColor: "#fff",
                            pointBorderWidth: "3",
                        }]
                },

                // Configuration options
                options: {

                    layout: {
                        padding: 0,
                    },

                    legend: {display: false},
                    title: {display: false},

                    scales: {
                        yAxes: [{
                                ticks: {
                                    beginAtZero: true, // Đảm bảo trục y bắt đầu từ 0
                                    callback: function (value, index, values) {
                                        return value.toLocaleString();  // Định dạng số
                                    }
                                },
                                scaleLabel: {
                                    display: true,
                                    labelString: 'VND',
                                    fontColor: '#999',
                                    fontSize: 14,
                                    fontStyle: 'bold'
                                },
                                gridLines: {
                                    borderDash: [6, 6],
                                    color: "#ebebeb",
                                    lineWidth: 1,
                                },
                            }],
                        xAxes: [{
                                scaleLabel: {
                                    display: true,
                                    labelString: 'Month',
                                    fontColor: '#999',
                                    fontSize: 14,
                                    fontStyle: 'bold'
                                },
                                gridLines: {display: false},
                            }],
                    },

                    tooltips: {
                        backgroundColor: '#333',
                        titleFontSize: 12,
                        titleFontColor: '#fff',
                        bodyFontColor: '#fff',
                        bodyFontSize: 12,
                        displayColors: false,
                        xPadding: 10,
                        yPadding: 10,
                        intersect: false
                    }
                },
            });

        }

        var displayPieGraphAdmin = function () {

           if (!checkSelectorExistence('#chart2')) {
                return;
            }
            Chart.defaults.global.defaultFontFamily = "rubik";
            Chart.defaults.global.defaultFontColor = '#999';
            Chart.defaults.global.defaultFontSize = '12';

            var ctx = document.getElementById('chart2').getContext('2d');

            var chart = new Chart(ctx, {
                type: 'line',

                // The data for our dataset
                data: {
                    labels: ["January", "February", "March", "April", "May", "June"],
                    // Information about the dataset
                    datasets: [{
                            label: "Sách Thiếu Nhi",
                            backgroundColor: 'rgba(54, 162, 235, 0.2)',
                            borderColor: 'rgba(75, 192, 192, 1)',
                            borderWidth: "3",
                            data: [75000, 95000, 50000,80000, 20000, 110000],
                            pointRadius: 4,
                            pointHoverRadius: 4,
                            pointHitRadius: 10,
                            pointBackgroundColor: "#fff",
                            pointHoverBackgroundColor: "#fff",
                            pointBorderWidth: "3",
                        },
                        {
                            label: "Sách Kinh Tế",
                            backgroundColor: 'rgba(255, 99, 132, 0.2)',
                            borderColor: 'rgba(255, 99, 132, 1)',
                            borderWidth: "3",
                            data: [22000, 35000, 52000, 80000, 40000,40000],
                            pointRadius: 4,
                            pointHoverRadius: 4,
                            pointHitRadius: 10,
                            pointBackgroundColor: "#fff",
                            pointHoverBackgroundColor: "#fff",
                            pointBorderWidth: "3",
                        }]
                },

                // Configuration options
                options: {

                    layout: {
                        padding: 0,
                    },

                    legend: {display: false},
                    title: {display: false},

                    scales: {
                        yAxes: [{
                                ticks: {
                                    beginAtZero: true, // Đảm bảo trục y bắt đầu từ 0
                                    callback: function (value, index, values) {
                                        return value.toLocaleString();  // Định dạng số
                                    }
                                },
                                scaleLabel: {
                                    display: true,
                                    labelString: 'VND',
                                    fontColor: '#999',
                                    fontSize: 14,
                                    fontStyle: 'bold'
                                },
                                gridLines: {
                                    borderDash: [6, 6],
                                    color: "#ebebeb",
                                    lineWidth: 1,
                                },
                            }],
                        xAxes: [{
                                scaleLabel: {
                                    display: true,
                                    labelString: 'Month',
                                    fontColor: '#999',
                                    fontSize: 14,
                                    fontStyle: 'bold'
                                },
                                gridLines: {display: false},
                            }],
                    },

                    tooltips: {
                        backgroundColor: '#333',
                        titleFontSize: 12,
                        titleFontColor: '#fff',
                        bodyFontColor: '#fff',
                        bodyFontSize: 12,
                        displayColors: false,
                        xPadding: 10,
                        yPadding: 10,
                        intersect: false
                    }
                },
            });
        }
        var displayLineGraphMarketingCustomer = function () {
            if (!checkSelectorExistence('#chart3')) {
                return;
            }
            Chart.defaults.global.defaultFontFamily = "rubik";
            Chart.defaults.global.defaultFontColor = '#999';
            Chart.defaults.global.defaultFontSize = '12';

            var ctx = document.getElementById('chart3').getContext('2d');

            var chart = new Chart(ctx, {
                type: 'line',

                // The data for our dataset
                data: {
                    labels: ["January", "February", "March", "April", "May", "June"],
                    // Information about the dataset
                    datasets: [{
                            label: "Customer Number",
                            backgroundColor: 'rgba(0,0,0,0.05)',
                            borderColor: '#4c1864',
                            borderWidth: "3",
                            data: [6,1,5,4,9,12],
                            pointRadius: 4,
                            pointHoverRadius: 4,
                            pointHitRadius: 10,
                            pointBackgroundColor: "#fff",
                            pointHoverBackgroundColor: "#fff",
                            pointBorderWidth: "3",
                        }]
                },

                // Configuration options
                options: {

                    layout: {
                        padding: 0,
                    },

                    legend: {display: false},
                    title: {display: false},

                    scales: {
                        yAxes: [{
                                ticks: {
                                    beginAtZero: true, // Đảm bảo trục y bắt đầu từ 0
                                    callback: function (value, index, values) {
                                        return value.toLocaleString();  // Định dạng số
                                    }
                                },
                                scaleLabel: {
                                    display: true,
                                    labelString: 'Customer Number',
                                    fontColor: '#999',
                                    fontSize: 14,
                                    fontStyle: 'bold'
                                },
                                gridLines: {
                                    borderDash: [6, 6],
                                    color: "#ebebeb",
                                    lineWidth: 1,
                                },
                            }],
                        xAxes: [{
                                scaleLabel: {
                                    display: true,
                                    labelString: 'Month',
                                    fontColor: '#999',
                                    fontSize: 14,
                                    fontStyle: 'bold'
                                },
                                gridLines: {display: false},
                            }],
                    },

                    tooltips: {
                        backgroundColor: '#333',
                        titleFontSize: 12,
                        titleFontColor: '#fff',
                        bodyFontColor: '#fff',
                        bodyFontSize: 12,
                        displayColors: false,
                        xPadding: 10,
                        yPadding: 10,
                        intersect: false
                    }
                },
            });

        }
            var displayLineGraphMarketingPost = function () {
            if (!checkSelectorExistence('#chart4')) {
                return;
            }
            Chart.defaults.global.defaultFontFamily = "rubik";
            Chart.defaults.global.defaultFontColor = '#999';
            Chart.defaults.global.defaultFontSize = '12';

            var ctx = document.getElementById('chart4').getContext('2d');

            var chart = new Chart(ctx, {
                type: 'line',

                // The data for our dataset
                data: {
                    labels: ["January", "February", "March", "April", "May", "June"],
                    // Information about the dataset
                    datasets: [{
                            label: "Post Number",
                            backgroundColor: 'rgba(0,0,0,0.05)',
                            borderColor: '#4c1864',
                            borderWidth: "3",
                            data: [0,1,2,0,2,7],
                            pointRadius: 4,
                            pointHoverRadius: 4,
                            pointHitRadius: 10,
                            pointBackgroundColor: "#fff",
                            pointHoverBackgroundColor: "#fff",
                            pointBorderWidth: "3",
                        }]
                },

                // Configuration options
                options: {

                    layout: {
                        padding: 0,
                    },

                    legend: {display: false},
                    title: {display: false},

                    scales: {
                        yAxes: [{
                                ticks: {
                                    beginAtZero: true, // Đảm bảo trục y bắt đầu từ 0
                                    callback: function (value, index, values) {
                                        return value.toLocaleString();  // Định dạng số
                                    }
                                },
                                scaleLabel: {
                                    display: true,
                                    labelString: 'Post Number',
                                    fontColor: '#999',
                                    fontSize: 14,
                                    fontStyle: 'bold'
                                },
                                gridLines: {
                                    borderDash: [6, 6],
                                    color: "#ebebeb",
                                    lineWidth: 1,
                                },
                            }],
                        xAxes: [{
                                scaleLabel: {
                                    display: true,
                                    labelString: 'Month',
                                    fontColor: '#999',
                                    fontSize: 14,
                                    fontStyle: 'bold'
                                },
                                gridLines: {display: false},
                            }],
                    },

                    tooltips: {
                        backgroundColor: '#333',
                        titleFontSize: 12,
                        titleFontColor: '#fff',
                        bodyFontColor: '#fff',
                        bodyFontSize: 12,
                        displayColors: false,
                        xPadding: 10,
                        yPadding: 10,
                        intersect: false
                    }
                },
            });

        }
        var displayLineGraphSale = function () {

           if (!checkSelectorExistence('#chart5')) {
                return;
            }
            Chart.defaults.global.defaultFontFamily = "rubik";
            Chart.defaults.global.defaultFontColor = '#999';
            Chart.defaults.global.defaultFontSize = '12';

            var ctx = document.getElementById('chart5').getContext('2d');

            var chart = new Chart(ctx, {
                type: 'line',

                // The data for our dataset
                data: {
                    labels: ["January", "February", "March", "April", "May", "June"],
                    // Information about the dataset
                    datasets: [{
                            label: "Pending",
                            backgroundColor: 'rgba(54, 162, 235, 0.2)',
                            borderColor: 'rgba(75, 192, 192, 1)',
                            borderWidth: "3",
                            data: [0,1,1,1,2,3],
                            pointRadius: 4,
                            pointHoverRadius: 4,
                            pointHitRadius: 10,
                            pointBackgroundColor: "#fff",
                            pointHoverBackgroundColor: "#fff",
                            pointBorderWidth: "3",
                        },
                        {
                            label: "Shipping",
                            backgroundColor: 'rgba(255, 99, 132, 0.2)',
                            borderColor: 'rgba(255, 99, 132, 1)',
                            borderWidth: "3",
                            data: [0,0,0,0,0,1],
                            pointRadius: 4,
                            pointHoverRadius: 4,
                            pointHitRadius: 10,
                            pointBackgroundColor: "#fff",
                            pointHoverBackgroundColor: "#fff",
                            pointBorderWidth: "3",
                        },
                        {
                            label: "Delivered",
                            backgroundColor: 'rgba(54, 162, 235, 0.2)',
                            borderColor: 'rgba(75, 192, 192, 1)',
                            borderWidth: "3",
                            data: [0,1,2,1,0,3],
                            pointRadius: 4,
                            pointHoverRadius: 4,
                            pointHitRadius: 10,
                            pointBackgroundColor: "#fff",
                            pointHoverBackgroundColor: "#fff",
                            pointBorderWidth: "3",
                        },
                        {
                            label: "Canceled",
                            backgroundColor: 'rgba(54, 162, 235, 0.2)',
                            borderColor: 'rgba(75, 192, 192, 1)',
                            borderWidth: "3",
                            data: [0,0,0,0,0,2],
                            pointRadius: 4,
                            pointHoverRadius: 4,
                            pointHitRadius: 10,
                            pointBackgroundColor: "#fff",
                            pointHoverBackgroundColor: "#fff",
                            pointBorderWidth: "3",
                        }]
                },

                // Configuration options
                options: {

                    layout: {
                        padding: 0,
                    },

                    legend: {display: false},
                    title: {display: false},

                    scales: {
                        yAxes: [{
                                ticks: {
              
                                    callback: function (value, index, values) {
                                        return value.toLocaleString();  // Định dạng số
                                    }
                                },
                                scaleLabel: {
                                    display: true,
                                    labelString: 'Order Number',
                                    fontColor: '#999',
                                    fontSize: 14,
                                    fontStyle: 'bold'
                                },
                                gridLines: {
                                    borderDash: [6, 6],
                                    color: "#ebebeb",
                                    lineWidth: 1,
                                },
                            }],
                        xAxes: [{
                                scaleLabel: {
                                    display: true,
                                    labelString: 'Month',
                                    fontColor: '#999',
                                    fontSize: 14,
                                    fontStyle: 'bold'
                                },
                                gridLines: {display: false},
                            }],
                    },

                    tooltips: {
                        backgroundColor: '#333',
                        titleFontSize: 12,
                        titleFontColor: '#fff',
                        bodyFontColor: '#fff',
                        bodyFontSize: 12,
                        displayColors: false,
                        xPadding: 10,
                        yPadding: 10,
                        intersect: false
                    }
                },
            });
        }

        return {
            initialHelper: function () {
                searchToggle();
                closeNav();
                leftSidebar();
                materialButton();
                headerSubMenu();
//                displayLineGraphAdmin();
//                displayPieGraphAdmin();
//                displayLineGraphMarketingCustomer();
//                displayLineGraphMarketingPost();
//                displayLineGraphSale();
            }
        }

    }(jQuery);

    /* jQuery ready  */
    jQuery(document).on('ready', function () {
        AdminBuilder.initialHelper();
    });
})(jQuery);
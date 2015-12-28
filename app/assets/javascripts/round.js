// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require jquery/jquery-migrate.min
//= require plugins/smoothScroll
//= require plugins/owl-carousel/owl-carousel/owl.carousel 
//= require easyzoom

// In Page JS
function click_show_map(){
  $('#a_show_map').addClass("active");
  $('#a_show_detail').removeClass("active");
  $('#a_show_highlights').removeClass("active");

  $('#grand_map_container').removeClass("hidden");
  $('#details_container').addClass("hidden");
  $('#highlights_container').addClass("hidden");
}

function click_show_detail(){
  $('#a_show_map').removeClass("active");
  $('#a_show_detail').addClass("active");
  $('#a_show_highlights').removeClass("active");

  $('#grand_map_container').addClass("hidden");
  $('#details_container').removeClass("hidden");
  $('#highlights_container').addClass("hidden");
}

function click_show_highlights(){
  $('#a_show_map').removeClass("active");
  $('#a_show_detail').removeClass("active");
  $('#a_show_highlights').addClass("active");

  $('#grand_map_container').addClass("hidden");
  $('#details_container').addClass("hidden");
  $('#highlights_container').removeClass("hidden");
}

$(document).ready(function() {

  $("#trip_list").owlCarousel({
    items : 8, //10 items above 1000px browser width
    itemsDesktop : [1000,7], //5 items between 1000px and 901px
    itemsDesktopSmall : [900,6], // betweem 900px and 601px
    itemsTablet: [600,4], //2 items between 600 and 0
    itemsMobile : 4, // itemsMobile disabled - inherit from itemsTablet option
    navigation: false,
    pagination: true
  });

  // setup correct high
  var grand_map_container_height = $(window).height() - 86;
  $('#grand_map_container').height( grand_map_container_height );

  // initialize easy zoom
  var $easyzoom = $('.easyzoom').easyZoom();

});
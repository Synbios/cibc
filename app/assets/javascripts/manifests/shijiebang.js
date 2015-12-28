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
//= require jquery/jquery-migrate.min
//= require bootstrap
//= require plugins/back-to-top
//= require plugins/smoothScroll
//= require plugins/owl-carousel/owl-carousel/owl.carousel
//= require plugins/revolution-slider/rs-plugin/js/jquery.themepunch.tools.min
//= require plugins/revolution-slider/rs-plugin/js/jquery.themepunch.revolution.min
//= require custom
//= require app
//= require plugins/jquery.parallax

// Page JS files (some js files are built by Unify but given a name similar to independent plugin names)
//= require plugins/owl-carousel
//= require plugins/revolution-slider

// In Page JS
jQuery(document).ready(function() {
  App.init();
  OwlCarousel.initOwlCarousel();
  RevolutionSlider.initRSfullWidthD();
  App.initParallaxBg();
});
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");
require("jquery");

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
//= require materialize

import 'materialize-css/dist/js/materialize'

$(document).on('turbolinks:load', function () {
  // initialize matelialize
  $('select').formSelect();
  $('.sidenav').sidenav();
  $('.parallax').parallax();
  $('.dropdown-trigger').dropdown();
  $('.modal').modal();
});

// sidenavだけは、進む/戻るで動かなくなるので都度destroyが必要
$(document).on("turbolinks:before-cache", function () {
  $('.sidenav').sidenav('destroy');
  $('.dropdown-trigger').dropdown('destroy');
  $('.modal').modal('destroy');
});

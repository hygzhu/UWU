// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//= require jquery
//= require bootstrap
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .


//Hook to prevent turbolinks from playing autoplay videos in cache
;(function () {
    var each = Array.prototype.forEach
    var autoplayIds = []
  
    document.addEventListener('turbolinks:before-cache', function () {
      var autoplayElements = document.querySelectorAll('[autoplay]')
      each.call(autoplayElements, function (element) {
        if (!element.id) throw 'autoplay elements need an ID attribute'
        autoplayIds.push(element.id)
        element.removeAttribute('autoplay')
      })
    })
  
    document.addEventListener('turbolinks:before-render', function (event) {
      autoplayIds = autoplayIds.reduce(function (ids, id) {
        var autoplay = event.data.newBody.querySelector('#' + id)
        if (autoplay) autoplay.setAttribute('autoplay', true)
        else ids.push(id)
        return ids
      }, [])
    })
  })()